% DESCRIPTION:   Function written for NanoLocz-lib 2025
% ALIGN_PTCloud Performs rigid alignment of 3D particle localisation data to an LAFM reference image using Iterative Closest Point.
%
%   Inputs:
%       Locs     - Nx5 (or more) matrix of localisation data: [x, y, z, ..., frame]
%       LAFM     - LAFM reference image (2D grayscale or RGB)
%       exp      - Pixel size (nm per pixel) used to scale localisation coordinates
%
%   Outputs:
%       Aligned_Locs - Localisation data after alignment (x, y updated)
%       rmse         - Root mean square error for each frame's alignment
%
%   Method:
%       - Detects features in the reference LAFM image and builds a fixed point cloud.
%       - For each frame in Locs, constructs a moving point cloud and aligns it to the reference.
%       - Updates localisation coordinates if alignment is successful (RMSE < 20).
%
%   Notes:
%       - Only x and y positions are updated; z and other columns remain unchanged.
%       - RMSE values are stored in the 9th column of Aligned_Locs.

function [Aligned_Locs, rmse] = align_PtCloud(Locs, LAFM, exp)

LAFM_ref = LAFM ./ max(LAFM(:));
if ndims(LAFM_ref) == 3
    LAFM_ref = rgb2gray(LAFM_ref);
end

Img_locs = Fast_peaks2D(LAFM_ref, 0.1, 2, 0);
Img_locs(:,5) = 1;
Img_locs  = localize(LAFM_ref, Img_locs,'sphere',1);
Img_locs(:,1:2) = Img_locs(:,1:2)/exp;
pt = pointCloud(Img_locs(:,1:3));

frames = unique(Locs(:,5));
n = length(frames);
Aligned_Locs = Locs;

for i=1:n
   try
    pos = Locs(:,5) == frames(i);
    
    ptCloud_f = pointCloud(Locs(pos,1:3));
    [~,movingReg,rmse(i)] = pcregistericp(ptCloud_f,pt);

    if rmse(i) <20
        Aligned_Locs(pos,1:2) = movingReg.Location(:,1:2);
    else
        Aligned_Locs(pos,1:2) = Locs(pos,1:2);
    end
     Aligned_Locs(pos,9) = rmse(i);
   catch
   end
    clear ptCloud_f movingReg 
end
end