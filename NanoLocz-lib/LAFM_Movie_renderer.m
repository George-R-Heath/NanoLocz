% Function written for NanoLocz-lib 2025 and NanoLocz GUI
%
%  DESCRIPTION:   Generates a rendered movie from localization AFM (LAFM) 
%                 data using Gaussian rendering or Gaussian filtering. 
%                 Supports both probability maps and color-mapped images. 
%
%  INPUT:
%       locs            - Nx7 matrix of localizations [x, y, z, ..., time frame, time]
%       img_gus         - Gaussian sigma (in pixels) for rendering spots
%       expand          - Pixel expansion factor to increase image pixel resolution
%       fullcolormap    - Colormap used for rendering (e.g., 'jet', 'LAFMcolor')
%       prob            - If 1: outputs grayscale probability map only; else RGB image
%       colorlimits     - [lower, upper] height limits for colormap scaling
%       colorlimit_mode - 'Max Min', 'Exc outliers', or 'Manual' to set colorlimits
%       window          - Time window (in frames) for rendering each movie frame
%       slide           - Step size between movie frames (for overlapping windows)
%
%  OUTPUT:
%       LAFM_Mov        - Cell array containing rendered movie frames (RGB or grayscale)
%       zlims           - [min, max] Z-height limits used for colormap mapping
%       time            - Time value associated with each movie frame


function [LAFM_Mov, zlims, time] = LAFM_Movie_renderer(locs, img_gus, expand, fullcolormap, prob, colorlimits,colorlimit_mode, window, slide)

total_parts = max(locs(:,5));
if slide > 0 
   n = round((total_parts - window)/slide)+1;
else
    n = round(total_parts/window);
end

side=0;
speed = 1; %if =1, render using gaussfilter if =0, render using gaussian draw (slower)
colormapping = fullcolormap;
locs(:,1) = locs(:,1)-min(locs(:,1)) +1;
locs(:,2) = locs(:,2)-min(locs(:,2)) +1;
if side ==1
explocs = [round(locs(:,2:3)*expand), locs(:,3:end)];
else
    explocs = [round(locs(:,1:2)*expand), locs(:,3:end)];
end
nanRows = any(isnan(explocs), 2);
explocs = explocs(~nanRows, :);
imageSize = [max(explocs(:,2))+5,max(explocs(:,1))+5];

LAFM_Mov = cell(1, n);
for i = 1:n
    if prob==1
        LAFM_Mov{i} = zeros(imageSize(1),imageSize(2));
    else
        LAFM_Mov{i} = zeros(imageSize(1),imageSize(2), 3); % Initialize RGB image
    end
end

[X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));

switch colorlimit_mode
    case 'Max Min'
        colorlimits(1) = round(min(explocs(:,3)),3,"significant");
        colorlimits(2) = round(max(explocs(:,3)),3,"significant");
    case 'Exc outliers'
        B = rmoutliers(explocs(:,3),"mean");
        colorlimits(1) = round(min(B(:)),3,"significant");
        colorlimits(2) = round(max(B(:)),3,"significant");
    case 'Manual'
end
zlims = [colorlimits(1), colorlimits(2)];
colorIndex = round(interp1(linspace(colorlimits(1), colorlimits(2), size(colormapping, 1)), 1:size(colormapping, 1), explocs(:,3), 'linear', 'extrap'));

correction = zeros(5,5); correction(3,3) = 1; correction = imgaussfilt(correction,img_gus*expand/2);
correction = max(correction(:));

for jj = 1:n
    if slide>0
        MovPos = explocs(:,5) > (jj-1)*slide   &   explocs(:,5) <= window+(jj-1)*slide;
    else
        MovPos = explocs(:,5) > (jj-1)*window   &   explocs(:,5) <= jj*window;
    end
Movlocs =  explocs(MovPos,:);
Mov_color = colorIndex(MovPos);
  time(jj) = min(Movlocs(:,7));
    for i = 1:numel(colormapping(:,1))
        render = zeros(imageSize(1),imageSize(2));
        if i ==1
            pos = Mov_color<2;
        elseif i >(numel(colormapping(:,1))-1)
            pos = Mov_color>numel(colormapping(:,1))-1;
        else
            pos = Mov_color==i;
        end

        sublocz = (Movlocs(pos,:));

        if sum(pos)>0
            for j = 1:sum(pos)
                if speed == 1
                    render(sublocz(j,2),sublocz(j,1)) = 1;
                else

                    if j==1
                        render = exp(-((X - sublocz(j,1)).^2 + (Y - sublocz(j,2)).^2) / (2 * (img_gus*expand/2)^2));
                    else
                        render = render + exp(-((X - sublocz(j,1)).^2 + (Y - sublocz(j,2)).^2) / (2 * (img_gus*expand/2)^2));
                    end
                end
            end

            if speed==1
                render = imgaussfilt(render,img_gus*expand/2)/correction;
            end

            if prob==1
                LAFM_Mov{jj} = LAFM_Mov{jj}+render;
            else
                color = colormapping(i, :);
                for channel = 1:3
                    LAFM_Mov{jj}(:,:,channel) = LAFM_Mov{jj}(:,:,channel) + render * color(channel);
                end
            end
        end
    end
end

