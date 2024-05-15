%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   26.04.2024         

function locs = Fast_peaks2D(Img, thresh, kernel_size, min_prom)
% find local maxima above a threshold value 'thresh',
% within a neighbourhood of kernel_size
% with a prominance greater than 'min_prom'
%output = peak [x, y, z, prominace(if min_prom is set)]

kernel_size = kernel_size+2;
max_filtered = ordfilt2(Img, kernel_size^2, true(kernel_size),'zeros');
local_maxima_mask = (max_filtered == Img);
local_maxima_mask = local_maxima_mask & (Img >= thresh);
local_maxima_mask([1:2,(end-2):end],:) = 0; 
local_maxima_mask(:,[1:2,(end-2):end]) = 0;  
[row_indices, col_indices] = find(local_maxima_mask);
peak_co = [col_indices, row_indices];
peak_h = Img(local_maxima_mask);

if any(peak_co)
    locs = [peak_co, peak_h];

%prominance calculation:
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

