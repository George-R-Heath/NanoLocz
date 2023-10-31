%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function target = filter_movie(target, filt1, strength1, filt2, strength2,d_av)
filt{1} = filt1;          strength{1} = strength1;
filt{2} = filt2;         strength{2} = strength2;
n = size(target,3);
% filter options: 
% 'gauss' - gaussian
% 'sphere' - sphere shaped conv

% 'dog'   - difference of gaussians
% 'SAvg'  - subtract video average - recommend reduce thresh to 0.1
% 'RAvg'  - running average of strength number of frames
% 'SRMed' - subtract running median of strength number of frames)

for i =1:numel(filt)
    if strength{i}>0
    if strcmp('Gaussian', filt{i})
        target = imgaussfilt(target,strength{i});
  
    elseif strcmp('Disk',filt{i})
        P = strength{i}+1;
        offs = round(P)- P;
        [hx,hy] = ndgrid(-(P):(P));
        hx = hx-offs;
        hy = hy-offs;
        H = real(sqrt((-(hx.^2)-(hy.^2)+P^2)))>P/2;
        H=H./(sum(H(:)));
         if offs>0
             H = H(2:end , 2:end);
         end

        for j=1:n
            target(:,:,j) = imfilter(target(:,:,j),H);
        end

    elseif strcmp('Sphere',filt{i})
        P = strength{i}+1;
        offs = round(P)- P;
        [hx,hy] = ndgrid(-(P):(P));
        hx = hx-offs;
        hy = hy-offs;
        H = real(sqrt((-(hx.^2)-(hy.^2)+P^2)));
        H=H./(sum(H(:)));
         if offs>0
             H = H(2:end , 2:end);
         end

        for j=1:n
            target(:,:,j) = imfilter(target(:,:,j),H);
        end

    elseif strcmp('Diff Gauss', filt{i})
        gauss1 = imgaussfilt(target,strength{i});
        gauss2 = imgaussfilt(target,strength{i}*1.5);
        target = gauss1 -gauss2;

    elseif strcmp('-Average', filt{i})
       % d_av = mean(target,3);
        target = target - d_av.*strength{i};

    elseif strcmp('High-pass', filt{i})
        for j=1:n
            [mx, ny] =size( target(:,:,j));
            ft = fft2( target(:,:,j));
            f_shift = fftshift(ft);
            ps = mx/2;
            qs = ny/2;
            for ii=1:mx
                for jj=1:ny
                    distance = sqrt((ii-ps)^2+(jj-qs)^2);
                    low_filter(ii,jj) = 1-exp(-(distance)^2/(2*(strength{i})));
                end
            end
            filter_apply = f_shift.*low_filter;
            image_orignal = ifftshift(filter_apply);
            target(:,:,j) = abs(ifft2(image_orignal));
        end

    elseif strcmp('RAvg', filt{i})
        target = movmean(target,strength{i},3);
    end
    end
end
