%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [r] = level(img, polyx, polyy, line_plane, imgt)
r = img;
if exist('imgt','var')
else
    imgt = img>-inf;
      
end
switch line_plane
    case 'plane'
        nonNaNs = sum(~isnan(imgt), 'all');
        if nonNaNs>5
        xp = mean(imgt.*img,1,'omitnan');
        xf =  xp(~isnan(xp));
        xl =  1:numel(xp);
        xl =  xl(~isnan(xp));
        [p,~,mu] = polyfit(xl,xf,polyx);
        r = img - polyval(p,(1:numel(xp))',[],mu)';

        yp= mean(imgt.*r,2,'omitnan');
        yf =  yp(~isnan(yp));
        yl =  1:numel(yp);
        yl =  yl(~isnan(yp));
        [p,~,mu] = polyfit(yl,yf,polyy);
        r = r - polyval(p,(1:numel(yp))',[],mu);
        end
    case 'line'
        if polyx>0
            xl = 1:size(img,2);
            mask_line = [];
            for i =1:size(img,1)
                pos = imgt(i,:)>0;
                if sum(pos)>polyx+8
                    y1 = img(i,pos);
                    x1 =  xl(pos);
                    [p,~,mu] = polyfit(x1,y1,polyx);
                    y2(i,:) =  polyval(p,1:size(img,2),[],mu);
                    r(i,:) = img(i,:) -y2(i,:);
                else
                    mask_line = [mask_line,i];
                end
            end
            for i =mask_line
                try
                r(i,:) = img(i,:) - median(y2);
                catch
                end
            end

        end
        
        if polyy>0

            for i =1:size(img,2)
                yp = imgt(:,i).*r(:,i);
                yf =  yp(~isnan(yp));
                yl = (1:size(img,1));
                yl =  yl(~isnan(yp));
                if numel(yl)<polyy
                    r(i,:) = img(i,:);
                else
                    [p,~,mu] = polyfit(yl,yf,polyy);
                    r(:,i) = r(:,i) - polyval(p,(1:size(img,1))',[],mu);
                end
            end
        end

    case 'med_line'
        bg =  median(imgt.*r,'all','omitnan');
        for i =1:size(img,1)
            pos = ~isnan(imgt(i,:));
            if sum(pos)>10
                y1(i,:) = median(img(i,pos));
                if polyx>0
                    r(i,:) = img(i,:) - polyx*y1(i,:)+bg;
                else
                    r(i,:) = img(i,:) - y1(i,:)+bg;
                end
            end
        end
          case 'med_line_y'
        bg =  median(imgt.*r,'all','omitnan');
        for i =1:size(img,2)
            pos = ~isnan(imgt(:,i));
            if sum(pos)>10
                y1(:,i) = median(img(pos,i));
                r(:,i) = img(:,i) - y1(:,i)+bg;
            end
        end
    case 'smed_line'
        bg =  median(imgt.*r,'all','omitnan');
        for i =1:size(img,1)
            pos = ~isnan(imgt(i,:));
            if sum(pos)>10
                y1(i,:) = median(img(i,pos))+bg;
            else
                 y1(i,:) = bg;
            end
        end
        bg2 = movmedian(y1(:,1),10);
        r = img-(y1-bg2);

    case 'mean_plane'
        img = imgt.*r;
        r = r - mean(img(:),'omitnan');
    case 'log_y'
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

        r = img - flip(md2(xi));

end

end