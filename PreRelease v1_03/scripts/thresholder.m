%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

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
        T = adaptthresh(img,'Statistic','median','NeighborhoodSize', [5 5],'Fore','bright');
        imgt = (T==0).*1;
       imgt(imgt==0) = NaN;
end

 if invert ==1
     pos = isnan(imgt);
     imgt =pos.*img;
     imgt(imgt==0) = NaN;
 end


end

                    
