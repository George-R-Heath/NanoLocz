%  Function written for NanoLocz GUI and NanoLocz-lib (2025)
%
% This function performs profile height analysis on a 2D image at specified (x, y) coordinates.
% It extracts intensity profiles along horizontal (x), vertical (y), and diagonal (xy, yx) directions,
% identifies the dominant peaks near the feature center, and calculates width measurements.
%
% INPUTS:
%   A           - 2D image (matrix)
%   xy          - Nx2 array of (x, y) coordinates of particle positions for profile extraction
%   max_radius  - Maximum length (in pixels) for each profile (total profile length = 2*max_radius)
%   directions  - 1x4 logical array specifying which directions to analyze:
%                   [x_direction, y_direction, xy_diagonal, yx_diagonal]
%   widthRef    - String specifying peak width reference method:
%                   'local height' → uses 'halfprom' in findpeaks
%                   'z = 0'        → uses 'halfheight' in findpeaks
%
% OUTPUTS:
%   Rmin   - Minimum width across directions for each coordinate
%   Rmax   - Maximum width across directions for each coordinate
%   Rmean  - Mean width across valid directions for each coordinate
%   p      - Cell array containing profile line coordinates for each feature
%
% USAGE EXAMPLE:
%   A = ImageTarget;
%   xy = round(Part.Locs(:,1:2));
%   directions = [1, 1, 1, 1];  % enable all directions
%   max_radius = 15;
%   widthRef = 'local height';
%
%   [Rmin, Rmax, Rmean, p] = Lineprofiler(A, xy, max_radius, directions, widthRef);
%
%   figure;
%   imagesc(A); colormap(jet); hold on;
%   plot(xy(:,1), xy(:,2), 'ko');
%   for j = 1:numel(xy(:,1))
%       plot(p{j,1}(:,1), xy(j,2)*ones(size(p{j,1}(:,1))), 'w-'); % x-profiles
%   end
%
% NOTES:
% - The function uses 'findpeaks' to extract feature widths along the selected directions.
% - Widths along diagonals are scaled by sqrt(2) to account for pixel distance.
% - If no valid peak is found in a given direction, the width is set to zero.



%%
function [Rmin, Rmax, Rmean, p] = Lineprofiler(A, xy, max_radius, directions, widthRef)
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

