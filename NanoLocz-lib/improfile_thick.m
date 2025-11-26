% Function written for NanoLocz-lib 2025 and NanoLocz GUI
% DESCRIPTION:   Calculate intensity profiles across a defined boundary 
%                 with optional thickness averaging. Supports, circular, 
%                 freehand and other shapes given by coordinates.
%
%  INPUTS:
%     thickness   - Number of pixels to average on either side of the boundary.
%     perimeter   - Nx2 array of (x,y) coordinates defining the boundary.
%     img         - Input image (2D grayscale).
%     shape       - String: 'Circle' or other (e.g., freehand line).
%
%  OUTPUT:
%     cz          - Averaged intensity profile along the boundary.

function cz = improfile_thick(thickness,perimeter,img,shape)
cz = [];
czTmp = [];

switch shape
    case 'Circle'
        cp = mean(perimeter);
        radiusOld = mean(sqrt((perimeter(:,1) - cp(1)).^2 + (perimeter(:,2) - cp(2)).^2));
        perimeter_t = zeros(size(perimeter));  % Initialize the new coordinates
        count = 0;
        for offset = -thickness:thickness
            count = count+1;
            radiusNew = radiusOld + offset;
            if radiusNew > 2
                for i = 1:size(perimeter, 1)
                    vec = [perimeter(i,1) - cp(1), perimeter(i,2) - cp(2)];
                    vecScaled = vec * (radiusNew / radiusOld);
                    perimeter_t(i,:) = [cp(1), cp(2)] + vecScaled;
                end
                p =  impixel(img,perimeter_t(:,1),perimeter_t(:,2));
                czTmp(:,count) = p(:,1);
            end

        end
        cz = mean(czTmp,2,'omitnan');

    case 'Freehand'
         app.LineThickness.Value = 1;
    otherwise

        for kk = 1:size(perimeter, 1)-1
            p1 = perimeter(kk, :);
            p2 = perimeter(kk+1, :);
            segmentVec = p2 - p1;
            perpVec = [-segmentVec(2), segmentVec(1)];
            perpVec = perpVec / norm(perpVec); % Normalize

            % Generate offset lines
            count =0;
            for offset = -thickness:thickness
                count =count+1;
                p1Offset = p1 + offset * perpVec;
                p2Offset = p2 + offset * perpVec;
                [~, ~, czTmp(:,count)] = improfile(img, ...
                    [p1Offset(1), p2Offset(1)], ...
                    [p1Offset(2), p2Offset(2)], 'bilinear');

            end
            czAverage = mean(czTmp, 2);
            czTmp = [];
            if kk == size(perimeter, 1)-1
                cz = [cz; czAverage(1:(end))];
            else
                cz = [cz; czAverage(1:(end-1))];
            end
        end

end

