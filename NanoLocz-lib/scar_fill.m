%  Function written for NanoLocz GUI and NanoLocz-lib (2025)
%  scar_fill - Fill thin horizontal scars/artifacts in an image
%
% Inputs:
%   A          - Input image (2D)
%   thresh     - Gradient threshold for edge detection
%   thresh_h   - Intensity threshold to limit filling
%   min_length - Minimum horizontal length of scars to fill
%
% Output:
%   Result     - Image with scars filled

function Result = scar_fill(A, thresh, thresh_h, min_length)
Af = medfilt2(A, [1, 10]);
[~, grad] = gradient(Af);
At = grad>thresh; 
At2 =grad<-thresh;
At2 = At2(3:end,:);
At2 = [At2; zeros(2,size(At2, 2))];
At = At2.*At;
At = [zeros(1,size(At2, 2)); At];
At = At(1:(end-1),:);
At = bwareaopen(At, 3);
At = medfilt2(At, [1, min_length*2])>0;
At = At.*(A>thresh_h);
Result = regionfill(A,At);
end

