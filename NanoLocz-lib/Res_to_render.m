% Function written for NanoLocz GUI and NanoLocz-lib (2025)
% 
% Res_to_render - Calculate rendering parameters from resolution and pixel size
%
% Inputs:
%   pixpernm  - Pixels per nanometer
%   res       - Desired resolution (nm)
%
% Outputs:
%   render_point - Rendering marker size
%   expand       - Image expansion factor

function [render_point, expand] = Res_to_render(pixpernm, res)
    expand = round(10 ./ (pixpernm .* res), 2, 'significant');
    if expand < 1
        expand = 1;
    end
    if expand >10
        expand = 10;
    end
    render_point = round(res * pixpernm / 3, 2, 'significant');

    if render_point <0.2
        render_point = 0.2;
    end

    if render_point >10
        render_point = 10;
    end
   
end