    function stopDragging(app, ~, ~)
        fig = ancestor(app.Hist_Axes, 'figure');
        set(fig, 'WindowButtonMotionFcn', '');
        set(fig, 'WindowButtonUpFcn', '');
        app.ActiveSlider = '';
    end