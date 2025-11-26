%  Function written for NanoLocz GUI and NanoLocz-lib (2025)
%
%  This function generates a simulated Atomic Force Microscopy (AFM) image 
%  based on a set of atomic coordinates, a probe tip radius, tip angle, and 
%  pixel resolution. The function automatically selects an 
%  appropriate simulation method depending on the sampling density (pixel size).
%
%  Syntax:
%     img = Mat_SimAFM(coords, r, angle, pix_per_ang)
%
%  Inputs:
%     coords       - Nx3 matrix of atomic coordinates [x y z] in Ångstroms
%     r            - Radius of AFM tip (Ångstroms)
%     angle        - Half-angle of AFM tip cone (degrees)
%     pix_per_ang  - Sampling resolution (pixels per Ångstrom)
%
%  Output:
%     img          - Simulated AFM topography image (height map in Ångstroms)
%
%  Notes:
%     - At high sampling (pix_per_ang > 3), each atom is individually sampled 
%       to ensure accurate topography.
%     - At lower sampling, a coarser approximation is used to improve efficiency.
%     - Tip-sample interactions are approximated using a spherical tip model 
%       with conical extension for deeper features.

function img = Mat_SimAFM(coords,r,angle,pix_per_ang)
                         
rs = r*pix_per_ang;
fspace = (max(coords(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1;
fspace_cone = (max(coords(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1;
end_pos = [floor(min(coords(:,1).*pix_per_ang)-rs-fspace),ceil(max(coords(:,1).*pix_per_ang)+rs+fspace);floor(min(coords(:,2).*pix_per_ang)-rs-fspace),ceil(max(coords(:,2).*pix_per_ang)+rs+fspace)];

coords_s(:,3) = coords(:,3);
coords_s(:,1) = coords(:,1).*pix_per_ang;
coords_s(:,2) = coords(:,2).*pix_per_ang;

%select method depedning on sampling, if high sampling then all atom method
%is best since. At lower sampling more atoms will reside in the same pixel

%%high sampling method (standard)
if pix_per_ang>3  
    img = zeros(end_pos(1,2)-end_pos(1,1)+1,end_pos(2,2)-end_pos(2,1)+1);
    for i=1:numel(coords(:,3))
        offs_x =  round(coords_s(i,1))-coords_s(i,1);
        offs_y =  round(coords_s(i,2))-coords_s(i,2);
        [dx,dy]=ndgrid((-rs-fspace_cone):(rs+fspace_cone));
        dxl = dx(:)-offs_x;
        dyl = dy(:)-offs_y;

        for j = 1:numel(dxl)
            dh(j) = real(sqrt(-((dxl(j)/pix_per_ang).^2)-((dyl(j)/pix_per_ang).^2)+r^2))-r;    %tip interaction
            if dh(j)>-r
                h(j) = coords_s(i,3) + dh(j);
            else
                di = real(sqrt(((dxl(j)/pix_per_ang).^2)+((dyl(j)/pix_per_ang).^2)))-r;
                h(j) = coords_s(i,3)-r - (di)/tan(angle*pi/180);
            end

            pos_x = round(coords_s(i,1) + dxl(j)-end_pos(1)+1);
            pos_y = round(coords_s(i,2) + dyl(j)-end_pos(2)+1);
            if img(pos_x, pos_y) < h(j)
                img(pos_x, pos_y) = h(j);
            end
        end
    end
% At lower sampling method
else 

    img = ones(end_pos(1,2)-end_pos(1,1)+1,end_pos(2,2)-end_pos(2,1)+1);
    edg = 2;
    sd=size(img);
    [x, y]=find(img(edg:sd(1)-edg,edg:sd(2)-edg));
    x = (x+end_pos(1,1));
    y = (y+end_pos(2,1));
    img = zeros(end_pos(1,2)-end_pos(1,1)+1,end_pos(2,2)-end_pos(2,1)+1);

    end_xy = [floor(min(coords_s(:,1))), ceil(max(coords_s(:,1)));floor(min(coords_s(:,2))), ceil(max(coords_s(:,2)))];
    pos = x>end_xy(1,1) & x<end_xy(1,2);
    x = x(pos);
    y = y(pos);
    pos = y>end_xy(2,1) & y<end_xy(2,2);
    x = x(pos);
    y = y(pos);

    dhpix =  real((r^2-2*(1/pix_per_ang)^2)^0.5-r);
    for jj=1:length(y)
        pos1 = coords_s(:,2) >= y(jj) & coords_s(:,2) <= (y(jj) + 1);
        pos2 = coords_s(:,1) >= x(jj) & coords_s(:,1) <= (x(jj) + 1);
        pos = pos1.*pos2>0;
        if sum(pos)>0 % if atom is highest in that pixel space calculate the surface otherwise skip 
            maxZ = max(coords_s(pos,3));
            found_coords = coords_s(pos,:);
            for jjj=1:sum(pos)
                if found_coords(jjj,3)>=(maxZ + dhpix)

                    offs_x =  round(found_coords(jjj,1))-found_coords(jjj,1);
                    offs_y =  round(found_coords(jjj,2))-found_coords(jjj,2);
                    [dx,dy]=ndgrid((-rs-fspace_cone):(rs+fspace_cone));
                    dxl = dx(:)-offs_x;
                    dyl = dy(:)-offs_y;

                    for j = 1:numel(dxl)
                        dh(j) = real(sqrt(-((dxl(j)/pix_per_ang).^2)-((dyl(j)/pix_per_ang).^2)+r^2))-r;    %tip interaction
                        if dh(j)>-r
                            h(j) = found_coords(jjj,3) + dh(j);
                        else
                            di = real(sqrt(((dxl(j)/pix_per_ang).^2)+((dyl(j)/pix_per_ang).^2)))-r;
                            h(j) = found_coords(jjj,3)-r - (di)/tan(angle*pi/180);
                        end

                        pos_x = round(found_coords(jjj,1) + dxl(j)-end_pos(1)+1);
                        pos_y = round(found_coords(jjj,2) + dyl(j)-end_pos(2)+1);
                        if img(pos_x, pos_y) < h(j)
                            img(pos_x, pos_y) = h(j);
                         
                        end

                    end

                end
            end
        end
    end
end
end

