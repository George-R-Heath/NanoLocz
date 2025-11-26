%  Visualization function written for NanoLocz-lib 2025

% viewstack - Interactive viewer for 3D image stacks with customizable colormaps and labels
%
% USAGE:
%   viewstack(stack)
%   viewstack(stack, Info)
%
% DESCRIPTION:
%   Displays a 3D image stack slice-by-slice with an interactive GUI.
%   Supports mouse wheel and keyboard navigation through slices.
%   Allows colormap selection from predefined LUTs loaded from 'AFM_luts_full.mat'.
%   Provides contrast limits adjustment and optional overlay of labels from provided Info.
%
% INPUTS:
%   stack : 3D numeric array
%       The image stack to display. If omitted, a random 256x256x50 stack is generated.
%
%   Info (optional) : Struct or data required by drawLabels_v2
%       If provided, enables a checkbox to toggle label drawing on the images.
%
% FEATURES:
%   - Mouse wheel and arrow key navigation through slices
%   - Dropdown menu to select different colormaps from LUT file
%   - Editable contrast limits (CLim) for intensity scaling
%   - Checkbox to toggle overlay of labels on the current slice
%
% DEPENDENCIES:
%   - AFM_luts_full.mat : MAT file containing colormaps as structs
%   - drawLabels_v2 : function to overlay labels on images
%
% EXAMPLES:
%   viewstack(myStack);
%   viewstack(myStack, myLabelInfo);
%

function viewstack(stack, varargin)
    % varargin{1} = Info (labels)
    % varargin{2} = mask (same size as stack)

    if nargin < 1
        stack = rand(256, 256, 50);
    end

    LUTs = load('AFM_luts_full.mat');
    colormapNames = fieldnames(LUTs);
    cmapData = LUTs.(colormapNames{3});  % Default to first colormap

    numSlices = size(stack, 3);
    currentSlice = 1;

    hFig = figure('Name', '3D Stack Viewer Enhanced', ...
                  'NumberTitle', 'off', ...
                  'MenuBar', 'none', ...
                  'ToolBar', 'none', ...
                  'WindowScrollWheelFcn', @scrollWheelCallback, ...
                  'KeyPressFcn', @keyPressCallback);

    hAx = axes('Parent', hFig);
    
    hImg = imagesc(stack(:, :, currentSlice), 'Parent', hAx);
    axis image off
    colormap(hAx, cmapData);
    colorbar;
    title(hAx, sprintf('Slice %d of %d', currentSlice, numSlices));
    
% --- Draw Labels Checkbox ---

if nargin > 1
    hDrawLabels = uicontrol('Style', 'checkbox', ...
        'String', 'Draw Labels', ...
        'Units', 'normalized', ...
        'Position', [0.75 0.95 0.2 0.05], ...
        'Value', 0, ...
        'Callback', @(src, event) updateSlice(currentSlice,varargin{:}));  % Redraw current s
else
    hDrawLabels.Value = 0;
end

if nargin > 2
    hOverlayMask = uicontrol('Style', 'checkbox', ...
        'String', 'Overlay Mask', ...
        'Units', 'normalized', ...
        'Position', [0.55 0.95 0.18 0.05], ...
        'Value', 0, ...
        'Callback', @(src, event) updateSlice(currentSlice, varargin{:}));
else
    hOverlayMask.Value = 0;
end

    % Dropdown for colormap selection
    hColormap = uicontrol('Style', 'popupmenu', ...
                          'String', colormapNames, ...
                          'Units', 'normalized', ...
                          'Position', [0.05 0.95 0.2 0.05], ...
                          'Callback', @(src, event) updateColormap());

    % --- Colormap update ---
    function updateColormap()
        selectedName = colormapNames{hColormap.Value};
        cmapData = LUTs.(selectedName);
        colormap(hAx, cmapData);
    end
% Calculate initial contrast limits using percentiles of the first slice
currentData = stack(:, :, currentSlice);
sortedData = sort(currentData(:));

lowPercentile = 1;   % e.g., 1st percentile
highPercentile = 99; % e.g., 99th percentile

climMin = sortedData(round((lowPercentile / 100) * numel(sortedData)));
climMax = sortedData(round((highPercentile / 100) * numel(sortedData)));

clim = [climMin, climMax];
caxis(hAx, clim);

% Also update the UI edit boxes
hMin.String = num2str(clim(1));
hMax.String = num2str(clim(2));


    % UI controls: slider
if numSlices == 1
    sliderStep = [0 0];              % No movement possible
    enableStatus = 'off';            % Disable slider
else
    sliderStep = [1 1] / (numSlices - 1);
    enableStatus = 'on';
