% FAST_PEAKS2D Fast 2D peak detection for NanoLocz GUI and NanoLocz-lib (2025)
%
% DESCRIPTION:
%   Detects local maxima (peaks) in a 2D image above a specified intensity threshold,
%   within a local neighborhood, and optionally filters peaks by prominence.
%
% USAGE:
%   locs = Fast_peaks2D(Img, thresh, kernel_size)
%   locs = Fast_peaks2D(Img, thresh, kernel_size, min_prom)
%
% INPUTS:
%   Img         - 2D image (grayscale, numeric matrix) for peak detection.
%   thresh      - Intensity threshold; only peaks above this value are considered.
%   kernel_size - Size of the local neighborhood used for maximum filtering (in pixels).
%   min_prom    - (Optional) Minimum required prominence of peaks. Peaks with lower prominence are discarded.
%
% OUTPUT:
%   locs        - Nx4 array where each row represents a detected peak:
%                [x_position, y_position, peak_height, prominence]
%                If min_prom is not provided, prominence is set to zero.
%
% NOTES:
% - The function uses morphological maximum filtering and optional prominence filtering.
% - Edge pixels (within 2 pixels of the image boundary) are excluded from detection.
% - Prominence is computed as the vertical distance to the lowest point along the path
%   to the nearest higher neighboring peak.
%
% AUTHOR:
%   George Heath, University of Leeds
%   g.r.heath@leeds.ac.uk

function locs = Fast_peaks2D(Img, thresh, kernel_size, min_prom)

kernel_size = kernel_size+2;
max_filtered = ordfilt2(Img, kernel_size^2, true(kernel_size),'zeros');
local_maxima_mask = (max_filtered == Img);
local_maxima_mask = local_maxima_mask & (Img > thresh);
local_maxima_mask([1:2,(end-2):end],:) = 0; 
local_maxima_mask(:,[1:2,(end-2):end]) = 0;  
[row_indices, col_indices] = find(local_maxima_mask);
peak_co = [col_indices, row_indices];
peak_h = Img(local_maxima_mask);

if any(peak_co)
    locs = [peak_co, peak_h];

% prominance calculation:
    if nargin ==4 && min_prom>0
        if any(peak_co)
            for j = 1:numel(peak_co(:,1))
                di = (peak_co(j,1:2)-peak_co(:,1:2)).^2;
                d = sum(di,2).^0.5; %distance
                [~, order_id] = sort(d);

                if peak_h(j) >= peak_h(:)
                    prom(j) = peak_h(j);
                else
                    pos = (peak_h(order_id) > peak_h(j));
                    V1 = find(pos,1,'first'); %find closest peak with greater height
                    prom(j) = peak_h(j) - min(improfile(Img,[peak_co(order_id(V1),1), peak_co(j,1)],...
                        [peak_co(order_id(V1),2), peak_co(j,2)]));
                end
            end
        end
        keep_locs = prom>min_prom;
        locs = [locs(keep_locs,:), prom(keep_locs)'];
    else
        locs = [locs, zeros(numel(locs(:,1)),1)];
    end
else
    locs = [];
end

