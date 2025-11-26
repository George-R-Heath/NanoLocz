% DRAWLABELS function - NanoLocz-lib (2025)
%  
% This function overlays visual labels on an image, including a scale bar (in nm or μm)
% and a time stamp (in various formats). Both labels are optional and customizable.
%
% Inputs:
%   ax        - Handle to target axes for drawing (eg: input gca to use current axis)
%   img       - Image array (height, width, frame)
%   frame     - Current frame index (for time and pixel scaling)
%   ImageInfo - Struct with fields:
%                  .PixelPerNm : pixel size (nm) per frame (array or scalar)
%                  .time       : time values per frame (array)
%                  .n          : number of frames
%   scalebar  - (Boolean) true to draw scale bar
%   timescale - (Boolean) true to draw time stamp
%   Settings  - (Optional) struct defining label appearance and placement
%
% Usage:
%   drawLabels(gca, img, frame, ImageInfo)                         % Uses default label settings
%   drawLabels(ax, img, frame, ImageInfo, scalebar, timescale)     % Toggle scale bar and/or time stamp
%   drawLabels(ax, img, frame, ImageInfo, scalebar, timescale, Settings)  % Provide custom Settings
%
% Notes:
% - Automatically scales font size relative to image width.
% - Supports multiple time display formats: seconds, milliseconds, min:sec, hh:mm:ss.
% - Scale bar length is automatically calculated based on pixel size.


function drawLabels(ax, img, frame, ImageInfo, scalebar,timescale, varargin)

[r, cs, ~] = size(img(:,:,1));  % cs = image width in pixels

if nargin < 7 || isempty(varargin{1})

    Settings.label.ScaleBar.position = 'Bottom Right';
    Settings.label.ScaleBar.offimage = false;
    Settings.label.ScaleBar.font = '25';
    Settings.label.ScaleBar.color = 'w';
    Settings.label.ScaleBar.baronly = false;

    Settings.label.TimeStamp.position = 'Top Left';
    Settings.label.TimeStamp.offimage_2 = false;
    Settings.label.TimeStamp.font = '25';
    Settings.label.TimeStamp.color = 'w';
    Settings.label.TimeStamp.decimalPlaces = 2;
    Settings.label.TimeStamp.showUnits = true;
    Settings.label.TimeStamp.format = 'seconds';    %seconds, milliseconds, min:sec, hh:mm:ss
    refImageWidth = size(img,2)*1.5;            % Reference width for base scaling
    baseFontSize_sb = Settings.label.ScaleBar.font;              % Base font size for reference width
    baseFontSize_ts = Settings.label.TimeStamp.font;
    Settings.label.ScaleBar.font = round(str2num(baseFontSize_sb)*(cs / refImageWidth));
    Settings.label.TimeStamp.font = round(str2num(baseFontSize_ts)* (cs / refImageWidth));
    
else
    Settings = varargin{1};
    Settings.label.ScaleBar.font = round(str2num( Settings.label.ScaleBar.font));
    Settings.label.TimeStamp.font = round(str2num(Settings.label.TimeStamp.font));

end

% --- SCALE BAR ---
try
if scalebar
if numel(ImageInfo.PixelPerNm) >= frame
    pxPerNm = ImageInfo.PixelPerNm(frame);
else
    pxPerNm = ImageInfo.PixelPerNm(1);
end

sb_nm = cs / pxPerNm;
scale_bar = round(sb_nm / 5, 1, "significant");
scale_bar_pix = scale_bar * pxPerNm;

pos = Settings.label.ScaleBar.position;
offimage = Settings.label.ScaleBar.offimage;
fontSize = Settings.label.ScaleBar.font;
color = Settings.label.ScaleBar.color;
if r< cs*0.8
    ss = 0.02;
else
    ss=0;