end

hSlider = uicontrol('Style', 'slider', ...
    'Min', 1, 'Max', numSlices, ...
    'Value', currentSlice, ...
    'SliderStep', sliderStep, ...
    'Enable', enableStatus, ...
    'Units', 'normalized', ...
    'Position', [0.2 0.02 0.6 0.05]);

addlistener(hSlider, 'Value', 'PostSet', @(src, event) updateSlice(round(hSlider.Value),varargin{:}));

    % Intensity limits controls
    uicontrol('Style', 'text', 'String', 'CLim Min:', ...
              'Units', 'normalized', 'Position', [0.01 0.02 0.08 0.04]);
    hMin = uicontrol('Style', 'edit', 'String', num2str(clim(1)), ...
              'Units', 'normalized', 'Position', [0.09 0.02 0.08 0.05], ...
              'Callback', @(src, event) updateCLim());

    uicontrol('Style', 'text', 'String', 'CLim Max:', ...
              'Units', 'normalized', 'Position', [0.81 0.02 0.08 0.04]);
    hMax = uicontrol('Style', 'edit', 'String', num2str(clim(2)), ...
              'Units', 'normalized', 'Position', [0.89 0.02 0.08 0.05], ...
              'Callback', @(src, event) updateCLim());

    % --- Slice update ---
    % function updateSlice(idx)
    %     currentSlice = min(max(1, idx), numSlices);
    %     hImg.CData = stack(:, :, currentSlice);
    %     hSlider.Value = currentSlice;
    %     title(hAx, sprintf('Slice %d of %d', currentSlice, numSlices));
    %     drawnow limitrate
    % end

 function updateSlice(idx, varargin)
    currentSlice = min(max(1, idx), numSlices);

    % --- Update main image ---
    hImg.CData = stack(:, :, currentSlice);
    
    % --- Update slider and title ---
    if exist('hSlider','var') && isvalid(hSlider)
        hSlider.Value = currentSlice;
    end
    title(hAx, sprintf('Slice %d of %d', currentSlice, numSlices));

    % --- Clear previous overlays ---
    delete(findall(hAx, 'Tag', 'MaskOverlay'));
    delete(findall(hAx, 'Type', 'line'));
    delete(findall(hAx, 'Type', 'text'));

    % --- Draw labels ---
    if hDrawLabels.Value && ~isempty(varargin)
        Info = varargin{1};
        drawLabels(hAx, stack(:, :, currentSlice), currentSlice, Info, true, true);
    end

    % --- Overlay mask ---
    if exist('hOverlayMask','var') && hOverlayMask.Value && numel(varargin) > 1
        hold on
        mask = varargin{2};
        if size(mask,3) >= currentSlice
            hMask = imagesc(hAx, cat(3, zeros(size(mask(:,:,currentSlice))), ...
                                        ones(size(mask(:,:,currentSlice))), ...
                                        zeros(size(mask(:,:,currentSlice)))));
            hMask.AlphaData = 0.4 * double(mask(:,:,currentSlice) > 0);
            hMask.Tag = 'MaskOverlay';
        end
        hold off
    end
 end


    % --- Contrast limits update ---
    function updateCLim()
        minVal = str2double(hMin.String);
        maxVal = str2double(hMax.String);
        if isnan(minVal) || isnan(maxVal) || minVal >= maxVal
            return;
        end
        caxis(hAx, [minVal, maxVal]);
    end

    % --- Mouse wheel scroll callback ---
    function scrollWheelCallback(~, event)
        delta = -event.VerticalScrollCount;
        updateSlice(currentSlice + delta,varargin{:});
    end

    % --- Key press callback (arrow keys) ---
    function keyPressCallback(~, event)
        climNow = caxis(hAx);
        range = climNow(2) - climNow(1);

        switch event.Key
            case 'rightarrow'
                updateSlice(currentSlice + 1,varargin{:});
            case 'leftarrow'
                updateSlice(currentSlice - 1,varargin{:});
            case 'downarrow'
                if ismember('shift', event.Modifier)
                    climNow = climNow + [-0.05 0.05] * range;
                else
                    climNow = climNow + [0.05 0.05] * range;
                end
                caxis(hAx, climNow);
                hMin.String = num2str(climNow(1));
                hMax.String = num2str(climNow(2));
            case 'uparrow'
                if ismember('shift', event.Modifier)
                    climNow = climNow + [0.05 -0.05] * range;
                else
                    climNow = climNow - [0.05 0.05] * range;
                end
                caxis(hAx, climNow);
                hMin.String = num2str(climNow(1));
                hMax.String = num2str(climNow(2));
        end
    end
end
