%  Visualization function written for NanoLocz-lib 2025
%  DESCRIPTION:   Interactive plotting tool for visualizing Localization 
%                 AFM (LAFM) rendered images or probability maps with 
%                 adjustable dynamic range. 
%
%  INPUT:
%       LAFM_full   - Rendered LAFM image (2D matrix) to display
%
%  FUNCTIONALITY:
%       - Displays the LAFM image using MATLAB's imagesc
%       - Provides two sliders to interactively adjust the lower and upper 
%         limits of the displayed intensity range in real-time
%       - Automatically constrains slider values to avoid invalid ranges
%
%  NOTES:
%       - Designed for quick manual inspection of probability maps or 
%         reconstructed AFM images.
%       - Can be extended to include colormap selection or saving options.

function LAFM_plotter(LAFM_full)
%% plot
t = LAFM_full;
mx = max(t(:));
upper_lim = 1;
lower_lim = 0;

% Create figure
hFig = figure;
hAx = axes('Parent', hFig);
hImg = imagesc((t - lower_lim * mx) / (upper_lim * mx - lower_lim * mx), 'Parent', hAx);

% Create lower limit slider
hSliderLower = uicontrol('Parent', hFig, 'Style', 'slider', ...
    'Units', 'normalized', 'Position', [0.2 0.01 0.25 0.05], ...
    'Min', 0, 'Max', 1, 'Value', lower_lim);

% Create upper limit slider
hSliderUpper = uicontrol('Parent', hFig, 'Style', 'slider', ...
    'Units', 'normalized', 'Position', [0.55 0.01 0.25 0.05], ...
    'Min', 0, 'Max', 1, 'Value', upper_lim);

% Set callbacks *after* creating sliders
hSliderLower.Callback = @(src, event) updatePlot(hImg, t, mx, hSliderLower, hSliderUpper);
hSliderUpper.Callback = @(src, event) updatePlot(hImg, t, mx, hSliderLower, hSliderUpper);

% --- Callback function (pass handles explicitly) ---
    function updatePlot(hImg, t, mx, hSliderLower, hSliderUpper)
        lower_lim = hSliderLower.Value;
        upper_lim = hSliderUpper.Value;

        % Prevent upper limit from being lower than lower limit
        if upper_lim <= lower_lim
            upper_lim = lower_lim + 0.01;
            hSliderUpper.Value = upper_lim;
        end

        % Update the image
        hImg.CData = (t - lower_lim * mx) / (upper_lim * mx - lower_lim * mx);
    end
end
