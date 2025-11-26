%  This function is part of the NanoLocz GUI and NanoLocz-lib (2025).
%
%  AUTHOR: Tabitha Storer, University of Leeds, 30.06.2023
%
%  DESCRIPTION:  
%    This function estimates the rotational center of 
%    symmetry of an image by comparing rotated versions of the image to 
%    the original using cross-correlation alignment.
%
%  INPUTS:
%    fold       - Integer specifying the rotational symmetry (e.g., 2 for 2-fold, 3 for 3-fold, etc.)
%    input_img  - 2D image (grayscale or single channel) to analyze
%    align_exp  - Upsampling factor for subpixel alignment (typically >1 for increased precision)
%
%  OUTPUT:
%    center_translation - Estimated center of rotation as [x y] translation:
%                         - For fold = 2: mean translation (offset/2)
%                         - For fold >2: average translation over all rotations
%                         - For fold = 1: computes center of mass shift relative to image center
%
%  METHOD:
%    - Rotates the image by increments of 360/fold degrees.
%    - Uses cross-correlation to compute translational offsets between 
%      each rotated image and the original.
%    - Optionally refines alignment to subpixel precision using bicubic
%      interpolation.
%    - Computes the average offset as the estimated symmetry center.
%
%  NOTES:
%    - For fold == 1, no rotations are performed; the geometric center 
%      is estimated using the center of mass of the image intensities.
%
%  REQUIREMENTS:
%    - Uses MATLAB Image Processing Toolbox (imrotate, normxcorr2, imresize)


function [center_translation] = FindCenterPositions(fold, input_img, align_exp)

for i = 1:(fold-1)
    img = imrotate(input_img, i*360/fold, 'crop');
    offset(i,:) = ccAlign(img, input_img, align_exp);
end

if fold == 2
    center_translation = offset/2;
elseif fold >2
    center_translation = sum(offset)/fold;
elseif fold ==1
    x = 1 : size(input_img, 2); % Columns.
    y = 1 : size(input_img, 1); % Rows.
    [X, Y] = meshgrid(x, y);
    meanimg = mean(input_img(:));
    centerOfMassX = mean(input_img(:).* X(:)) / meanimg;
    centerOfMassY = mean(input_img(:).* Y(:)) / meanimg;
    center_translation = [centerOfMassX-size(input_img, 2)/2 centerOfMassY-size(input_img, 1)/2];
end


    function [corr_offset ] = ccAlign(img, ref, exp)
        % INPUT:
        % code to align an image (img) to a refrence image (ref)
        % adjust subpixel alignment by factor (exp)
        % OUPUT
        % corr_offset gives x and y value to align
        % to perform shift of img to match ref use imtranslate(img,corr_offset')
        c = normxcorr2(img, ref);
        [~,imax] = max(abs(c(:)));
        [ypeak,xpeak] = ind2sub(size(c),imax(1));  %find position of max cross correlation
        if exp>1
            w=3;
            c(1:4,:) = 0 ;
            c(: , 1:4) = 0;
            c((end-3):end, : ) = 0;
            c(: , (end-3):end) = 0;
            clip_c = c(ypeak-w+1:ypeak+w-1,xpeak-w+1:xpeak+w-1);
            c_zoom = imresize(clip_c, exp, 'bicubic');
            [~,imax] = max(abs(c_zoom(:)));
            [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
            corr_offset_2 = [(xpeak2-size(c_zoom,2)/2)/exp
                (ypeak2-size(c_zoom,1)/2)/exp];
            corr_offset = [(xpeak+corr_offset_2(1)-size(img,2))
                (ypeak+corr_offset_2(2)-size(img,1))];
        else
            corr_offset = [xpeak-size(img,2) ypeak-size(img,1)];
        end
    end
end