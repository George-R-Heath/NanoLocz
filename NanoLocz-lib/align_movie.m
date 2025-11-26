%   DESCRIPTION:   Function written for NanoLocz-lib 2025
%   ALIGN_MOVIE Estimates alignment required for frames of a movie or image 
%   stack relative to a reference image.
%
%   Inputs:
%       ImageTarget  - The image or image stack to be aligned
%       ref          - Reference image used for alignment
%       pixel_shift  - Boolean flag to allow/disallow whole-pixel shifting
%       full_image   - Boolean flag to indicate whether to use full image or cropped region
%       sub_pix      - Boolean flag to enable sub-pixel alignment
%       filt_cr      - Filter strength to reduce noise for alignment accuracy
%
%   Outputs:
%       x - Estimated x-shift(s) for alignment
%       y - Estimated y-shift(s) for alignment

function [x,y] = align_movie(ImageTarget,ref,pixel_shift,full_image,sub_pix,filt_cr)


ImageTarget(isnan(ImageTarget)) = 0;
if full_image == 0
    try
        refimg = ref.image;
    catch
        refimg = ImageTarget(:,:,1);
    end

else
    refimg = ref;
end

sz = size(ImageTarget);
window = round(pixel_shift+1);
n = sz(3);

for i = 1:n
    ccr = normxcorr2(refimg, ImageTarget(:,:,i));
    ccr_sz = size(ccr);

    if filt_cr>0
        ccr = imgaussfilt(ccr , filt_cr);
    end
    [~,imax] = max(abs(ccr(:)));
    [y(i),x(i)] = ind2sub(size(ccr),imax(1));


    if pixel_shift>0 && i >1
        if (y(i-1)-window+1)>0 && (y(i-1)+window-1)< ccr_sz(1) && (x(i-1)-window+1) > 0 && x(i-1)+window-1 < ccr_sz(2)
            ccr_p  = ccr(y(i-1)-window+1:y(i-1)+window-1,x(i-1)-window+1:x(i-1)+window-1);
            [~,imax] = max(abs(ccr_p(:)));
            [yw(i),xw(i)] = ind2sub(size(ccr_p),imax(1));  %find position of max cross correlation


            xw(i) = xw(i) - window;
            yw(i) = yw(i) - window;

            x(i) = x(1) + sum(xw(1:i));
            y(i) = y(1) + sum(yw(1:i));

            if sub_pix == 1
                c_wind = 3;
                clip_c = ccr(y(i)-c_wind+1:y(i)+c_wind-1,x(i)-c_wind+1:x(i)+c_wind-1);
                c_zoom = imresize(clip_c, 100, 'bicubic');


                [~,imax] = max(abs(c_zoom(:)));
                [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
                x_offset_2(i) = (xpeak2-size(c_zoom,2)/2)/100;
                y_offset_2(i) = (ypeak2-size(c_zoom,1)/2)/100;
            else
                x_offset_2(i) = 0;
                y_offset_2(i) = 0;
            end

        else
        end
    end

    if i ==1 || pixel_shift == 0
        if sub_pix == 1
            c_wind = 3;
            clip_c = ccr(y(i)-c_wind+1:y(i)+c_wind-1,x(i)-c_wind+1:x(i)+c_wind-1);
            c_zoom = imresize(clip_c, 100, 'bicubic');
            [~,imax] = max(abs(c_zoom(:)));
            [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
            x_offset_2(i) = (xpeak2-size(c_zoom,2)/2)/100;
            y_offset_2(i) = (ypeak2-size(c_zoom,1)/2)/100;
        else
            x_offset_2(i) = 0;
            y_offset_2(i) = 0;
        end
    else
    end

end

if full_image == 0
    try
        sz(2) = round(ref.position(1) + ref.position(3));
        sz(1) = round(ref.position(2) + ref.position(4));
    catch
    end
end

x = x' + x_offset_2(:)-sz(2);
y = y' + y_offset_2(:)-sz(1);
end