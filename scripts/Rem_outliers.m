function [Locs] = Rem_outliers(Locs, threshold)

    % Ensure (x, y) are not NaN
    validRows = all(~isnan(Locs(:,1:2)), 2);
    Locs_valid = Locs(validRows, :);

    % Compute z-scores on x and y only
    z = abs(zscore(Locs_valid(:,1:2)));
    idx_keep_valid = all(z < threshold, 2);

    % Final indices to keep in original array
    idx_keep = false(size(Locs,1),1);
    idx_keep(find(validRows)) = idx_keep_valid;

    % Return only kept rows
    Locs = Locs(idx_keep, :);
end