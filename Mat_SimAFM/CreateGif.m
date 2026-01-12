% CreateGif/png - NanoLocz-lib (2025)
%
% DESCRIPTION:
%   Exports a 3D image stack as a multi-frame GIF or a single-frame PNG.
%   Applies percentile-based contrast stretching and optional frame labels.
%
% USAGE:
%   CreateGif(stack, outputBasePath, ImageInfo, labels, cmap)
%
% INPUTS:
%   stack          - 3D image stack (height x width x frames)
%   outputBasePath - Full file path without extension (folder + filename root)
%   ImageInfo      - (Optional) Struct with PixelPerNm and timing info
%   labels         - (Optional) Logical flag to enable frame labels (true/false)
%   cmap           - (Optional) Colormap matrix (e.g., 256x3 RGB values)
%
% OUTPUT:
%   Saves either a GIF (for multi-frame stacks) or PNG (for single-frame) at outputBasePath.
%
% EXAMPLE:
%   outputBasePath = fullfile(outputDir, 'MyExport');
%   CreateGif(stack, fullfile(cd, 'MyExport'), imageinfo, true, parula);

function CreateGif(stack, outputBasePath, ImageInfo, labels, cmap)

% Set default colormap if not provided
if nargin < 5 || isempty(cmap)
    LUTs = load('AFM_luts_full.mat');
    colormapNames = fieldnames(LUTs);
    cmap = LUTs.(colormapNames{3});  % Default LUT
end

numFrames = size(stack, 3);

figure('Visible', 'off', 'Position', [100 100 size(stack, 2) size(stack, 1)]);
ax = axes('Units', 'pixels', 'Position', [1 1 size(stack, 2) size(stack, 1)]);
axis(ax, 'image');
axis(ax, 'off');
hold(ax, 'on');

for frameIdx = 1:numFrames
    imgRaw = stack(:, :, frameIdx);

    % Percentile-based contrast stretching
    imgDouble = double(imgRaw(:));
    lowPerc = prctile(imgDouble, 1);
    highPerc = prctile(imgDouble, 99.5);
    imgClipped = min(max(double(imgRaw), lowPerc), highPerc);
    imgNorm = uint8(255 * (imgClipped - lowPerc) / (highPerc - lowPerc));

    % Display with colormap
    imshow(imgNorm, cmap, 'Parent', ax);

    % Draw labels if requested and info provided
    if exist('labels', 'var') && labels && exist('ImageInfo', 'var') && ~isempty(ImageInfo)
        drawLabels(ax, repmat(imgNorm, 1, 1, 3), frameIdx, ImageInfo, 1, 1);
    end

    % Capture frame area
    frameRGB = getframe(ax);
    imgRGB = frameRGB.cdata;

    if numFrames == 1
        % Save single frame as PNG
        pngPath = [outputBasePath, '.png'];
        imwrite(imgRGB, pngPath);
        disp(['Saved PNG: ', pngPath]);
    else
        % Convert to indexed and save as GIF
        [indexedFrame, map] = rgb2ind(imgRGB, 256);
        gifPath = [outputBasePath, '.gif'];
        if frameIdx == 1
            imwrite(indexedFrame, map, gifPath, 'gif', 'LoopCount', Inf, 'DelayTime', 0.1);
        else
            imwrite(indexedFrame, map, gifPath, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        if frameIdx == numFrames
            disp(['Saved GIF: ', gifPath]);
        end
    end

    cla(ax); % Clear for next frame
end

% Adjust figure size to prevent cropping
set(gcf, 'Position', [100 100 size(stack, 2) size(stack, 1)]);

close(gcf);
end
