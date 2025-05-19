function locs = localize_v2(app, target, locs, loc_method, pixperfeat)
sd = size(target);

% loc_method options:
% 'bicubic' , 'bilinear','lanczos3', 'lanczos2' - interpolation methods at x10
% 'gaussian' - 2D gaussian fit
% 'sphere' - fit to sphere

n = numel(locs(:,1));
cla(app.loadbar)
updateInterval = 5;
stepsPerUpdate = ceil(n * (updateInterval / 100));
rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', [0.30,0.98,0.40]);
progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

if strcmp('bicubic', loc_method) || strcmp('bilinear', loc_method) || strcmp('lanczos3', loc_method) || strcmp('lanczos2', loc_method)
locs(:,1:2) = round(locs(:,1:2));
w=3; expand_factor = 10;
for jj = 1:n
    if locs(jj,2)-w+1 > 0 && locs(jj,1)-w+1 > 0 &&  locs(jj,2)+w-1 < sd(1) && locs(jj,1)+w-1 < sd(2)
        clip = target(locs(jj,2)-w+1:locs(jj,2)+w-1,locs(jj,1)-w+1:locs(jj,1)+w-1,locs(jj,5));
        clip = imresize(clip, expand_factor, loc_method);
        clip = clip(11:40,11:40);
        [~, imax] = max(clip(:));
        [locs_2y, locs_2x] = ind2sub(size(clip),imax);
        locs(jj,1) = locs(jj,1) + (locs_2x-size(clip,2)/2)/expand_factor;
        locs(jj,2) = locs(jj,2) + (locs_2y-size(clip,1)/2)/expand_factor;
    else
       locs(jj,1:2) = nan;
    end

        if mod(jj, stepsPerUpdate) == 0 || jj == n
            progressBar.Position(3) = jj / n;
           progressText.String = sprintf('Refining %d%%', round(jj/n*100));
           drawnow;
        end

end

% gaussian sub pixel localization
elseif strcmp('gaussian', loc_method)
    locs(:,1:2) = round(locs(:,1:2));

    if pixperfeat < 0.75
        w=2;
    else
        w=3;
    end

    for jj = 1:n
        if locs(jj,2)-w+1 > 2 && locs(jj,1)-w+1 > 2 &&  locs(jj,2)+w-1 < sd(1)-2 && locs(jj,1)+w-1 < sd(2)-2
            
            clip = target(locs(jj,2)-w+1:locs(jj,2)+w-1,locs(jj,1)-w+1:locs(jj,1)+w-1,locs(jj,5));
            locs_2 = TwoDGaussFit(double(clip));
            locs(jj,1) = locs(jj,1) + locs_2(2);
            locs(jj,2) = locs(jj,2) + locs_2(4);
            %locs(jj,11) = locs_2(3); %sigma x
            locs(jj,10) = (locs_2(5) + locs_2(3))./2; %(sigma y + sigma x) /2
            locs(jj,11) = locs_2(1); %Amplitude
        else
          locs(jj,1:2) = nan;
        end

        if mod(jj, stepsPerUpdate) == 0 || jj == n
            progressBar.Position(3) = jj / n;
            progressText.String = sprintf('Refining %d%%', round(jj/n*100));
            drawnow;
        end

    end


% Sphere fit sub pixel localization
elseif strcmp('sphere', loc_method)
    locs(:,1:2) = round(locs(:,1:2));
    
    if pixperfeat < 0.5
        w=2;
        const=5;
    else
        w=3;
        const=8;
    end
    
    %if Boost subpix?
    %w=9
    %clip = imresize(clip, 1, 'bicubic');

    for jj = 1:n
        if locs(jj,2)-w+1 > 2 && locs(jj,1)-w+1 > 2 &&  locs(jj,2)+w-1 < sd(1)-2 && locs(jj,1)+w-1 < sd(2)-2

            clip = target(locs(jj,2)-w+1:locs(jj,2)+w-1,locs(jj,1)-w+1:locs(jj,1)+w-1,locs(jj,5));
            clip = imresize(clip, 3, 'bicubic');
            [rows, columns] = size(clip);
            [x, y] = meshgrid(1:columns, 1:rows);
            z = clip(:);
            x = x(:);
            y = y(:);
            [xc, yc, zc, R] = sumith_fit(x,y,z);

            locs(jj,1) = locs(jj,1) + (xc-const)/3;
            locs(jj,2) = locs(jj,2) + (yc-const)/3;
            locs(jj,10) = R;
            
        else
             locs(jj,1:2) = nan;
        end

        if mod(jj, stepsPerUpdate) == 0 || jj == n
            progressBar.Position(3) = jj / n;
            progressText.String = sprintf('Refining %d%%', round(jj/n*100));
            drawnow;
        end

    end


