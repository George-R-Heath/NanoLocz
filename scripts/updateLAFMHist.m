
function updateLAFMHist(app)

app.LAFM.z_low_thresh = min(app.LAFM.Locs(:,3));
app.LAFM.z_high_thresh = max(app.LAFM.Locs(:,3));
app.LAFM.pp_low_thresh = min(app.LAFM.Locs(:,4));
app.LAFM.pp_high_thresh = max(app.LAFM.Locs(:,4));
app.LAFM.ccr_low_thresh = min(app.LAFM.Locs(:,8));
app.LAFM.ccr_high_thresh = max(app.LAFM.Locs(:,8));

if sum(strcmp(app.HistogramDropDown.Items,'LAFM z')) <1
    app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'LAFM z'}];
end

if sum(strcmp(app.HistogramDropDown.Items,'LAFM Particle Correlation')) <1
    app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'LAFM Particle Correlation'}];
end


if sum(strcmp(app.HistogramDropDown.Items,'LAFM peak prominance')) <1 && app.LAFM.pp_high_thresh > app.LAFM.pp_low_thresh
    app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'LAFM peak prominance'}];
end

try
    app.LAFM.err_low_thresh = min(app.LAFM.Locs(:,10));
    app.LAFM.err_high_thresh = max(app.LAFM.Locs(:,10));

    if sum(strcmp(app.HistogramDropDown.Items,'LAFM Loc error')) <1 && app.LAFM.err_high_thresh > app.LAFM.err_low_thresh
        app.HistogramDropDown.Items = [app.HistogramDropDown.Items , {'LAFM Loc error'}];
    end
catch
end
end