end
switch pos
    case 'Top Right'
        if offimage
            xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
            ypos = [-r*0.07, -r*0.07];
            ylim(ax, [-r*0.1, r]);
        else
            xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
            ypos = round([r*0.05, r*0.05]);
        end
    case 'Top Left'
        if offimage
            xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
            ypos = [-r*0.07, -r*0.07];
            ylim(ax, [-r*0.1, r]);
        else
            xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
            ypos = round([r*0.05, r*0.05]);
        end
    case 'Bottom Left'
        if offimage
            xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
            ypos = [r + r*0.07, r + r*0.07];
            ylim(ax, [0, r + r*0.1]);
        else
            xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
            ypos = round([r*0.95, r*0.95]);
        end
    case 'Bottom Right'
        if offimage
            xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
            ypos = [r + r*0.07, r + r*0.07];
            ylim(ax, [0, r + r*0.1]);
        else
            xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
            ypos = round([r*0.95, r*0.95]);
        end
end

line(ax, xpos, ypos, 'LineWidth', 2, 'Color', color);

if ~Settings.label.ScaleBar.baronly

    labelY = ypos(1) - r * (0.03+ss);
    if scale_bar > 1000
        labelText = [num2str(scale_bar/1000) char(181) 'm'];
    else
        labelText = [num2str(scale_bar) 'nm'];
    end
    text(ax, mean(xpos), labelY, labelText, ...
        'FontWeight', 'bold', 'FontSize', fontSize, ...
        'Color', color, 'HorizontalAlignment', 'center');
end

end
catch
end
if ImageInfo.n>1 && timescale
    % --- TIME STAMP ---
    try
    time = ImageInfo.time(frame);
    pos = Settings.label.TimeStamp.position;
    offimage = Settings.label.TimeStamp.offimage_2;
    fontSize = Settings.label.TimeStamp.font;
    color = Settings.label.TimeStamp.color;
    decimals = Settings.label.TimeStamp.decimalPlaces;
    showUnits = Settings.label.TimeStamp.showUnits;
    timeFormat = Settings.label.TimeStamp.format;

    switch pos
        case 'Top Right'
            if offimage
                xpos = round(cs*0.97);
                ypos = -r*0.05;
                ylim(ax, [-r*0.1, r]);
            else
                xpos = round(cs*0.97);
                ypos = round(r*0.05);
            end
        case 'Top Left'
            if offimage
                xpos = round(cs*0.03);
                ypos = -r*0.05;
                ylim(ax, [-r*0.1, r]);
            else
                xpos = round(cs*0.03);
                ypos = round(r*0.05);
            end
        case 'Bottom Left'
            if offimage
                xpos = round(cs*0.03);
                ypos = r + r*0.05;
                ylim(ax, [0, r + r*0.1]);
            else
                xpos = round(cs*0.03);
                ypos = round(r*0.95);
            end
        case 'Bottom Right'
            if offimage
                xpos = round(cs*0.97);
                ypos = r + r*0.05;
                ylim(ax, [0, r + r*0.1]);
            else
                xpos = round(cs*0.97);
                ypos = round(r*0.95);
            end
    end

    % Format time string
    switch timeFormat
        case 'seconds'
            timeStr = num2str(round(time, decimals), ['%0.', num2str(decimals), 'f']);
            if showUnits, timeStr = [timeStr ' s']; end
        case 'milliseconds'
            msVal = round(time * 1000, decimals);
            timeStr = sprintf(['%0.', num2str(decimals), 'f'], msVal);
            if showUnits, timeStr = [timeStr ' ms']; end
        case 'minutes:seconds'
            m = floor(time/60); s = floor(mod(time,60));
            timeStr = sprintf('%02d:%02d', m, s);
            if showUnits, timeStr = [timeStr ' min']; end
        case 'hh:mm:ss'
            h = floor(time/3600); m = floor(mod(time,3600)/60); s = floor(mod(time,60));
            timeStr = sprintf('%02d:%02d:%02d', h, m, s);
            if showUnits, timeStr = [timeStr ' h']; end
        otherwise
            timeStr = num2str(round(time, decimals), ['%0.', num2str(decimals), 'f']);
            if showUnits, timeStr = [timeStr ' s']; end
    end

    parts = strsplit(pos);
    if numel(parts) > 1
        align = lower(parts{2});
    else
        align = 'right';
    end

    text(ax, xpos, ypos, timeStr, ...
        'FontWeight', 'bold', 'FontSize', fontSize, ...
        'Color', color, 'HorizontalAlignment', align);
    catch
    end
end
end