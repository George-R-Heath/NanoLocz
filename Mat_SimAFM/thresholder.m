%%  Function written for NanoLocz GUI and NanoLocz-lib (2025) 
% thresholder - Apply thresholding and edge detection methods to images
%
% DESCRIPTION:
%   Supports multiple thresholding and edge detection methods:
%     'selection'     - input User mask (for hand drawn masks)
%     'histogram'     - Threshold by intensity limits
%     'otsu'          - Otsu automatic thresholding
%     '2 level otsu'  - Two-level Otsu thresholding
%     'auto edges'    - Sobel gradient edge detection with morphology
%     'hist edges'    - Histogram threshold + edge detection
%     'otsu edges'    - Otsu threshold + edge detection
%     'otsu skel'     - Otsu threshold + skeletonization
%     'hist skel'     - Histogram threshold + skeletonization
%     'line_step'     - Step detection along rows using change points
%     'adaptive'      - Adaptive Sobel edge detection with morphology
%
% INPUTS:
%   img     - Input image (2D or 3D)
%   method  - Thresholding method (string)
%   limits  - Numeric thresholds or intensity limits
%   invert  - Flag (1 to invert mask, 0 otherwise)
%
% OUTPUT:
%   imgt    - Thresholded/processed image with NaNs masking excluded regions
%
% NOTES:
% 'Edge' method code is adapted and based on the FindSteps.m script from SPIW
% (https://sourceforge.net/projects/spiw/)
% Copyright (C) Richard Woolley & Julian Stirling 
% SPIW is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.% 


function [imgt] = thresholder(img, method, limits, invert)
 imgt =img;

switch method
    case 'selection'
        imgt = imgt.*1;       imgt(imgt==0)= nan;
    case 'histogram'
        min_max = [limits(1) limits(2)];
        imgt = (img<=min_max(2)).*(img>=min_max(1));
        imgt(imgt==0) = NaN;

    case 'otsu'
        min_max(2) = multithresh(img,1);
        min_max(1) = -inf;
        imgt = (img<=min_max(2)).*(img>=min_max(1));
        imgt(imgt==0) = NaN;

    case '2 level otsu'
        min_max = multithresh(img,2);
        imgt = (img<=min_max(2)).*(img>=min_max(1));
        imgt(imgt==0) = NaN;
        % wind = 1:100:size(img,1);
        % for i = 1:numel(wind)-1
        %     min_max(2) = multithresh(img(wind(i):wind(i+1),:),1);
        %     min_max(1) = -inf;
        %     imgt(wind(i):wind(i+1),:) = (img(wind(i):wind(i+1),:)<=min_max(2)).*(img(wind(i):wind(i+1),:)>=min_max(1));
        % end
        % imgt(imgt==0) = NaN;
    case 'auto edges'
        h= imgaussfilt(img,2);
        sob = fspecial('sobel');
        xgrad = imfilter(h,sob','replicate');
        ygrad = imfilter(h,sob,'replicate');
        ygrad = ygrad -0.5*median(ygrad,2);
        Grad = (2*xgrad.^2)+ygrad.^2;
        IM = Grad;
        if exist('limits','var') && numel(limits) >= 2 && ~isempty(limits(2)) && limits(2) > 0
            thresh = min(IM(:)) + (mean(IM(:)) - min(IM(:))) * limits(2);
            thickness = round(limits(1));
        else
            thresh = min(IM(:)) + (mean(IM(:)) - min(IM(:))) * 1.5;
            thickness = 5;
        end
        BW = IM>thresh;
        BW = bwareaopen(BW,100);
        BW = ~bwareaopen(~BW,50);
        se = strel('diamond', thickness);
        BW = imclose(BW, se);
        BW = imdilate(BW,se);
        BW = imclose(BW, se);
         BW =bwmorph(BW,'bridge');
         
        imgt = double(~BW);
        imgt(imgt==0) = NaN;
    case 'hist edges'
        h= imgaussfilt(img,2);
        min_max = [limits(1) limits(2)];
        imgt = (h<=min_max(2)).*(h>=min_max(1));
        imgt = ~imgt;
        if numel(size(img)) ==2
            BW = bwmorph(imgt,'remove');
            se = strel('disk', 3);
            BW = imdilate(BW,se);
        else
            for i = 1:size(img,3)
                BW(:,:,i) = bwmorph(imgt(:,:,i),'remove');
                se = strel('disk', 3);
                BW(:,:,i) = imdilate(BW(:,:,i),se);
            end
        end
        imgt = double(~BW);
        imgt(imgt==0) = NaN;

    case 'otsu edges'
        h = imgaussfilt(img,2);
        min_max(2) = multithresh(h,1);
        min_max(1) = -inf;
        imgt = (h<=min_max(2)).*(h>=min_max(1));
        imgt = ~imgt;
        
        if numel(size(img)) ==2
            BW = bwmorph(imgt,'remove');
            BW = bwareaopen(BW,100);
            BW = ~bwareaopen(~BW,50);
            se = strel('disk', 3);
            BW = imdilate(BW,se);
                    BW = bwareaopen(BW,100);
        BW = ~bwareaopen(~BW,50);
        else
           
            BW = imgt;
            for i = 1:size(img,3)
                BW(:,:,i) = bwmorph(imgt(:,:,i),'remove');
                BW(:,:,i) = bwareaopen(BW(:,:,i),100);
                BW(:,:,i) = ~bwareaopen(~BW(:,:,i),50);
                se = strel('disk', 3);
                BW(:,:,i) = imdilate(BW(:,:,i),se);
            end
        end
        imgt = double(~BW);
        imgt(imgt==0) = NaN;


    case 'otsu skel'
        mbl = 10;
        h = imgaussfilt(img,2);
        min_max(2) = multithresh(h,1);
        min_max(1) = -inf;
        imgt = (h<=min_max(2)).*(h>=min_max(1));
        imgt = ~imgt;

        [clusters, nclus]=bwlabeln(imgt);

        BW=bwmorph(clusters, 'thin', Inf) ;
        BW = bwskel(logical(BW),'MinBranchLength',mbl);
        BW = bwmorph(BW, 'spur',2) ;
        BW = bwmorph(BW,'clean');

        imgt = double(~BW);
        imgt(imgt==0) = NaN;

    case 'hist skel'
        mbl = 10;
        h= imgaussfilt(img,2);
        min_max = [limits(1) limits(2)];
        imgt = (h<=min_max(2)).*(h>=min_max(1));
        imgt = ~imgt;
        [clusters, nclus]=bwlabeln(imgt);

        BW = zeros(size(img));
        for i = 1:size(img,3)
            BW(:,:,i)=bwmorph(clusters(:,:,i), 'thin', Inf) ;
        end
        BW= bwskel(logical(BW),'MinBranchLength',mbl);
        for i = 1:size(img,3)
            BW(:,:,i) = bwmorph(BW(:,:,i), 'spur',2) ;
            BW(:,:,i) = bwmorph(BW(:,:,i),'clean');
        end

        imgt = double(~BW);
        imgt(imgt==0) = NaN;


    case 'line_step'
        for j =1:size(img,1)
            x = img(j,:);
            xp = x;
            cps= findchangepts(x,'Statistic','linear','MinThreshold',limits(2));
            cps(cps<4)=[];
            cps(cps>size(img,1)-4)=[];
            if any(cps)
                for i = 1:(numel(cps)+1)
                    if i==1
                        if mean(x(cps(i)-3:cps(i))) < mean(x(cps(i):cps(i)+3))
                            xp(1:cps(i)) = 1;
                        else
                            xp(1:cps(i)) = NaN;
                        end

                    elseif i == (numel(cps)+1)
                        if mean(x(cps(i-1)-3:cps(i-1))) > mean(x(cps(i-1):cps(i-1)+3))
                            xp(cps(i-1):end) = 1;
                        else
                            xp(cps(i-1):end) = NaN;
                        end

                    else
                        if mean(x(cps(i)-3:cps(i))) < mean(x(cps(i):cps(i)+3))
                            xp(cps(i-1):cps(i)) = 1;
                        else
                            xp(cps(i-1):cps(i)) = NaN;
                        end
                    end
                end
            else
                xp = 1;
            end
            imgt(j,:) = xp;
        end

    case 'adaptive'
        %T = adaptthresh(img,'Statistic','median','NeighborhoodSize', [5 5],'Fore','bright');
        T=edge(imgaussfilt(img,0.1),'sobel');
        SE = strel("disk",10);
        T = imclose(T,SE);
        T = bwareaopen(T, 10);
        se1 = strel('line',10,90);
        dilatedI = imdilate(T,se1);
        SE = strel('line',10,0);
        dilatedI = imdilate(dilatedI,SE);
        D = padarray(dilatedI,[0,1],1,'both');
        D = imfill(D,'holes');
        D = imerode(D,SE);
        D = imerode(D,se1);
        Dfin = D(:,2:end-1);
        min_max = [limits(1) limits(2)];

        imgt = (Dfin==0).*(img<=min_max(2)).*(img>=min_max(1));
        imgt(imgt==0) = NaN;
    case 'parachute'
        
        if exist('limits','var') && numel(limits) >= 2 && ~isempty(limits(2))
            direction = limits(2);
            F = limits(1);
        else
            F = 1;
            direction = 1;
        end
        
        h = direction.*gradient(img);
        h= imgaussfilt(h,1);
        BW = h;
        
        for i =1:numel(h(1,1,:))
            I = h(:,:,i);
            thresh = -F*1.2*std(I(:));
            thresh2 = -5*std(I(:));
            BW(:,:,i) = (h<=thresh).*(h>=thresh2);
            BW(:,:,i) = bwareaopen(BW(:,:,i),10);
        end
         imgt = double(~BW);
        imgt(imgt==0) = NaN;
end

if invert ==1
    pos = isnan(imgt);
    imgt =pos.*img;
    imgt(imgt==0) = NaN;
end


end

                    
