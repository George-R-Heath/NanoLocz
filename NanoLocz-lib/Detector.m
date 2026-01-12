%  Detector function - for NanoLocz GUI and NanoLocz-lib (2025)
%  DESCRIPTION:
%  Performs particle detection on AFM movie frames using either direct peak detection
%  or cross-correlation with optional rotational alignment.
%
%  INPUTS:
%  img         - 3D image stack (X, Y, frames) to process
%  method      - String: 'Peak picker' or 'ccr' (cross-correlation)
%  ref         - Reference image for cross-correlation (only used if method = 'ccr')
%  filt_img    - Gaussian filter sigma for input images (set to 0 for no filtering)
%  filt_ccr    - Gaussian filter sigma for cross-correlation maps (set to 0 for no filtering)
%  min_thresh  - Minimum peak threshold (intensity or correlation value)
%  ex_edge     - Logical flag: exclude edges (1) or not (0)
%  fastdetect  - Logical flag: enable fast detection by resizing images (1) or not (0)
%  angles      - (Optional) Array of angles (in degrees) eg: [-30:10:30]
%  app         - (Optional) App object for displaying progress (pass [] if unused)
%
%  OUTPUT:
%  locs        - Nx8 matrix of detected particle properties:
%                locs(:,1) = x-coordinate (in pixels)
%                locs(:,2) = y-coordinate (in pixels)
%                locs(:,3) = z-height (raw value from original image)
%                locs(:,4) = correlation value
%                locs(:,5) = frame number
%                locs(:,8) = angle of best match (degrees; zero if rotfreedom = 0)
%
%                Returns NaN if no particles are detected.

function [locs] = Detector(img, method, ref, filt_img, filt_ccr, min_thresh, ex_edge, fastdetect, angles ,app)

% Handle optional inputs
if nargin < 9 || isempty(angles)
    angles = 0;
end

rotfreedom = ~(numel(angles) == 1 && angles == 0);

locs = [];
n = numel(img(1,1,:));
img(isnan(img)) = 0;

if fastdetect ==1
img = imresize(img, 1/2, 'bilinear');
ref = imresize(ref, 1/2, 'bilinear');
ns = 3;
else
    ns = round(min(size(ref))/2);
    if ns<50
    else
        ns=50;
    end
end

if filt_img >0
    img_g = imgaussfilt(img,filt_img);
else
    img_g = img;
end

useGUI = exist('app', 'var') && isvalid(app) && isprop(app, 'loadbar');

if useGUI
    cla(app.loadbar);
    rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
    progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', [0.30, 0.98, 0.40]);
    progressText = text(app.loadbar, 0.5, 0.5, 'Starting...', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    updateInterval = 5; 
    stepsPerUpdate = ceil(n * (updateInterval / 100));
end

for i = 1:n
   
    locs_i = [];
    h=[];
    if strcmp('Peak picker', method)
        locs_i = Fast_peaks2D(img_g(:,:,i), min_thresh,ref);
        locs_i(:,8) = 0;
    elseif strcmp('ccr', method)
        %% rotational freedom code
        if rotfreedom ==1
            ccr=[];
            for j = 1:numel(angles)
                ref_img = imrotate(ref,angles(j),'crop');
                ccr(:,:,j) = normxcorr2(ref_img,img_g(:,:,i));
            end
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
              ccr = ccr(round(size(ref,1))+1:round(end - size(ref,1)-1),round(size(ref,2))+1:round((end - (size(ref,2))))-1,:);
            end

            [val, id] = max(ccr,[],3);
            locs_i = Fast_peaks2D(val, min_thresh, ns);
            if  numel(locs_i) >0
                locs_i(:,8) = locs_i(:,3);
                for j = 1:numel(locs_i(:,1))
                    locs_i(j,8) = id(round(locs_i(j,2)),round(locs_i(j,1)));
                    locs_i(j,8) = -angles(locs_i(j,8));
                end
            else
            end
            %% no rotation code
        else
           
            ccr = normxcorr2(ref,img_g(:,:,i));
 
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
                ccr = ccr(round(size(ref,1)):round(end - size(ref,1)),round(size(ref,2)):round((end - (size(ref,2)))),:);
            end

            locs_i = Fast_peaks2D(ccr, min_thresh, ns);
            locs_i(:,8) = 0;
        end
        %% end of rotation if
    end

    s = any(locs_i);
    if s(1)~=0
        if ex_edge ==1 && strcmp('ccr', method)       
            locs_i(:,2) = locs_i(:,2)+size(ref,1)/2;
            locs_i(:,1) = locs_i(:,1)+size(ref,2)/2;
        else
            locs_i(:,2) = locs_i(:,2)-size(ref,1)/2+0.5;
            locs_i(:,1) = locs_i(:,1)-size(ref,2)/2+0.5;
        end
        if strcmp('ccr', method)
            locs_i(:,4) = locs_i(:,3);
        end
        for j = 1:numel(locs_i(:,1))
            if round(locs_i(j,2))>0 && round(locs_i(j,1))>0
                try
                    h(:,j) = img(round(locs_i(j,2)),round(locs_i(j,1)),i);
                catch
                    h(:,j) = 0;
                end

            else
                h(:,j) = 0;
            end
        end
        locs_i(:,3) = h(:,:);
    else
        locs_i = [];
    end

    if numel(locs_i) >0
        frame = []; frame(1:numel(locs_i(:,1)),1) = i;
        locs_i(:,5) = frame;
        locs = [locs; locs_i];

         if useGUI && mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            progressText.String = sprintf([num2str(numel(locs(:,1))),' particles detected']);
            drawnow;
            if i == n
                writeLog(app, progressText.String);
            end
        end
    else
        if useGUI && mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            drawnow;
        end
    end

end

if numel(locs) >0
if fastdetect ==1
 locs(:,1:2) = locs(:,1:2)*2;
end
else
    locs=nan;
end

end
