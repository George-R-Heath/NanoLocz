% 
% img = ImageTarget;
% loadn = numel(img(1,1,:));
% filter_frames = 1:loadn;
% result = auto_level_(img,filter_frames,'iterative 1nm high');

function result = level_auto(img,filter_frames,routine)
result = img;
switch routine
 % simple no thresh rountine
    case 'plane-line'
        for i = filter_frames
            prev = img(:,:,i);
            prev = level(prev,1,1,'plane');
           % std_x = std(mean(prev,1));
            %std_y = std(mean(prev,2));
          %  if std_y > 7*std_x
                prev = level(prev,1,0,'med_line');
           % elseif std_y > 3*std_x
            %    prev = level(prev,0.6,0,'med_line');
            %end
            result(:,:,i) = prev;
        end

% fixed thresh rountine
    case {'iterative 1nm high','iterative -1nm low','iterative high low'}
        switch routine
            case 'iterative 1nm high'
                low = -Inf;
                high = 1;
            case 'iterative -1nm low'
                low = -1;
                high = Inf;
            case 'iterative high low'
                low = -1;
                high = 1;
        end
        for i = filter_frames
            prev = img(:,:,i);
            prev = level(prev,1,1,'plane');
            std_x = std(mean(prev,1));
            std_y = std(mean(prev,2));
            if std_y > 7*std_x
                prev = level(prev,1,0,'med_line');
            elseif std_y > 5*std_x
                prev = level(prev,0.6,0,'med_line');
            end

            imgt = thresholder(prev,'histogram',[low, high],0);
            prev = level(prev,1,1,'plane',imgt);

            imgt = thresholder(prev,'histogram',[low, high],0);
            prev = level(prev,1,1,'plane',imgt);

            imgt = thresholder(prev,'histogram',[low, high],0);
            prev = level(prev ,0,0,'med_line',imgt);
            prev = level(prev,1,0,'plane',imgt);

            imgt = thresholder(prev,'histogram',[low, high],0);
            prev = level(prev ,0,0,'med_line',imgt);
            prev = level(prev,2,0,'plane',imgt);
            result(:,:,i) = prev;
        end

    case 'Line1 + Otsu Line2'
        for i = filter_frames
            prev = img(:,:,i);
            prev = level(prev,1,0,'line');
            imgt = thresholder(prev,'otsu',[],0);
            prev = level(prev,2,0,'line',imgt);
            result(:,:,i) = prev;
        end

% Gaussian thresh rountines
    case 'high-low x2 (fit)'
        for i = filter_frames
            prev = img(:,:,i);
            prev= level(prev,1,1,'plane');
            prev= level(prev,0,0,'med_line');
            result(:,:,i) = prev;
        end
        fo = fitoptions('method','NonlinearLeastSquares');
        t = result(:,:,:);
        [hy, x]=  hist(double(t(:)),100);
        gfit  = fit(double(x'),hy','gauss1',fo);
        max = gfit.b1 +1.5*gfit.c1;
        min = gfit.b1 -1.5*gfit.c1;

        for i = filter_frames
            prev = result(:,:,i);
            imgt = thresholder(prev,'histogram',[min, max],0);
            prev = level(prev ,1,1,'plane',imgt);
            prev = level(prev ,0,0,'med_line',imgt);
            result(:,:,i) = prev;
        end


    case {'iterative fit holes', 'iterative fit peaks'}
        switch routine
            case 'iterative fit holes'
                h = 0;
                p = Inf;
            case 'iterative fit peaks'
                h = -Inf;
                p = 0;
        end
        for i = filter_frames
            prev = img(:,:,i);
            prev= level(prev,2,2,'plane');
            prev= level(prev,0,0,'med_line');
            result(:,:,i) = prev;
        end
        fo = fitoptions('method','NonlinearLeastSquares');
        t = result(:,:,:);
        [hy, x]=  hist(double(t(:)),100);
        gfit  = fit(double(x'),hy','gauss1',fo);
        max = (gfit.b1 +1.5*gfit.c1)+p;
        min = (gfit.b1 -1.5*gfit.c1)+h;

        for i = filter_frames
            prev = result(:,:,i);
            imgt = thresholder(prev,'histogram',[min, max],0);
            prev = level(prev ,2,2,'plane',imgt);
            prev = level(prev ,0,0,'med_line',imgt);
            result(:,:,i) = prev;
        end
        t = result(:,:,:);
        [hy, x]=  hist(double(t(:)),100);
        gfit  = fit(double(x'),hy','gauss1',fo);
        max = (gfit.b1 +1.5*gfit.c1)+p;
        min = (gfit.b1 -1.5*gfit.c1)+h;

        for i = filter_frames
            prev = result(:,:,i);
            imgt = thresholder(prev,'histogram',[min, max],0);
            prev = level(prev ,2,2,'plane',imgt);
            prev = level(prev,1,0,'line',imgt);
            result(:,:,i) = prev;
        end

        % edge routine: auto edge
    case 'multi-plane-edges'
        for i = filter_frames
            prev = img(:,:,i);
            prev = level(prev,1,1,'plane');
             std_x = std(mean(prev,1));
             std_y = std(mean(prev,2));
            if std_y > 7*std_x
                prev = level(prev,1,0,'med_line');
            elseif std_y > 5*std_x
                prev = level(prev,0.6,0,'med_line');
            end

            imgt = thresholder(prev,'auto edges',[0 0],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            imgt = thresholder(prev,'auto edges',['-inf', 'inf'],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            prev = level_weighted(prev,0,0,'med_line',imgt);
            % imgt = thresholder(prev,'edges',['-inf', 'inf'],0);
            % prev = level_weighted(prev,0,0,'med_line',imgt);
            prev = level_weighted(prev,2,2,'plane',imgt);
            prev = level_weighted(prev,0,0,'med_line',imgt);
            imgt = thresholder(prev,'otsu',[0 0],0);
            prev = level(prev,0,0,'mean_plane',imgt);
            result(:,:,i) = prev;
        end

        % edge routine: otsu edge
    case 'multi-plane-otsu'
        for i = filter_frames
            prev = img(:,:,i);
            prev = level(prev,1,1,'plane');
            std_x = std(mean(prev,1));
            std_y = std(mean(prev,2));
            if std_y > 5.7*std_x
                prev = level(prev,1,0,'med_line');
            end
            imgt = thresholder(prev,'otsu edges',[0 0],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            imgt = thresholder(prev,'otsu edges',[0 0],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            imgt = thresholder(prev,'otsu edges',[0 0],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            prev = level_weighted(prev,0,0,'med_line',imgt);
           % imgt = thresholder(prev,'edges',['-inf', 'inf'],0);
           % prev = level_weighted(prev,0,0,'med_line',imgt);
           imgt = thresholder(prev,'otsu edges',[0 0],0);
            prev = level_weighted(prev,2,2,'plane',imgt);
            prev = level_weighted(prev,0,0,'med_line',imgt);
            imgt = thresholder(prev,'otsu',[0 0],0);
            prev = level(prev,0,0,'mean_plane',imgt);
            result(:,:,i) = prev;
        end
end
end