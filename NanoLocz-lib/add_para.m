%  DESCRIPTION:   Function written for NanoLocz-lib
% Add_para applies linear gradient parachute scanning artifacts 
% to AFM images to simulate parachute noise 
%
% Inputs:
%   img        - The input 2D image (AFM height image or similar)
%   para_grad  - The gradient parameter (slope of artificial parachute noise)
%   direction  - String: 'trace', 'retrace', or 'bi-directional'
%
% Output:
%   result     - The image with parachuting added

% eg: result = add_para(im, 1, 'trace');

function result = add_para(img, para_grad, direction)


switch direction
    case 'trace'
    case 'retrace'
        img = flip(img,2);
    case 'bi-directional'
        img(2:2:end,:) = flip(img(2:2:end,:),2);
end
x = 1:size(img,2);
sobel_x = [-1, 0, 1];
result = img;

for i = 1:size(img,1)
    Li = img(i,:);
    x_gradient = conv2(Li, sobel_x, 'same');
    Gt = x_gradient >2*para_grad;
    Gt(1)=0;

    for k = x(Gt)
        count = k-1;
        while count < numel(x) && Li(count) >= img(i,count)
            count = count+1;
            Li(count) = Li(count-1)-para_grad;
        end
        if count == numel(x)
        else
            Li(count) = img(i,count);
        end
    end
    result(i,:) = Li;
end

switch direction
    case 'trace'
    case 'retrace'
        result = flip(result,2);
    case 'bi-directional'
        result(2:2:end,:) = flip(result(2:2:end,:),2);
end
end