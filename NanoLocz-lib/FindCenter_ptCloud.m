% FINDCENTER_PTCloud for NanoLocz-lib (2025)
% Computes the center of rotational symmetry using point cloud alignment.
%
%   This function estimates the center of symmetry of a set of 3D points
%   ('locs') by registering rotated versions of the point cloud to itself
%   using the Iterative Closest Point (ICP) algorithm.
%
%   INPUTS:
%     fold      - Integer specifying the rotational symmetry (e.g., 2 for 2-fold, 3 for 3-fold, etc.)
%     input_img - 2D or 3D image used to define the image dimensions (only the size is used)
%     locs      - Nx3 array of [x y z] coordinates representing points in the point cloud
%
%   OUTPUT:
%     center_translation   - Estimated center of symmetry translation:
%                          - For fold = 2: mean translation (center/2)
%                          - For fold > 2: average translation over all rotations
%
%   REQUIREMENTS:
%     - Requires the Computer Vision Toolbox (for pointCloud and pcregistericp).
%
%   Example:
%     img = imread('example.png');
%     locs = [x_coords, y_coords, z_coords];
%     center = FindCenter_ptCloud(3, img, locs);
%

function [center_translation] = FindCenter_ptCloud(fold, input_img, locs)
sd = size(input_img);

locs_1(:,1) =  locs(:,1) - sd(2)/2;
locs_1(:,2) =  locs(:,2) - sd(1)/2;
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