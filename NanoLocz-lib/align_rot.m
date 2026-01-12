%  Function written for NanoLocz-lib 2025
%  DESCRIPTION:
%  ALIGN_ROT Estimates the rotational alignment between two images using either rotational cross-correlation 
%  or polar coordinate cross-correlation methods.
%
%  Inputs:
%       ref     - Reference image (2D grayscale matrix)
%       T       - Target image to be rotated and aligned to the reference
%       range   - 1x2 vector (eg [-10, 10]) specifying the range of rotation angles to search (degrees) 
%       method  - String specifying the alignment method:
%                   'Rotation corr' - Direct rotational correlation in Cartesian space
%                   'Polar Corr'    - Cross-correlation in polar coordinate space
%
%  Output:
%       rot_ang - Estimated rotation angle (degrees) required to align T to ref
%
%  Method:
%       'Rotation corr':
%           - Rotates the target image over the specified angle range.
%           - Computes the Pearson correlation coefficient between rotated target and reference images.
%           - Uses interpolation and optimization to refine the rotation estimate.
%
%       'Polar Corr':
%           - Transforms both images to polar coordinates.
%           - Uses normalized cross-correlation to determine the angular shift.
%           - Applies sub-pixel interpolation for improved precision.
%
%  Notes:
%       - Input images must be approximately the same size; excess rows/columns are trimmed.
%       - Rotation is limited to ±360 degrees.
%       - Sub-functions: ImToPolar (rectangular to polar conversion) and interpolate (bilinear interpolation).
%       - ImToPolar V0.1 7 Dec 2007 (Created), Prakash Manandhar pmanandhar@umassd.edu

function rot_ang = align_rot(ref, T,range,method)
switch method
    case 'Rotation corr'
        ri = range(1):0.5:range(2);
        if range(2)-range(1) <=20
            ri = range(1):0.2:range(2);
        end

        if nargin <5
        else
            T=T.*(T>thresh);
            ref=ref.*(ref>thresh);
        end

        sz_r = size(ref);
        sz_T = size(T);

        if sz_r(1) > sz_T(1)
            clip = sz_r(1) - sz_T(1);
            ref(1:clip,:)=[];
        elseif sz_r(1) < sz_T(1)
            clip = sz_T(1) - sz_r(1);
            T(1:clip,:)=[];
        end

        if sz_r(2) > sz_T(2)
            clip = sz_r(2) - sz_T(2);
            ref(:,1:clip)=[];
        elseif sz_r(2) < sz_T(2)
            clip = sz_T(2) - sz_r(2);
            T(:,1:clip)=[];
        end

        rot_cor= zeros(1,numel(ri));

        for i = 1:numel(ri)
            Tr = imrotate(T,ri(i),'crop','bicubic');
            rot_cor(i) = corr2(Tr,ref);
        end

        [~,ID] = max(rot_cor(:));
        F = griddedInterpolant(ri,rot_cor,'spline');
        rot_ang = arrayfun(@(xx)fminsearch(@(ri)-F(ri),xx),ri(ID));

        if rot_ang >360
            rot_ang = 360;
        else if rot_ang <-360
                rot_ang = -360;
        end
        end

    case 'Polar Corr'

        %ang = angular resoltuion, use even angles eg 360
        %r = radius
        %re = rescaling factor for subpixel rotation
        ang=360;
        rmin = 0; rmax = 1;
        r =round(min(size(ref))/3);
        re = 100;

        f1 = ImToPolar(ref, rmin, rmax, r, ang);
        ft = [f1(:,ang/2:end),f1, f1(:,1:ang/2)];
        f2 = ImToPolar(T, rmin, rmax, r, ang);
        ccr = normxcorr2(f2,ft);
        ccr = ccr(:,ang+1:2*ang);

        ccr=ccr(:,(range(1)-5+180):(range(2)+5+180));
        ccr(5,:) = 0 ;
        ccr(: , 1) = 0;
        ccr((end-1):end, : ) = 0;
        ccr(: , (end-1):end) = 0;


        [max_c,imax] = max(ccr(:));
        [ypeak,xpeak] = ind2sub(size(ccr),imax(1));

        rot_ang = (xpeak-2) + range(1)-5;
        sd = size(ccr);
        w=4;
        if ypeak-w+1 > 0 && xpeak-w+1 > 0 && ypeak+w-1 < sd(1) && xpeak+w-1 < sd(2)
            clip_c = ccr(ypeak-w+1:ypeak+w-1,xpeak-w+1:xpeak+w-1);
            c_zoom = imresize(clip_c, re, 'bicubic');
            [max_c,imax] = max(abs(c_zoom(:)));
            [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
            corr_offset_2 = [(xpeak2-size(c_zoom,2)/2)/re
                (ypeak2-size(c_zoom,1)/2)/re];

            rot_ang = rot_ang+corr_offset_2(1);
        end

end
end


function imP = ImToPolar (imR, rMin, rMax, M, N)
% IMTOPOLAR converts rectangular image to polar form. The output image is
% an MxN image with M points along the r axis and N points along the theta
% axis. The origin of the image is assumed to be at the center of the given
% image. The image is assumed to be grayscale.
% Bilinear interpolation is used to interpolate between points not exactly
% in the image.
%
% rMin and rMax should be between 0 and 1 and rMin < rMax. r = 0 is the
% center of the image and r = 1 is half the width or height of the image.
%
% V0.1 7 Dec 2007 (Created), Prakash Manandhar pmanandhar@umassd.edu

[Mr Nr] = size(imR); % size of rectangular image
Om = (Mr+1)/2; % co-ordinates of the center of the image
On = (Nr+1)/2;
sx = (Mr-1)/2; % scale factors
sy = (Nr-1)/2;

imP  = zeros(M,  N);

delR = (rMax - rMin)/(M-1);
delT = 2*pi/N;

% loop in radius and
for ri = 1:M
    for ti = 1:N
        r = rMin + (ri - 1)*delR;
        t = (ti - 1)*delT;
        x = r*cos(t);
        y = r*sin(t);
        xR = x*sx + Om;
        yR = y*sy + On;
        imP (ri, ti) = interpolate (imR, xR, yR);
    end
end
end


function v = interpolate (imR, xR, yR)
xf = floor(xR);
xc = ceil(xR);
yf = floor(yR);
yc = ceil(yR);
if xf == xc & yc == yf
    v = imR (xc, yc);
elseif xf == xc
    v = imR (xf, yf) + (yR - yf)*(imR (xf, yc) - imR (xf, yf));
elseif yf == yc
    v = imR (xf, yf) + (xR - xf)*(imR (xc, yf) - imR (xf, yf));
else
    A = [ xf yf xf*yf 1
        xf yc xf*yc 1
        xc yf xc*yf 1
        xc yc xc*yc 1 ];
    r = [ imR(xf, yf)
        imR(xf, yc)
        imR(xc, yf)
        imR(xc, yc) ];
    a = A\double(r);
    w = [xR yR xR*yR 1];
    v = w*a;
end
end