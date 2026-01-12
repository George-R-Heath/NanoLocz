% Function written for NanoLocz GUI and NanoLocz-lib (2025)
% 
% This code and method are adapted from the FindSteps.m and PolyfitLineMasked.m 
% scripts from the SPIW project (https://sourceforge.net/projects/spiw/) and combined 
% with NanoLocz leveling methods.
%
% Copyright (C) Richard Woolley & Julian Stirling
% 
% SPIW is free software: you can redistribute it and/or modify it under the terms of 
% the GNU Lesser General Public License as published by the Free Software Foundation, 
% either version 3 of the License, or (at your option) any later version.
%
% Inputs:
%   img        - Input AFM image (2D matrix)
%   polyx      - Polynomial degree for X-direction leveling (integer)
%   polyy      - Polynomial degree for Y-direction leveling (integer)
%   line_plane - Leveling method ('plane', 'line', 'med_line', 'med_line_y', 'smed_line')
%   imgt       - Mask matrix indicating foreground/background (same size as img)
%
% Output:
%   r          - Leveled image (2D matrix)
%
% The function performs leveling of AFM images using polynomial or median-based
% line or plane fitting methods. It calculates weighted fits across masked regions
% and subtracts the resulting background from the image.
%
% Compatible with: NanoLocz GUI and NanoLocz-lib
% License: GNU LGPL v3+

function r = level_weighted(img, polyx, polyy, line_plane, imgt)
mask = (imgt==1);
r=img;
CC = bwconncomp(mask, 8);
min_area = 0.01*CC.ImageSize(1)*CC.ImageSize(2);
numel(CC.PixelIdxList);
for i = 1:numel(CC.PixelIdxList)
    if numel(CC.PixelIdxList{i})<min_area
        pos(i) = 1;
    else
        pos(i) = 0;
    end
end

CC.PixelIdxList(pos>0) = [];
CC.NumObjects = CC.NumObjects -sum(pos);

numRegions = CC.NumObjects;
[rows, cols] = size(img);
regionMatrices = nan(rows, cols, numRegions); 

switch line_plane
    case 'plane'
        for i = 1:numRegions
            pixelIndices = CC.PixelIdxList{i};
            regionMatrix = nan(rows, cols);
            regionMatrix(pixelIndices) = img(pixelIndices);
            regionMatrices(:, :, i) = regionMatrix;
            w(i) = numel(pixelIndices);

            xp = mean(regionMatrix,1,'omitnan');
            xf =  xp(~isnan(xp));
            xl =  1:numel(xp);
            xl =  xl(~isnan(xp));

            [px(:,i),~,mux(:,i)] = polyfit(xl,xf,polyx);

            yp= mean(regionMatrix,2,'omitnan');
            yf =  yp(~isnan(yp));
            yl =  1:numel(yp);
            yl =  yl(~isnan(yp));
            [py(:,i),~,muy(:,i)] = polyfit(yl,yf,polyy);
        end

        W = w/(sum(w));
        W = W.*(W>0.02); %exclude regions with less than 2% area
        px_w = sum(px.*W,2);
        py_w = sum(py.*W,2);
        mux_w = sum(mux.*W,2);
        muy_w = sum(muy.*W,2);
        plane = polyval(px_w,(1:numel(xp))',[],mux_w)' + polyval(py_w,(1:numel(yp))',[],muy_w);
        r = img - plane;
 
    case 'line'
         if polyx>0

             for i = 1:numRegions
                 pixelIndices = CC.PixelIdxList{i};
                 regionMatrix = nan(rows, cols);
                 regionMatrix(pixelIndices) = img(pixelIndices);
                 regionMatrices(:, :, i) = regionMatrix;

                 bg(i) = median(regionMatrices(:,:,i), 'all', 'omitnan');

                 for ii = 1:size(img,1)
                     pos = ~isnan(regionMatrices(ii,:,i));
                     w(ii,i) = sum(pos);

                     if sum(pos) > polyx +1  % Fit polynomial only if enough valid pixels exist
                         xl = find(pos); % X-coordinates of valid pixels
                         xf = img(ii, pos); % Corresponding intensity values
                         % Fit polynomial (e.g., linear or quadratic)
                         [p,~,mu] = polyfit(xl, xf, polyx);
                         for k = 1:numel(p)
                             px{k}(ii,i) = p(k);
                         end
                         mux{1}(ii,i) = mu(1);
                         mux{2}(ii,i) = mu(2);
                     else
                         for k = 1:(polyx +1)
                             px{k}(ii,i) = 0;
                         end
                          mux{1}(ii,i) = 0;
                         mux{2}(ii,i) = 0;
                     end
                 end
             end
             % Compute weighted sum
             W = w ./ (sum(w,2));
             W = W.*(W>0.02); %exclude regions with less than 2% area
             for k = 1:numel(p)
                 px_w(:,k) = sum(px{k}.*W,2);
             end
             px_w(:,end)=0;
             mu_w(:,1) = sum(mux{1}.*W,2);
             mu_w(:,2) = sum(mux{2}.*W,2);
             for i = 1:size(img,1)
                 lines(i,:) = polyval(px_w(i,:),(1:size(img,2)),[],mu_w(i,:));
             end
             r = img - lines;
         end

         if polyy>0

             for i = 1:numRegions
                 pixelIndices = CC.PixelIdxList{i};
                 regionMatrix = nan(rows, cols);
                 regionMatrix(pixelIndices) = img(pixelIndices);
                 regionMatrices(:, :, i) = regionMatrix;

                 bg(i) = median(regionMatrices(:,:,i), 'all', 'omitnan');

                 for ii = 1:size(img,2)
                     pos = ~isnan(regionMatrices(:,ii,i));
                     w(ii,i) = sum(pos);

                     if sum(pos) > polyy +1  % Fit polynomial only if enough valid pixels exist
                         yl = find(pos); % X-coordinates of valid pixels
                         yf = img(pos,ii); % Corresponding intensity values
                         % Fit polynomial (e.g., linear or quadratic)
                         [p,~,mu] = polyfit(yl, yf, polyy);
                         for k = 1:numel(p)
                             py{k}(ii,i) = p(k);
                         end
                         muy{1}(ii,i) = mu(1);
                         muy{2}(ii,i) = mu(2);
                     end
                 end
             end
             % Compute weighted sum
             W = w ./ (sum(w,2));
             W = W.*(W>0.02); %exclude regions with less than 2% area
             for k = 1:numel(p)
                 py_w(:,k) = sum(py{k}.*W,2);
             end
             py_w(:,end)=0;
             muy_w(:,1) = sum(muy{1}.*W,2);
             muy_w(:,2) = sum(muy{2}.*W,2);
             for i = 1:size(img,2)
                 lines(:,i) = polyval(py_w(i,:),(1:size(img,1)),[],muy_w(i,:));
             end
             r = r - lines;
         end
    case 'med_line'
        for i = 1:numRegions
            pixelIndices = CC.PixelIdxList{i};
            regionMatrix = nan(rows, cols);
            regionMatrix(pixelIndices) = img(pixelIndices);
            regionMatrices(:, :, i) = regionMatrix;

            bg(i) =  median(regionMatrices(:,:,i),'all','omitnan');
            for ii =1:size(img,1)
                pos = ~isnan(regionMatrices(ii,:,i));
                w(ii,i) = sum(pos);
                if sum(pos)>2
                    y1(ii,i) = median(img(ii,pos))-bg(i);
                else
                    y1(ii,i) = -bg(i);
                end
            end
            W = w./(sum(w,2));
            yf = sum(W.*y1,2);
            pos = sum(w,2)==0;
            r=img;
            r(~pos,:) = img(~pos,:)-(yf(~pos));
        end
    case 'med_line_y'
        for i = 1:numRegions
            pixelIndices = CC.PixelIdxList{i};
            regionMatrix = nan(rows, cols);
            regionMatrix(pixelIndices) = img(pixelIndices);
            regionMatrices(:, :, i) = regionMatrix;

            bg(i) =  median(regionMatrices(:,:,i),'all','omitnan');
            for ii =1:size(img,2)
                pos = ~isnan(regionMatrices(:,ii,i));
                w(ii,i) = sum(pos);
                if sum(pos)>2
                    y1(ii,i) = median(img(pos,ii))-bg(i);
                else
                    y1(ii,i) = -bg(i);
                end
            end
            W = w./(sum(w,2));
            yf = sum(W.*y1,2);
            pos = sum(w,2)==0;
            r=img;
            r(:,~pos) = img(:,~pos)-(yf(~pos)');
        end
    case 'smed_line'
        for i = 1:numRegions
            pixelIndices = CC.PixelIdxList{i};
            regionMatrix = nan(rows, cols);
            regionMatrix(pixelIndices) = img(pixelIndices);
            regionMatrices(:, :, i) = regionMatrix;

            bg(i) =  median(regionMatrices(:,:,i),'all','omitnan');
            for ii =1:size(img,1)
                pos = ~isnan(regionMatrices(ii,:,i));
                w(ii,i) = sum(pos);
                if sum(pos)>2
                    y1(ii,i) = median(img(ii,pos));
                else
                    y1(ii,i) = -bg(i);
                end
            end

            W = w./(sum(w,2));
            yf = sum(W.*y1,2);

            bg2 = movmedian(yf(:,1),10);
            r = img-(yf-bg2);
        end
end
end