end
  delete(progressBar);
   delete(progressText);

    function [xc, yc, zc, R] = sumith_fit(x,y,z)
        [N,~]=size(x);

        Sx = sum(x);     Sy = sum(y);     Sz = sum(z);
        Sxx = sum(x.*x);    Syy = sum(y.*y);    Szz = sum(z.*z);
        Sxy = sum(x.*y);    Sxz = sum(x.*z);    Syz = sum(y.*z);

        Sxxx = sum(x.*x.*x);   Syyy = sum(y.*y.*y);   Szzz = sum(z.*z.*z);
        Sxyy = sum(x.*y.*y);   Sxzz = sum(x.*z.*z);   Sxxy = sum(x.*x.*y);
        Sxxz = sum(x.*x.*z);   Syyz =sum(y.*y.*z);    Syzz = sum(y.*z.*z);

        A1 = Sxx +Syy +Szz;

        a = 2*Sx*Sx-2*N*Sxx;
        b = 2*Sx*Sy-2*N*Sxy;
        c = 2*Sx*Sz-2*N*Sxz;
        d = -N*(Sxxx +Sxyy +Sxzz)+A1*Sx;

        e = b; %2*Sx*Sy-2*N*Sxy;
        f = 2*Sy*Sy-2*N*Syy;
        g = 2*Sy*Sz-2*N*Syz;
        h = -N*(Sxxy +Syyy +Syzz)+A1*Sy;

        j = c; %2*Sx*Sz-2*N*Sxz;
        k = g; %2*Sy*Sz-2*N*Syz;
        l = 2*Sz*Sz-2*N*Szz;
        m = -N*(Sxxz +Syyz + Szzz)+A1*Sz;

        delta = a*(f*l - g*k)-e*(b*l-c*k) + j*(b*g-c*f);

        xc = (d*(f*l-g*k) -h*(b*l-c*k) +m*(b*g-c*f))/delta;
        yc = (a*(h*l-m*g) -e*(d*l-m*c) +j*(d*g-h*c))/delta;
        zc = (a*(f*m-h*k) -e*(b*m-d*k) +j*(b*h-d*f))/delta;
        R = sqrt(xc^2+yc^2+zc^2 + (A1 -2*(xc*Sx+yc*Sy+zc*Sz))/N);
    end


    function [x] = TwoDGaussFit(Z)
        s = size(Z);
        Z = Z-min(Z(:));

        MdataSize = s(1)-1; % Size of nxn data matrix
        % parameters are: [Amplitude, x0, sigmax, y0, sigmay]
        x0 = [1,0,3,0,3]; %Inital guess parameters

        [X,Y] = meshgrid(-MdataSize/2:MdataSize/2);
        xdata = zeros(size(X,1),size(Y,2),2);
        xdata(:,:,1) = X;
        xdata(:,:,2) = Y;

        %% --- Fit---------------------
        x0 =x0(1:5);
        lb = [0.05,-2,0.5,-2,0.5];
        ub = [40,2,40,2,40];
        options = optimoptions(@lsqcurvefit,'Display','off');
        [x] = lsqcurvefit(@D2GaussFunction,x0,xdata,Z,lb,ub,options);

    end

    function F = D2GaussFunction(x,xdata)
        F = x(1)*exp(   -((xdata(:,:,1)-x(2)).^2/(2*x(3)^2) + (xdata(:,:,2)-x(4)).^2/(2*x(5)^2) )    );
    end
end
