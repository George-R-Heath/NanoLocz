%  Function written for NanoLocz GUI and NanoLocz-lib (2025)
%  
%  DESCRIPTION:  Background leveling and flattening for AFM images.
%                Supports multiple leveling strategies including polynomial 
%                line/plane subtraction, median line correction, smoothed 
%                median flattening, mean subtraction, and logarithmic fits.
%                Written for NanoLocz: Localization Atomic Force Microscopy
%                Analysis Platform.
%
%  INPUTS:
%     img         - Input AFM image or stack (2D or 3D array)
%     polyx       - Polynomial order for X-direction leveling (set 0 to skip)
%     polyy       - Polynomial order for Y-direction leveling (set 0 to skip)
%     line_plane  - Leveling method: 'plane', 'line', 'med_line', 
%                   'med_line_y', 'smed_line', 'mean_plane', or 'log_y'
%     imgt        - Optional binary mask or weighting matrix (same size as img)
%
%  OUTPUTS:
%     r           - Leveled image or image stack
%
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023


function [r] = level(img, polyx, polyy, line_plane, imgt)

sd = size(img);
if numel(sd)>2
    n=sd(3);
else
    n=1;
end
r= img;
for k = 1:n

    if exist('imgt','var')
    else
        imgt = img>-inf;
    end
    switch line_plane
        case 'plane'
            nonNaNs = sum(~isnan(imgt(:,:,k)), 'all');
            if nonNaNs>5
                xp = mean(imgt(:,:,k).*img(:,:,k),1,'omitnan');
                xf =  xp(~isnan(xp));
                xl =  1:numel(xp);
                xl =  xl(~isnan(xp));
                [p,~,mu] = polyfit(xl,xf,polyx);
                r(:,:,k) = img(:,:,k) - polyval(p,(1:numel(xp))',[],mu)';

                yp= mean(imgt(:,:,k).*r(:,:,k),2,'omitnan');
                yf =  yp(~isnan(yp));
                yl =  1:numel(yp);
                yl =  yl(~isnan(yp));
                [p,~,mu] = polyfit(yl,yf,polyy);

                r(:,:,k) = r(:,:,k) - polyval(p,(1:numel(yp))',[],mu);
            end
        case 'line'
            if polyx>0
                xl = 1:size(img,2);
                mask_line = [];
                for i =1:size(img,1)
                    pos = imgt(i,:,k)>0;
                    if sum(pos)>polyx+8
                        y1 = img(i,pos,k);
                        x1 =  xl(pos);
                        [p,~,mu] = polyfit(x1,y1,polyx);
                        y2(i,:) =  polyval(p,1:size(img,2),[],mu);
                        r(i,:,k) = img(i,:,k) -y2(i,:);
                    else
                        mask_line = [mask_line,i];
                    end
                end
                for i =mask_line
                    try
                        r(i,:,k) = img(i,:,k) - median(y2);
                    catch
                    end
                end

            end

            if polyy>0

                for i =1:size(img,2)
                    yp = imgt(:,i,k).*r(:,i,k);
                    yf =  yp(~isnan(yp));
                    yl = (1:size(img,1));
                    yl =  yl(~isnan(yp));
                    if numel(yl)<polyy
                        r(i,:,k) = img(i,:,k);
                    else
                        [p,~,mu] = polyfit(yl,yf,polyy);
                        r(:,i,k) = r(:,i,k) - polyval(p,(1:size(img,1))',[],mu);
                    end
                end
            end

        case 'med_line'
            bg =  median(imgt(:,:,k).*r(:,:,k),'all','omitnan');
            for i =1:size(img,1)
                pos = ~isnan(imgt(i,:,k));
                if sum(pos)>10
                    y1(i,:) = median(img(i,pos,k));
                    if polyx>0
                        r(i,:,k) = img(i,:,k) - polyx*y1(i,:)+bg;
                    else
                        r(i,:,k) = img(i,:,k) - y1(i,:)+bg;
                    end
                end
            end
        case 'med_line_y'
            bg =  median(imgt(:,:,k).*r(:,:,k),'all','omitnan');
            for i =1:size(img,2)
                pos = ~isnan(imgt(:,i,k));
                if sum(pos)>10
                    y1(:,i) = median(img(pos,i,k));
                    r(:,i,k) = img(:,i,k) - y1(:,i)+bg;
                end
            end
        case 'smed_line'
            bg =  median(imgt(:,:,k).*r(:,:,k),'all','omitnan');
            for i =1:size(img,1)
                pos = ~isnan(imgt(i,:,k));
                if sum(pos)>10
                    y1(i,:) = median(img(i,pos))+bg;
                else
                    y1(i,:) = bg;
                end
            end
            bg2 = movmedian(y1(:,1),10);
            r(:,:,k) = img(:,:,k)-(y1-bg2);

        case 'mean_plane'
            img(:,:,k) = imgt(:,:,k).*r(:,:,k);
            r(:,:,k) = r(:,:,k) - mean(img(:),'omitnan');
        case 'log_y'
            try
            y = mean(img,2);
            y = y-min(y);
            x =  (1:numel(y));
            x = x/polyy/numel(y)*10;  %use app.ImageInfo.ScanSpeed for polyy value
            y=double(flip(y));
            x=x';
            xi=x;
            pos = x<5;
            x = x(pos);
            y= y(pos);
            ft2 = fittype("a*log((c*x)+b)", ...
                'dependent', {'y'}, 'independent', {'x'}, ...
                'coefficients', {'a', 'b', 'c'});

            lower_bounds = [0.1, 0.01, 0.1];
            upper_bounds = [1000, 20, 100];
            md2 = fit(x, y, ft2, ...
                'StartPoint', [5, 1, 2], ...
                'Lower', lower_bounds, ...
                'Upper', upper_bounds);
            
            r(:,:,k) = img(:,:,k) - flip(md2(xi));
            catch
                 r(:,:,k) = img(:,:,k);
            end
    end

end