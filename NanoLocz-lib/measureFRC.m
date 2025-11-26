%  This function is part of the NanoLocz GUI and NanoLocz-lib (2025).
%
%   measureFRC - Measures spatial resolution from localization microscopy data using FRC.
%
%   This function calculates the average spatial resolution of a localization 
%   microscopy dataset using the Fourier Ring Correlation (FRC) method. It follows 
%   the general principles of SMAP (Superresolution Microscopy Analysis Platform) by Jonas Ries,
%   with modifications for flexible use.
%
%   The function splits the localization dataset into random subsets, reconstructs 
%   super-resolved images, computes the FRC between image pairs, and determines 
%   the resolution based on the 1/7 threshold criterion.
%
%   Based on:
%   - Ries, J. SMAP: a modular super-resolution microscopy analysis platform for SMLM data.
%     Nat Methods (2020). https://doi.org/10.1038/s41592-020-0938-1
%   - Nieuwenhuizen et al., Measuring image resolution in optical nanoscopy. Nat Methods (2013).
%
%   Original code: Jonas Ries, EMBL Heidelberg (2020), www.rieslab.de, www.github.com/jries/SMAP
%   License: GPLv3
%
%   Adapted by: Tabitha Storer, University of Leeds, 2025
%
%   Syntax:
%       [q, frc_mean, av_resolution, sd_resolution] = measureFRC(locs, pixpernm, runs, expand)
%
%   Inputs:
%       locs      - Nx5 array of localizations: [x y z intensity frame]
%       pixpernm  - Pixel size in nm (scaling factor)
%       runs      - Number of FRC calculations (random splits)
%       expand    - Upsampling factor (to increase image resolution)
%
%   Outputs:
%       q              - Spatial frequency vector (in nm⁻¹ after scaling)
%       frc_mean       - Mean FRC curve across runs
%       av_resolution  - Estimated average spatial resolution (in nm)
%       sd_resolution  - Standard deviation of resolution estimate (in nm)
%
%   Notes:
%   - A Gaussian filter is applied to the reconstructed images prior to FRC.
%   - Resolution is defined as the inverse of the frequency where the FRC curve 
%     first drops below 1/7.
%   - Frames are split randomly in each run to avoid bias.
%
%   Dependencies:
%       Requires MATLAB's Image Processing Toolbox for imgaussfilt.
%
%   Example:
%       [q, frc_mean, av_res, sd_res] = measureFRC(locs, 100, 10, 10);
%

function [q, frc_mean, av_resolution, sd_resolution] = measureFRC(locs,pixpernm,runs,expand)
img_gaus = 0.4;
locs(:,1) = locs(:,1)-min(locs(:,1)) +1;
locs(:,2) = locs(:,2)-min(locs(:,2)) +1;
explocs = [round(locs(:,1:2)*expand), locs(:,3:end)];

nanRows = any(isnan(explocs), 2);
explocs = explocs(~nanRows, :);
imageSize = [max(explocs(:,2))+5,max(explocs(:,1))+5];

frames = unique(locs(:,5));
n = length(frames);
LAFM_p = zeros(imageSize(1),imageSize(2),n);

for i = 1:n
    pos = explocs(:,5)==frames(i);
    sublocs = explocs(pos,:);
    for j = 1:sum(pos)
        LAFM_p(sublocs(j,2),sublocs(j,1),i) = 1;
    end
end
LAFM_p = imgaussfilt(LAFM_p,img_gaus*expand);



for i = 1:runs
    k = size(LAFM_p,3);
    rand_LAFM_p = LAFM_p(:,:,randperm(k));
    img1 = (mean(rand_LAFM_p(:,:,1:round(k/2)),3)); 
    img2 = (mean(rand_LAFM_p(:,:,round(k/2)+1:k),3));
   

    [frc_curve] = getFRC(img1,img2);
    [q, frc_curve, thresh] = getxyt(frc_curve, size(img1));
    q = q.*(expand*pixpernm);
    frc_cur(:,i) = frc_curve;
    resx = findintersection(q, frc_curve, thresh(1));
    resolution(i) = 1/resx;
   
end
mask = isfinite(resolution);
mask_resolution = resolution(mask);
mask_frc=frc_cur(:,mask==1);
frc_mean=mean(mask_frc,2);
resx = findintersection(q, frc_mean, thresh(1));
av_resolution = 1/resx;
sd_resolution = std(mask_resolution);


    function [frc_curve] = getFRC(img1,img2)
        in1=fftshift(fft2(img1));
        in2=fftshift(fft2(img2));
        inc=in1.*conj(in2);
        frc_num=real(radialsum(inc));
        in1 = abs(in1).^2;
        in2 = abs(in2).^2;
        frc_denom = sqrt(abs(radialsum(in1).*radialsum(in2)));                      % Denominator
        frc_curve = double(frc_num)./double(frc_denom);                               % FRC
        frc_curve(isnan(frc_curve)) = 0;
    end

    function [rs] = radialsum(img)
        s=size(img);
        center=floor((s+1)/2);
        rs=zeros(ceil(s(1)/2)+1,1);
        for ii=1:s(1)
            for l=1:s(2)
                d=sqrt((ii-center(1)).^2+(l-center(2)).^2);
                ind=round(d)+1;
                if ind<=length(rs)
                    rs(ind)=rs(ind)+img(ii,l);
                end
            end
        end
    end

% Measure Resolution
    function [q, frc_curve, thresholdcurve] = getxyt(frc_curve,sz)
        sz=sz(1);
        % Check for undesirable values in FRC curve
        frc_curve = real(frc_curve);
        frc_curve(frc_curve>1) = 1;
        frc_curve(frc_curve<-1) = -1;
        % Smooth the FRC curve (via least squares interpolation) 
        %  sspan = ceil(sz/50);  % Smoothing span
        % if (sz/20)<2
        %     sspan = 2;
        % end
        % sspan = sspan  + (1-mod(sspan,2));
        % frc_curve = double(smooth(frc_curve,5,'loess'));
        frc_curve = smooth(frc_curve,5);
        q = (0:(length(frc_curve)-1))'/sz;             % Spatial frequencies
        thresholdcurve = 1/7*ones(size(frc_curve));    % threshold curve
    end

% Find 1st coordinate below t
    function [resx] = findintersection(x, y, t)
        F = griddedInterpolant(x,y);
        xq=x(1):(x(2)-x(1))/10:x(end);  % set x positions to interpolate y at
        yq = F(xq);
        %constraint to remove 
        validIdx = xq > 0.25;
        xq_filtered = xq(validIdx);
        yq_filtered = yq(validIdx);

        pos1 = yq_filtered<=t; 
        r = xq_filtered(pos1); 
        if sum(pos1)>0
            resx = r(1);
        else
            resx = max(x);
        end
    end
end