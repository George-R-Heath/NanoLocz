function img_out = Mat_SimAFM_spin(coords,r,angle,pix_per_ang, spin, axis,z_thresh)
%% Settings
% r = tip radius(Å)
% angle =  cone angle (o)
% pix_per_ang = sampling (pix/Å)

for k = 1:numel(spin)
    clear coords_sp
     coords_sp = coords;
    switch axis
        case 'X'
            coords_rx(:,2) = coords(:,2)*cos(spin(k)*pi/180) - coords(:,3)*sin(spin(k)*pi/180);
            coords_rx(:,3) = coords(:,2)*sin(spin(k)*pi/180) + coords(:,3)*cos(spin(k)*pi/180);
            coords_sp(:,2:3) = coords_rx(:,2:3);
            clear coords_rx
        case 'Y'
            coords_ry(:,1) = coords(:,1)*cos(spin(k)*pi/180) + coords(:,3)*sin(spin(k)*pi/180);
            coords_ry(:,3) = coords(:,3)*cos(spin(k)*pi/180) - coords(:,1)*sin(spin(k)*pi/180);
            coords_sp(:,1) = coords_ry(:,1);coords_sp(:,3) = coords_ry(:,3);
            clear coords_ry

        case 'Z'
            v=[coords(:,1)';coords(:,2)'];
            R = [cos(spin(k)*pi/180) sin(spin(k)*pi/180); -sin(spin(k)*pi/180) cos(spin(k)*pi/180)];
            so = R*v;
            coords_sp(:,1) = so(1,:);
            coords_sp(:,2) = so(2,:);
            clear so R v
    end

    coords_sp(:,3) = coords_sp(:,3)-min(coords_sp(:,3));
    if z_thresh > 0
        z_thresh_sp = z_thresh.*(max(coords_sp(:,3))-min(coords_sp(:,3))) + min(coords_sp(:,3));
        pos = coords_sp(:,3)>=(z_thresh_sp);
        coords_sp = coords_sp(pos,1:3)-z_thresh_sp;
    end


    clear coords_s
    coords_s(:,3) = coords_sp(:,3);
    coords_s(:,1) = coords_sp(:,1).*pix_per_ang;
    coords_s(:,2) = coords_sp(:,2).*pix_per_ang;

    rs = r*pix_per_ang;
    fspace = (max(coords_sp(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1;
    fspace_cone = (max(coords_sp(:,3))-r)*tan(angle*pi/180)*pix_per_ang+1;
    end_pos = [floor(min(coords_sp(:,1).*pix_per_ang)-rs-fspace),ceil(max(coords_sp(:,1).*pix_per_ang)+rs+fspace);floor(min(coords_sp(:,2).*pix_per_ang)-rs-fspace),ceil(max(coords_sp(:,2).*pix_per_ang)+rs+fspace)];

    img = zeros(end_pos(1,2)-end_pos(1,1)+1,end_pos(2,2)-end_pos(2,1)+1);
    
    for i=1:numel(coords_sp(:,3))
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
    img_n{k} = img;
    sz(:,k)  =  size(img_n{k});

end

img_out = zeros(max(sz(1,:)),max(sz(2,:)),numel(spin));
center_row = ceil(size(img_out, 1) / 2);
center_col = ceil(size(img_out, 2) / 2);

for k = 1:numel(spin)
    start_row = center_row - floor(size(img_n{k}, 1) / 2);
    end_row = start_row + size(img_n{k}, 1) ;
    start_col = center_col - floor(size(img_n{k}, 2) / 2);
    end_col = start_col + size(img_n{k}, 2) ;
    img_out((start_row+1):end_row, (start_col+1):end_col,k) = img_n{k};
end

end





