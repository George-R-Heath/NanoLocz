%  Function for NanoLocz-lib (2025)
%  DESCRIPTION:
%  Assembles particle-centered image stacks from AFM movies/images based on detected particle locations.
%  Includes optional rotational alignment and shift correction for each particle.
%
%  INPUTS:
%  ImageTarget   - 3D AFM movie stack (X, Y, frames)
%  Part          - Struct containing:
%                  Part.Image = reference particle image for size
%                  Part.Locs  = Nx8 particle localization matrix (from Detector function)
%  quick         - Logical flag: fast alignment (1) or precise (0)
%  app           - (Optional) App object for displaying progress (pass [] if unused)
%
%  OUTPUT:
%  Result        - 3D stack of cropped, centered, aligned particle images
%
function Result = ConstructParticleStack(ImageTarget, Part, quick, app)

sd = size(Part.Image);
xtra = 20;
Part.Image = padarray(Part.Image,[xtra/2, xtra/2],0,'both');
n = numel(Part.Locs(:,1));

useGUI = exist('app', 'var') && isvalid(app) && isprop(app, 'loadbar');

if useGUI
    cla(app.loadbar);
    rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
    progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', [0.30, 0.98, 0.40]);
    progressText = text(app.loadbar, 0.5, 0.5, 'Starting...', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    updateInterval = 5; 
    stepsPerUpdate = ceil(n * (updateInterval / 100));
end

    img_pad = padarray(ImageTarget,[round(sd(1))+xtra, round(sd(2))+xtra],0,'both');

    if rem(sd(1),2)==0
        dy1 = 0;
        dy2 = 1;
    else
        dy1 = 0.5;
        dy2 = 0.5;
    end
    if rem(sd(2),2)==0
        dx1 = 0;
        dx2 = 1;
    else
        dx1 = 0.5;
        dx2 = 0.5;
    end

    for i = 1:n
        clipy1 = round(Part.Locs(i,2)+sd(1)/2+dy1);
        clipy2 = round(Part.Locs(i,2)+sd(1)*1.5-dy2)+2*xtra;
        clipx1 = round(Part.Locs(i,1)+sd(2)/2+dx1);
        clipx2 = round(Part.Locs(i,1)+sd(2)*1.5-dx2)+2*xtra;
        try
            Result(:,:,i) = img_pad(clipy1:clipy2,clipx1:clipx2,Part.Locs(i,5));
        catch
            targetSize = size(Result(:,:,i-1));
            tg =   size(Part.Image(:,:,i));
            paddingLengths = (targetSize - size(Part.Image(:,:,i))) / 2;
            Result(:,:,i) = padarray(Part.Image(:,:,i), paddingLengths, 0);
        end

        shifty = round(Part.Locs(i,2)+sd(1)/2+dy1)-(Part.Locs(i,2)+sd(1)/2+dy1);
        shiftx = round(Part.Locs(i,1)+sd(2)/2+dx1)-(Part.Locs(i,1)+sd(2)/2+dx1);
        if quick == 0
            try
                tform = rigidtform2d(-Part.Locs(i,8),[shiftx, shifty]);
                sameAsInput = affineOutputView(size(Result(:,:,i)),tform,"BoundsStyle","CenterOutput");
                Result(:,:,i) = imwarp(Result(:,:,i),tform,"OutputView",sameAsInput,'interp','bicubic');
            catch
                Result(:,:,i) = imrotate(Result(:,:,i), Part.Locs(i,8), 'crop');
                Result(:,:,i) = imtranslate(Result(:,:,i), [shiftx, shifty] );
            end
        else
            Result(:,:,i) = imrotate(Result(:,:,i), Part.Locs(i,8), 'crop');
            Result(:,:,i) = imtranslate(Result(:,:,i), [shiftx, shifty] );
        end

        if useGUI && mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            progressText.String = sprintf([num2str(i),' particles assembled']);
            drawnow;
        end
    end

      Result = Result(1+xtra:end-xtra, 1+xtra:end-xtra,:);
end
%else
    % position = ref{2};
    % img_pad = padarray(ImageTarget,[round(position(4)), round(position(3))],0,'both');
    % if rem(position(4),2)==0
    %     dy1 = 0;
    %     dy2 = 1;
    % else
    %     dy1 = 0.5;
    %     dy2 = 0.5;
    % end
    % if rem(position(3),2)==0
    %     dx1 = 0;
    %     dx2 = 1;
    % else
    %     dx1 = 0.5;
    %     dx2 = 0.5;
    % end
    % 
    % for i = 1:n
    %     clipy1 = round(Part(i,2)+position(4)/2+dy1);
    %     clipy2 = round(Part(i,2)+position(4)*1.5-dy2);
    %     clipx1 = round(Part(i,1)+position(3)/2+dx1);
    %     clipx2 = round(Part(i,1)+position(3)*1.5-dx2);
    %     try
    %     Result(:,:,i) = img_pad(clipy1:clipy2,clipx1:clipx2,Part(i,5));
    %     catch
    %     Result(:,:,i) = Part.Image(:,:,Part(i,5));
    %     end
    % 
    %     if i == 1
    %         Result(:,:,numel(Part(:,1))) = Result(:,:,i);
    %     end
    % 
    %     shifty = round(Part(i,2)+position(4)/2+dy1)-(Part(i,2)+position(4)/2+dy1);
    %     shiftx = round(Part(i,1)+position(3)/2+dx1)-(Part(i,1)+position(3)/2+dx1);
    %   try
    %     tform = rigidtform2d(-Part(i,8),[shiftx, shifty]);
    %     sameAsInput = affineOutputView(size(Result(:,:,i)),tform,"BoundsStyle","CenterOutput");
    %     Result(:,:,i) = imwarp(Result(:,:,i),tform,"OutputView",sameAsInput,'interp','bicubic');
    %   catch
    %       Result(:,:,i) = imrotate(Result(:,:,i), Part.Locs(i,8), 'crop');
    %       Result(:,:,i) = imtranslate(Result(:,:,i), [shiftx, shifty] );
    %   end 
    %     if mod(i, stepsPerUpdate) == 0 || i == n
    %         progressBar.Position(3) = i / n;
    %         progressText.String = sprintf([num2str(i),' particles assembled']);
    %         drawnow;
    %     end
    % end
%end







