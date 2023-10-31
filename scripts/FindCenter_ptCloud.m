function [center_translation] = FindCenter_ptCloud(fold, input_img, locs)
sd = size(input_img);

locs_1(:,1) =  locs(:,1) - sd(1)/2;
locs_1(:,2) =  locs(:,2) - sd(2)/2;
locs_1(:,3) = locs(:,3);


[center] = CenterPoints(locs_1, fold);

if fold == 2
    center_translation = center/2;
elseif fold >2
    center_translation = sum(center)/fold;
end

    function [center] = CenterPoints(Locs, fold)
        ptCloud_1 = pointCloud(Locs(:,1:3));
        for i=1:(fold-1)
            angle = i*360/fold;
            v=[Locs(:,1)';Locs(:,2)'];
            R = [cos(angle*pi/180) sin(angle*pi/180); -sin(angle*pi/180) cos(angle*pi/180)];
            so = R*v;
            locs_rotated = Locs;
            locs_rotated(:,1) = so(1,:);
            locs_rotated(:,2) = so(2,:);
            ptCloud_2 = pointCloud(locs_rotated(:,1:3));
            tform = pcregistericp(ptCloud_2,ptCloud_1);
            clear so R v ptCloud_2 locs_rotated
            center(i,:) = tform.Translation(1:2);
        end
    end
end