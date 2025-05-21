
function target = filter_movie(target, filt1, strength1, filt2, strength2)
filt{1} = filt1;          strength{1} = strength1;
if nargin >3
    filt{2} = filt2;         strength{2} = strength2;
end
n = size(target,3);

%% Filter Options:
% 'Gaussian' - Gaussian smoothing
% '-Gaussian' - Subtract Gaussian smoothing
% 'Sphere' - Sphere-shaped convolution
% 'Wiener' - Adaptive noise reduction based on local image statistics.
% 'Non-local-means' - Noise reduction by averaging similar patches across the image.
% 'Disk' - Disk-shaped convolution
% 'ButterLP' - Butterworth low-pass filter
% 'ButterHP' - Butterworth high-pass filter
% 'ButterBP' - Butterworth band-pass filter
% 'Lap' - Subtract weighted Laplacian
% 'Deconv' - Sphere deconvolution
% 'Peak-sharpen' - Peak sharpening
% 'SAvg' - Subtract video average (reduce threshold to 0.1)
% 'RAvg' - Running average of specified frames

%%
for i =1:numel(filt)
    if strength{i}>0
        if strcmp('Gaussian', filt{i})
            if strength{i} ==0
                strength{i} = 0.01;
            else
            end
            target = imgaussfilt(target,strength{i});
        elseif strcmp('-Gaussian',filt{i})
            if strength{i} ==0
                strength{i} = 0.01;
            else
            end
            target = target - imgaussfilt(target,strength{i});
        elseif strcmp('Wiener', filt{i})
            if strength{i} >=2
                for j=1:n
                    target(:,:,j) = wiener2( target(:,:,j),[strength{i},strength{i}]);
                end
            end
        elseif strcmp('Non-local-means',filt{i})
            if strength{i} ==0
                strength{i} = 0.01;
            else
            end
             for j=1:n
            target(:,:,j) =  imnlmfilt(target(:,:,j),'DegreeOfSmoothing',strength{i});
             end
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
        elseif strcmp('ButterLP', filt{i})
            fs = 1; % Sampling frequency in Hz
            order = 1; % Order of the filter
            try
                [b, a] = butter(order, strength{i}/(fs/2), 'low');
            catch
                [b, a] = butter(order, 0.49/(fs/2), 'high');
            end
            sz = size(target);
            for j=1:n
                img1 = target(:,:,j);
                for ii = 1:sz(1)
                    img2(ii,:) = filtfilt(b, a, img1(ii,:));
                end
                target(:,:,j) = img2;
            end
            %% High pass methods

        elseif strcmp('ButterHP', filt{i})
            fs = 1; % Sampling frequency in Hz
            order = 1; % Order of the filter
            try
                [b, a] = butter(order, strength{i}/(fs/2), 'high');
            catch
                [b, a] = butter(order, 0.49/(fs/2), 'high');
            end
            sz = size(target);
            for j=1:n
                img1 = target(:,:,j);
                for ii = 1:sz(1)
                    img2(ii,:) = filtfilt(b, a, img1(ii,:));
                end
                target(:,:,j) = img2;
            end
        elseif strcmp('Laplacian', filt{i})
            h = fspecial('laplacian',0.2);
            %h = [-1 -1 -1; -1 8 -1; -1 -1 -1];
            %target = imfilter(target, h, 'replicate');
            lap = imfilter(imgaussfilt(target,0.6),h,'replicate');
            lap = rescale(lap);
            target = rescale(-strength{i}*lap+target);

        elseif strcmp('-Average', filt{i})
            d_av = mean(target,3);
            target = target - d_av.*strength{i};
        elseif strcmp('Deconv', filt{i})
            if  strength{i}>0
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
                target = deconvlucy(target,H,1);
            end

        elseif strcmp('Peak sharp', filt{i})
            if  strength{i}>0
                sz = size(target);
                for j=1:n
                    for ii = 1:sz(1)
                        img2(ii,:,j) = sharpen(1:sz(2),target(ii,:,j),strength{i},0,3);
                    end
                end
                target = img2;
            end
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

            %% Combined high low filters
        elseif strcmp('ButterBP', filt{i})
            fs = 1; % Sampling frequency in Hz
            order = 1; % Order of the filter
            low_cutoff = strength{i}(1); % Lower cutoff frequency
            high_cutoff = strength{i}(2); % Upper cutoff frequency
            try
                [b, a] = butter(order, [low_cutoff high_cutoff]/(fs/2), 'bandpass');
            catch
                [b, a] = butter(order, [0.01 0.49], 'bandpass'); % Fallback values
            end

            sz = size(target);
            for j = 1:n
                img1 = target(:,:,j);
               for ii = 1:sz(1)
                    img2(ii,:) = filtfilt(b, a, img1(ii,:));
                end
                target(:,:,j) = img2;
            end

        end
    end
end
