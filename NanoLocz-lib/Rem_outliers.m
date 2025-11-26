% Function written for NanoLocz GUI and NanoLocz-lib (2025)
function [Locs] = Rem_outliers(Locs, threshold)
    validRows = all(~isnan(Locs(:,1:2)), 2);
    Locs_valid = Locs(validRows, :);
    z = abs(zscore(Locs_valid(:,1:2)));
    idx_keep_valid = all(z < threshold, 2);
    idx_keep = false(size(Locs,1),1);
    idx_keep(find(validRows)) = idx_keep_valid;
    Locs = Locs(idx_keep, :);
end