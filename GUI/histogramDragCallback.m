function histogramDragCallback(app, ~, ~)
cursorPoint = get(app.Hist_Axes, 'CurrentPoint');
newThreshold = cursorPoint(1,1); % X-coordinate
xLimits = xlim(app.Hist_Axes);

if newThreshold < xLimits(1)
    newThreshold = -Inf;
elseif newThreshold > xLimits(2)
    newThreshold = Inf;
end

if strcmp(app.ActiveSlider, 'Min')

    switch app.HistogramDropDown.Value
        case {'Mask z (all)','Mask z (frame)'}
            app.Mask.low_thresh = newThreshold;
            upper = app.Mask.high_thresh;
            lower = app.Mask.low_thresh;
        case 'Particle z'
            app.Part.z_low_thresh = newThreshold;
            upper = app.Part.z_high_thresh;
            lower = app.Part.z_low_thresh;
        case 'Particle Correlation'
            app.Part.ccr_low_thresh = newThreshold;
            upper = app.Part.ccr_high_thresh;
            lower = app.Part.ccr_low_thresh;
        case 'LAFM z'
            app.LAFM.z_low_thresh= newThreshold;
            upper = app.LAFM.z_high_thresh;
            lower = app.LAFM.z_low_thresh;
        case 'LAFM Particle Correlation'
            app.LAFM.ccr_low_thresh= newThreshold;
            lower = app.LAFM.ccr_low_thresh;
            upper = app.LAFM.ccr_high_thresh;
        case 'LAFM pp'
            app.LAFM.pp_low_thresh = newThreshold;
            upper = app.LAFM.pp_high_thresh;
            lower = app.LAFM.pp_low_thresh;
        case 'LAFM Loc error'
            app.LAFM.err_low_thresh = newThreshold;
            upper = app.LAFM.err_high_thresh;
            lower = app.LAFM.err_low_thresh;
    end
else
    switch app.HistogramDropDown.Value
        case {'Mask z (all)','Mask z (frame)'}
            app.Mask.high_thresh = newThreshold;
            upper = app.Mask.high_thresh;
            lower = app.Mask.low_thresh;
        case 'Particle z'
            app.Part.z_high_thresh = newThreshold;
            upper = app.Part.z_high_thresh;
            lower = app.Part.z_low_thresh;
        case 'Particle Correlation'
            app.Part.ccr_high_thresh = newThreshold;
            upper = app.Part.ccr_high_thresh;
            lower = app.Part.ccr_low_thresh;
        case 'LAFM z'
            app.LAFM.z_high_thresh= newThreshold;
            upper = app.LAFM.z_high_thresh;
            lower = app.LAFM.z_low_thresh;
        case 'LAFM Particle Correlation'
            app.LAFM.ccr_high_thresh= newThreshold;
            lower = app.LAFM.ccr_low_thresh;
            upper = app.LAFM.ccr_high_thresh;
        case 'LAFM pp'
            app.LAFM.pp_high_thresh = newThreshold;
            upper = app.LAFM.pp_high_thresh;
            lower = app.LAFM.pp_low_thresh;
        case 'LAFM Loc error'
            app.LAFM.err_high_thresh = newThreshold;
            upper = app.LAFM.err_high_thresh;
            lower = app.LAFM.err_low_thresh;
    end

end

delete(app.patches.histup);
delete(app.patches.histdown);

% Update upper threshold patch
if upper ~= Inf
    app.patches.histup = patch(app.Hist_Axes, ...
        [xLimits(2), upper, upper, xLimits(2)], ...
        [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(2), app.Hist_Axes.YLim(2)], ...
        [0.30,0.98,0.40], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
end

% Update lower threshold patch
if lower ~= -Inf
    app.patches.histdown = patch(app.Hist_Axes, ...
        [lower, xLimits(1), xLimits(1), lower], ...
        [app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(1), app.Hist_Axes.YLim(2), app.Hist_Axes.YLim(2)], ...
        [0.30,0.98,0.40], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
end

switch app.HistogramDropDown.Value
    case {'Mask z (all)','Mask z (frame)'}
        switch app.ThresholdMethod.Value
            case {'auto edges', 'otsu edges', 'otsu skel', 'otsu', '2 level otsu', 'step detection'}
            otherwise
                imgt = thresholder(app.ImageTarget, app.ThresholdMethod.Value, [app.Mask.low_thresh, app.Mask.high_thresh], app.InvertMask.Value);
                if isfield(app.Mask, 'ROI') && any(app.Mask.ROI(:))
                    imgt = thresholder(app.Mask.ROI .* imgt, 'selection', [app.Mask.low_thresh, app.Mask.high_thresh], app.InvertMask.Value);
                end

                app.Mask.Mask = imgt;
                app.filter_already =0;
                run_filter(app)
        end
    case {'Particle z','Particle Correlation'}
        filter_Partlocs(app)
        updateVideoTools(app)
        updatePlot(app,'normal')

        updatePlot2(app,'normal')
    case {'LAFM z', 'LAFM pp', 'LAFM Loc error','LAFM Particle Correlation'}
        filter_LAFMlocs(app)
        updatePlot2(app,'normal')
end



end

