% Populate NanoLocz app GUI elements based on loaded data (ref, Part, LAFM).

function app_populate_gui(app)

if isfield(app.ref,'position')
    if isfield(app.ref,'ROIimage')
        app.RefListBox.Items = [app.RefListBox.Items , {'ROI Reference'}];
    end
    if isfield(app.ref,'simImage')
        app.RefListBox.Items = [app.RefListBox.Items , {'Simulated Reference'}];
    end
    if isfield(app.ref,'LAFM')
        app.RefListBox.Items = [app.RefListBox.Items , {'LAFM Reference'}];
    end
    if isfield(app.ref,'av')
        app.RefListBox.Items = [app.RefListBox.Items , {'Averaged Reference'}];
    end
    if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
        app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
    end
end

if isfield(app.Part,'Locs')
    filter_Partlocs(app)
    if sum(strcmp(app.HistogramDropDown.Items,'Particle Correlation')) <1
        app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'Particle Correlation'}];
    end
    if sum(strcmp(app.HistogramDropDown.Items,'Particle z')) <1
        app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'Particle z'}];
    end
    updateHist(app,'normal')

    %  app.Part.Image  = ConstructParticleStack2(app, app.ImageTarget, app.ref, app.Part,0);
end

if isfield(app.LAFM,'Locs')
    if sum(strcmp(app.RightPlotList.Items,'Localizations')) <1
        app.RightPlotList.Items = [app.RightPlotList.Items , {'Localizations'}];
    end
    if isfield(app.LAFM,'Image')
        if sum(strcmp(app.RightPlotList.Items,'LAFM')) <1
            app.RightPlotList.Items = [app.RightPlotList.Items , {'LAFM'}];
        end
    end
    updateLAFMHist(app)
    filter_LAFMlocs(app)
end
end