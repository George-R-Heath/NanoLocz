% DESCRIPTION:   Function written for NanoLocz-lib 2025
% ALIGN_ITERATE Iteratively aligns an image to a reference using translation and rotation.
%
%   Inputs:
%       full_img        - Original image used for detection
%       Part.Image      - Input image crops/detections to be aligned
%       Part.Locs       - Initial detection localisation coordinates (x,y,..
%       ref             - Reference image for alignment

%       Tran_Iterations - Number of translation iterations
%       Translat_Method - Method for translation alignment: 'Cross corr' or 'FFT cross'
%       Maxdrift        - Maximum allowed drift during translation

%       Rot_Iterations  - Number of rotation iterations
%       Rota_Method     - Method for rotation alignment: 'Rotation corr' or 'Polar Corr'
%       Maxang          - Maximum angle (+/-) for rotation search

%       Thresh_min      - Minimum z threshold for feature consideration
%       Autoupdateref   - Flag to auto-update the reference during iteration (true/false)
%
%   Outputs:
%       Part.Locs - Updated postion coordinates after alignment
%       Part.Image  - Aligned image
%       ref  - (Optionally updated) reference image

function [Part, ref] = align_iterate(full_img, ref, Part, Tran_Iterations,Translat_Method, Maxdrift, Rot_Iterations,Rota_Method, Maxang, Thresh_min,Autoupdateref, app)

tran_count = 0;
rot_count = 0;
total_count = 0;
n = numel(Part.Image(1,1,:));
n_iter = Tran_Iterations + Rot_Iterations;
useGUI = exist('app', 'var') && isvalid(app) && isprop(app, 'loadbar');

if useGUI
    cla(app.loadbar);
    rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
    progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', [0.30, 0.98, 0.40]);
    progressText = text(app.loadbar, 0.5, 0.5, 'Starting...', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    progressText.Color = [0,0,0];
end

while tran_count < Tran_Iterations || rot_count < Rot_Iterations

    if Thresh_min>0
        Part.Image = Part.Image.*(Part.Image>Thresh_min);
        rf = ref.*(ref>Thresh_min);
    else
        rf = ref;
    end

    if tran_count < Tran_Iterations
        total_count = total_count +1;
        tran_count = tran_count + 1;
        if useGUI
            progressBar.Position(3) = (rot_count+tran_count) / n_iter;
            progressText.String = sprintf('Iteration %d of %d', (rot_count+tran_count), n_iter);
            writeLog(app,"Translational Alignment - " + progressText.String);
            drawnow;
        end
        [x, y] = align_trans(Part.Image, rf, Maxdrift,1, Translat_Method);
        for i = 1:n
            Part.Image(:,:,i) = imtranslate(Part.Image(:,:,i), [-x(i), -y(i)] );
        end
        Part.Locs(:,1) = Part.Locs(:,1) + x;
        Part.Locs(:,2) = Part.Locs(:,2) + y;
    end

    if rot_count < Rot_Iterations
        total_count = total_count +1;
        rot_count = rot_count + 1;
        if useGUI
            progressBar.Position(3) = (rot_count+tran_count) / n_iter;
            progressText.String = sprintf('Iteration %d of %d', (rot_count+tran_count), n_iter);
            drawnow;
            writeLog(app, "Rotational Alignment - " + progressText.String);
        end
        for i = 1:n
            rot_ang(i,:) = align_rot(rf, Part.Image(:,:,i), [-Maxang, Maxang], Rota_Method);
            Part.Image(:,:,i)  = imrotate(Part.Image(:,:,i), rot_ang(i), 'crop');
        end

        Part.Locs(:,8) = Part.Locs(:,8) + rot_ang;
    end
    Part.Image =  ConstructParticleStack(full_img, Part,0);

    if Autoupdateref ==1
        ref = mean(Part.Image,3);   %update ref image
        if useGUI
            app.ref.av = ref;
            if sum(strcmp(app.RefListBox.Items,'Averaged Reference')) <1
                app.RefListBox.Items = [app.RefListBox.Items , {'Averaged Reference'}];
            end
            app.RefListBox.Value = 'Averaged Reference';
            updatePlot2(app,'normal')
        end
    end
end
if useGUI
    progressText.String = 'Alignment complete!';
    writeLog(app, progressText.String);
end