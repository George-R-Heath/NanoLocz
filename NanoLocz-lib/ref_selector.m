% GUI Function written for NanoLocz-lib (2025)
% ref_selector - Select and optionally center a reference region from an image stack
%
% Inputs:
%   d       - 3D image stack
%   center  - Set to 'yes' to center the reference (optional)
%   fold    - Rotational symmetry fold (optional, numeric)
%
% Output:
%   ref     - Cropped reference region image

function ref = ref_selector(d, center, fold)

% --- Preprocess for display ---
dg = imgaussfilt(d, 0.7);            % Smooth for display
d1 = dg(:, :, 1);                    % Use first frame
prc = double(prctile(d1(:), [1 99])); % Display contrast
d1_disp = mat2gray(d1, prc);         % Rescale for imshow

% --- Get crop from user ---
[ref, rect] = get_crop_region(d1, d1_disp);
if isempty(ref)
    warning('No reference selected.');
    return;
end

if exist('center', 'var') && strcmp(center, 'yes') && exist('fold', 'var') && fold > 1
    center_translation = FindCenterPositions(fold, ref, 1);
    ref = imtranslate(ref, -center_translation);
end


if exist('fold', 'var') && ~isempty(fold) && fold > 1
    ref = rotation_sym(ref, fold);
end

end

% --- Helper function to get crop using ENTER key ---
function [ref_crop, rect] = get_crop_region(d_orig, d_display)
    figure;
    imshow(d_display, []);
    title('Draw reference region and press Enter');
    h = drawrectangle();  % User draws ROI
    wait(h);              % Wait for ENTER

    if isempty(h.Position)
        ref_crop = [];
        rect = [];
    else
        rect = round(h.Position);            % [x y width height]
        ref_crop = imcrop(d_orig, rect);     % Crop from original image
    end

    close;
end
