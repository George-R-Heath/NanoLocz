%code used to perform profile height analysis in x, y, xy and x-y
%
% max_radius = 15;     %set the max profile length
% loctor = 0.3;  %use peak located at central loctor fraction of total (max value = 1)
%
%
% A = ImageTarget;
% xy = round(Part.Locs(:,1:2));
% z = Part.Locs(:,3);
% directions = [1, 1, 1, 1]; % [x, y, xy, yx]
%
%  [Rmin, Rmax, Rmean, p] = prof(A, xy, pleng, loctor);
% figure(1)
% imagesc(A)
% colormap(jet)
% hold on
% plot(xy(:,1),xy(:,2),'ko')
% for j =1:numel(z)
% % plot(p{j,1}(:,1),ones(numel(p{j,1}(:,1)))*xy(j,2))
%   plot(ones(numel(p{j,2}(:,1)))*xy(j,1),p{j,2}(:,1))
% end
%
% figure(2)
% plot(Rmax,z,'.')
% hold on
% plot(Rmin,z,'o')


%%
function [Rmin, Rmax, Rmean, p] = Lineprofiler(A, xy, max_radius,directions,widthRef)
loctor = 0.2;
pleng = round(max_radius)*2;

switch widthRef
    case 'local height'
widthRef = 'halfprom';
    case 'z = 0'
    widthRef=  'halfheight';
end



for j =1:numel(xy(:,1))
    for jj=1:pleng
        p{j,1}(jj,1)= xy(j,1)-(jj-pleng/2);
        p{j,2}(jj,1)= xy(j,2)-(jj-pleng/2);
    end
    p{j,3}= flip(p{j,2});

    for jj=1:pleng
        if p{j,1}(jj,1)>0 && p{j,1}(jj,1)< numel(A(1,:)) && directions(1)
            prof_x(j,jj) = A(xy(j,2),p{j,1}(jj,1));
        else
            prof_x(j,jj) = 0;
        end

        if p{j,2}(jj,1)>0 && p{j,2}(jj,1)<numel(A(:,1)) && directions(2)
            prof_y(j,jj) = A(p{j,2}(jj,1),xy(j,1));
        else
            prof_y(j,jj) = 0;
        end

        if p{j,1}(jj,1)>0 && p{j,1}(jj,1)< numel(A(1,:)) && p{j,2}(jj,1)>0 && p{j,2}(jj,1)<numel(A(:,1)) && directions(3)
            prof_xy1(j,jj) = A(p{j,2}(jj,1),p{j,1}(jj,1));
        else
            prof_xy1(j,jj) = 0;
        end

        if p{j,1}(jj,1)>0 && p{j,1}(jj,1)< numel(A(1,:)) && p{j,3}(jj,1)>0 && p{j,3}(jj,1)<numel(A(:,1)) && directions(4)
            prof_xy2(j,jj) = A((p{j,3}(jj,1)),p{j,1}(jj,1));
        else
            prof_xy2(j,jj) = 0;
        end

    end

    if directions(1)>0
        %x
        [~, locs, wds] = findpeaks(nonzeros(prof_x(j,:)),'MinPeakProminence',0.01,'WidthReference',widthRef);
        pos = (locs < pleng/2+pleng*loctor).*(locs > pleng/2-pleng*loctor);
        pos=pos>0;

        if sum(pos)>0
            [Fwidth(1,j),ID] = max(wds(pos));
        else
            Fwidth(1,j) = 0;
        end
    end
    if directions(2)>0

        %y
        [~, locs, wds] = findpeaks(nonzeros(prof_y(j,:)),'MinPeakProminence',0.01,'WidthReference',widthRef);
        pos = (locs < pleng/2+pleng*loctor).*(locs > pleng/2-pleng*loctor);
        pos=pos>0;

        if sum(pos)>0
            [Fwidth(2,j),ID] = max(wds(pos));
        else
            Fwidth(2,j) = 0;
        end
    end

    if directions(3)>0
        [~, locs, wds] = findpeaks(nonzeros(prof_xy1(j,:)),'MinPeakProminence',0.01,'WidthReference',widthRef);

        pos = (locs < pleng/2+pleng*loctor).*(locs > pleng/2-pleng*loctor);
        pos=pos>0;

        if sum(pos)>0
            [Fwidth(3,j),ID] = max(wds(pos));
            Fwidth(3,j) =Fwidth(3,j)*2^0.5;
        else
            Fwidth(3,j) = 0;
        end

    end
    if directions(3)>0
        [~, locs, wds] = findpeaks(nonzeros(prof_xy2(j,:)),'MinPeakProminence',0.01,'WidthReference',widthRef);

        pos = (locs < pleng/2+pleng*loctor).*(locs > pleng/2-pleng*loctor);
        pos=pos>0;

        if sum(pos)>0
            [Fwidth(4,j),ID] = max(wds(pos));
            Fwidth(4,j) =Fwidth(4,j)*2^0.5;
        else
            Fwidth(4,j) = 0;
        end
    end
end
%Fwidth(Fwidth==0) = NaN;
Rmax = max(Fwidth,[],1);
Rmin = min((Fwidth),[],1);
Rmean = mean(Fwidth,1,'omitnan');
end

