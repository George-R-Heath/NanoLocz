%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        Tabitha Storer, University of Leeds, 30.06.2023         

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
        [max_c,imax] = max(abs(c(:)));
        [ypeak,xpeak] = ind2sub(size(c),imax(1));  %find position of max cross correlation
        if exp>1
            w=3;
            c(1:4,:) = 0 ;
            c(: , 1:4) = 0;
            c((end-3):end, : ) = 0;
            c(: , (end-3):end) = 0;
            clip_c = c(ypeak-w+1:ypeak+w-1,xpeak-w+1:xpeak+w-1);
            c_zoom = imresize(clip_c, exp, 'bicubic');
            [max_c,imax] = max(abs(c_zoom(:)));
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