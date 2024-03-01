function img_n = Mat_SimAFM_dyn(coords,r,angle,pix_per_ang, fluct_z, fluct_xy, n)
%% Settings
% r = tip radius(Å)
% angle =  cone angle (o)
% pix_per_ang = sampling (pix/Å)

rs = r*pix_per_ang;
fspace = (max(coords(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1 + 5*fluct_xy*pix_per_ang;
fspace_cone = (max(coords(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1;
end_pos = [floor(min(coords(:,1).*pix_per_ang)-rs-fspace),ceil(max(coords(:,1).*pix_per_ang)+rs+fspace);floor(min(coords(:,2).*pix_per_ang)-rs-fspace),ceil(max(coords(:,2).*pix_per_ang)+rs+fspace)];

for k = 1:n

    clear coords_s
    coords_s(:,3) = coords(:,3)+randn(numel(coords(:,3)),1)*fluct_z;
    coords_s(:,1) = coords(:,1).*pix_per_ang + randn(numel(coords(:,3)),1)*fluct_xy*pix_per_ang;
    coords_s(:,2) = coords(:,2).*pix_per_ang + randn(numel(coords(:,3)),1)*fluct_xy*pix_per_ang;
     [coords_s(:,1),coords_s(:,2),coords_s(:,3)] = prevent_clash(2.8,coords_s(:,1),coords_s(:,2),coords_s(:,3));
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
    img_n(:,:,k) = img;
end