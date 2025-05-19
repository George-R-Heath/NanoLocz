
%Modified version of code available in SMAP: https://github.com/jries/SMAP

%COPYRIGHT: Jonas Ries, 2020 LICENSE: GPLv3 AUTHOR: Jonas Ries, EMBL Heidelberg, ries@embl.de 27.03.2020 
% www.rieslab.de, www.github.com/jries/SMAP
% Ries, J. SMAP: a modular super-resolution microscopy analysis platform for SMLM data. Nat Methods (2020). https://doi.org/10.1038/s41592-020-0938-1 
% Based on Nieuwenhuizen, Lidke, Bates, Puig, Grunwald, Stallinga, and Rieger, 
% Measuring image resolution in optical nanoscopy., Nat Methods, 10 (2013).

function [q, frc_mean, av_resolution, sd_resolution] = measureFRC_smap(locs,pixpernm,runs,expand)
img_gus = 0.2;

locs(:,1) = locs(:,1)-min(locs(:,1)) +2;
locs(:,2) = locs(:,2)-min(locs(:,2)) +2;
explocs = [round(locs(:,1:2)*expand), locs(:,3:end)];

nanRows = any(isnan(explocs), 2);
explocs = explocs(~nanRows, :);
imageSize = [max(explocs(:,1))+1,max(explocs(:,1))+1];

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
LAFM_p = imgaussfilt(LAFM_p,img_gus*expand/2);

for i = 1:runs
    k = size(LAFM_p,3);
    rand_LAFM_p = LAFM_p(:,:,randperm(k));
    img1 = mean(rand_LAFM_p(:,:,1:round(k/2)),3); %may need to make equal no of frames in each image
    img2 = mean(rand_LAFM_p(:,:,round(k/2)+1:k),3);

    [frc_curve] = getFRC(img1,img2);
   % [Q] = FSC(img1,img2); alternative FRC code
   % frc_curve = Q.frc;

    [q, frc_curve, thresh] = getxyt(frc_curve, size(img1));
    frc_mean(:,i) = frc_curve;

    resx = findintersection(q, frc_curve, thresh(1));
    resolution(i) = 1/resx;
end
frc_mean = mean(frc_mean,2);
av_resolution = mean(resolution)/pixpernm/expand;
sd_resolution = std(resolution)/pixpernm/expand;

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
        sspan = ceil(sz/50);      % Smoothing span
        if (sz/20)<2
            sspan = 2;
        end
        sspan = sspan  + (1-mod(sspan,2));
        frc_curve = double(smooth(frc_curve,5,'loess'));
        q = (0:(length(frc_curve)-1))'/sz;             % Spatial frequencies
        thresholdcurve = 1/7*ones(size(frc_curve));    % threshold curve
    end

% Find 1st coordinate below t
    function resx = findintersection(x, y, t)
        ysmooth = smooth(y,8);
        F = griddedInterpolant(x,ysmooth);
        xq=x(1):(x(2)-x(1))/10:x(end);  % set x positions to interpolate y at
        yq = F(xq);
        pos1 = yq<=t;
        r = xq(pos1);
        if sum(pos1)>0
            resx = r(1);
        else
            resx = max(x);
        end
    end
end
