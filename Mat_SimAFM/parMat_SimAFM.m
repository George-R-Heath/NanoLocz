function img = parMat_SimAFM(coords, r, angle, pix_per_ang)

    rs = r * pix_per_ang;
    fspace_cone = (max(coords(:,3)) - r) * tan(angle * pi / 180) * pix_per_ang + 1;
    fspace = fspace_cone; 

    end_pos = [floor(min(coords(:,1) .* pix_per_ang) - rs - fspace), ceil(max(coords(:,1) .* pix_per_ang) + rs + fspace);
               floor(min(coords(:,2) .* pix_per_ang) - rs - fspace), ceil(max(coords(:,2) .* pix_per_ang) + rs + fspace)];

    coords_s = coords;
    coords_s(:,1:2) = coords(:,1:2) * pix_per_ang;

    % Initialize image matrix
    img_size = [end_pos(1,2) - end_pos(1,1) + 1, end_pos(2,2) - end_pos(2,1) + 1];
    img = zeros(img_size);

    [dx, dy] = ndgrid((-rs - fspace_cone):(rs + fspace_cone));
    dx = dx(:);
    dy = dy(:);

    % Parallel computation
    temp_img = cell(numel(coords(:,3)), 1);  % Temporary storage for each parallel iteration

    parfor i = 1:numel(coords(:,3))  % Parallel loop
        offs_x = round(coords_s(i,1)) - coords_s(i,1);
        offs_y = round(coords_s(i,2)) - coords_s(i,2);
        dxl = dx - offs_x;
        dyl = dy - offs_y;

        dh = real(sqrt(-((dxl / pix_per_ang).^2) - ((dyl / pix_per_ang).^2) + r^2)) - r;
        valid = dh > -r;
        h = coords_s(i,3) + dh .* valid + (~valid) .* (coords_s(i,3) - r - (real(sqrt((dxl / pix_per_ang).^2 + (dyl / pix_per_ang).^2)) - r) / tan(angle * pi / 180));

        pos_x = round(coords_s(i,1) + dxl - end_pos(1) + 1);
        pos_y = round(coords_s(i,2) + dyl - end_pos(2) + 1);

        valid_idx = (pos_x > 0 & pos_y > 0 & pos_x <= img_size(1) & pos_y <= img_size(2));
        pos_x = pos_x(valid_idx);
        pos_y = pos_y(valid_idx);
        h = h(valid_idx);

        % Store results for later combination
        temp_img{i} = [pos_x, pos_y, h];
    end

    % Combine results into `img`
    for i = 1:numel(temp_img)
        if ~isempty(temp_img{i})
            for k = 1:size(temp_img{i}, 1)
                px = temp_img{i}(k, 1);
                py = temp_img{i}(k, 2);
                img(px, py) = max(img(px, py), temp_img{i}(k, 3));  % Safe update
            end
        end
    end
end
