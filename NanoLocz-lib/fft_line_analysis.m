function result = fft_line_analysis(x, y, doPlot)
% FFT_LINE_ANALYSIS  Dominant period detection from a line profile (AFM)
%
%  result = fft_line_analysis(x, y, doPlot)
%
%  x, y   = vectors
%  doPlot = true/false for FFT plot only (default = true)
%
%  result = struct with fields:
%      .periods       (nm)
%      .periodError   (nm)
%      .amps
%

if nargin < 3
    doPlot = true;
end

x = x(:);
y = y(:);

N  = length(y);
dx = mean(diff(x));

%% --- Pre-processing ---
y = detrend(y, 'linear');
w = hann(N);
y_proc = y .* w;

%% --- FFT ---
Y = fft(y_proc);
P2 = abs(Y / N);
P1 = P2(1:floor(N/2)+1);
P1(2:end-1) = 2 * P1(2:end-1);

f = (0:floor(N/2)) / (N * dx);

%% --- Peak finding ---
minPeakHeight   = 0.1 * max(P1);
minPeakDistance = 1 / (max(x) - min(x));

[pkAmp, pkLoc, pkWidth] = findpeaks(P1, f, ...
    "MinPeakHeight",   minPeakHeight, ...
    "MinPeakDistance", minPeakDistance, ...
    "WidthReference",  "halfheight");

%% --- Remove first artefact (DC / line length) ---
if ~isempty(pkLoc)
    [~, idxMin] = min(pkLoc);
    pkLoc(idxMin)   = [];
    pkAmp(idxMin)   = [];
    pkWidth(idxMin) = [];
end

if isempty(pkLoc)
    warning("No meaningful peaks found.");
    result = struct();
    return;
end

%% --- Convert to periods & errors ---
freqs      = pkLoc;
periods    = 1 ./ freqs;
freqErr    = pkWidth / 2;
periodErr  = periods .* (freqErr ./ freqs);

%% --- Sort by amplitude and keep top 5 ---
[pkAmp, sortIdx] = sort(pkAmp, "descend");
periods   = periods(sortIdx);
periodErr = periodErr(sortIdx);
freqs     = freqs(sortIdx);

% Keep only top 5
maxPeaks = min(5, numel(pkAmp));
pkAmp    = pkAmp(1:maxPeaks);
periods  = periods(1:maxPeaks);
periodErr= periodErr(1:maxPeaks);
freqs    = freqs(1:maxPeaks);

%% --- Output results struct ---
result.periods     = periods;
result.periodError = periodErr;
result.amps        = pkAmp;

%% ===================
%       Plotting
% ===================

if doPlot
    fig = figure;
    set(fig, 'Color', 'w');   % White figure background

    ax = axes(fig);
    set(ax, 'Color', 'w');    % White axes background
    hold(ax, 'on');
    grid(ax, 'on');

    % Main FFT spectrum
    plot(ax, f, P1, 'k', 'LineWidth', 2);

    % Black axis/labels/ticks
    ax.XColor = 'k';
    ax.YColor = 'k';
    xlabel(ax, 'Spatial Frequency (1/nm)', 'Color','k');
    ylabel(ax, 'Amplitude',              'Color','k');
    title(ax,  'FFT Amplitude Spectrum', 'Color','k');

    xlim(ax, [0 max(f)]);

% --- Plot FFT and peaks ---
plot(ax, f, P1, 'LineWidth', 1.2);
hold(ax, 'on')

peakColors = lines(numel(freqs));   % contrasting colours for lines + text

for i = 1:numel(freqs)
    clr = peakColors(i,:);
    xline(ax, freqs(i), '--', 'Color', clr, 'LineWidth', 1);
    txt = sprintf("%.2f ± %.2f nm", periods(i), periodErr(i));
    yRange = ax.YLim(2) - ax.YLim(1);
    yPos = pkAmp(i) + 0.08 * yRange;

    % Clamp inside axes (never above top limit)
    yPos = min(yPos, ax.YLim(2) - 0.05*yRange);
    text(freqs(i), yPos, txt, ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','bottom', ...
        'Color', clr, ...
        'FontSize', 10, ...
        'Margin', 2)
end

hold(ax, 'off')



end

end
