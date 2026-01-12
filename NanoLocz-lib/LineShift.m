%  Function written for NanoLocz GUI and NanoLocz-lib (2025)
%
% DESCRIPTION:
%   This function corrects bi-directional scan line misalignment in Atomic Force Microscopy (AFM) images.
%   It estimates the relative lateral shift between alternating scan lines (odd vs. even) and applies a
%   correction by realigning them to minimize misalignment artifacts.
%
% INPUTS:
%   im   - Input AFM image (2D grayscale or 3D with image in first channel)
%   type - Method used to estimate the shift:
%            'peaks' : (Recommended) Uses local maxima detection to align features.
%            'ccr'   : Uses cross-correlation for alignment.
%            numeric : Directly applies specified shift value without estimation.
%
% OUTPUTS:
%   shift  - Estimated pixel shift between alternating scan lines (integer)
%   result - Corrected image with alternating lines shifted accordingly to reduce misalignment
%
% USAGE EXAMPLE:
%   correctedImage = LineShift(image, 'peaks');
%
% METHOD OVERVIEW:
% - For each adjacent pair of scan lines:
%     • If 'ccr' is selected, computes the cross-correlation between lines to estimate the shift.
%     • If 'peaks' is selected, smooths the lines and uses peak positions for alignment.
% - The shift is estimated robustly by analyzing the distribution of local similarity and applying
%   a Gaussian fit or fallback to the histogram mode.
% - Alternating lines are then shifted by the estimated amount to generate a corrected image.
%


function [shift, result] = LineShift(im, type)
%types = 'ccr' or 'peaks' - peaks is recomended
w = gausswin(20, 5);
w = w/sum(w);

for i = 1:size(im,1)-1
    r = im(i+1,:,1);
    rt = im(i,:);

    switch type
        case 'ccr'
            [ccr, lags] = xcorr(rt,r,'normalized',40);
            [~, id] = max(ccr);
            shift_i(i) = lags(id);
        case 'peaks'
            r = filter(w, 1, r);
            [~,m] = islocalmax(r,'MinProminence',0.2);
            [~, id1] = max(m);
            rt = filter(w, 1, rt);
            [~,m] = islocalmax(rt,'MinProminence',0.2);
            [~, id2] = max(m);
            shift_i(i) = id2-id1;
        otherwise
            shift_i(i) = type;
    end
    if ~rem(i,2)
        shift_i(i)=- shift_i(i);
    end
    s(i) = sum((rt+r)./(2.*numel(rt)));
end

switch type
    case {'ccr','peaks'}

        P = prctile(s,50);
        pos = s>P;
        shift_i = rmoutliers(shift_i(pos),"mean");
        switch type
            case 'ccr'
                shift_i = shift_i(shift_i ~= 0);
                shift_i = shift_i(shift_i ~= 40);
                shift_i = shift_i(shift_i ~= -40);
        end

        bins = min(shift_i):1:max(shift_i);
        fo = fitoptions('method','NonlinearLeastSquares',...
            'StartPoint',[30,0,20], 'Lower', [0, -20, 1], 'Upper', [1000,20,50]);
        [hy, x] = hist(shift_i,bins);
        try
        gfit  = fit(x',hy','gauss1',fo); 
        shift = -round(gfit.b1);
        catch
         [mx, id] = max(hy);
         shift = -round(x(id));
        end
       
    otherwise
        shift = type;
end

if shift>0
    result = zeros(size(im,1),size(im,2)+(shift));
    result(2:2:end,1:size(im,2))= im(2:2:end,:,1);
    result(1:2:end,shift+1:end)= im(1:2:end,:,1);
    result =   imcrop( result,[round(abs(shift/2)) 0 size(im,2)-1 size(im,1) ]);
elseif shift<0
    result = zeros(size(im,1),size(im,2)-shift);
    result(1:2:end,1:size(im,2))= im(1:2:end,:,1);
    result(2:2:end,-shift+1:end)= im(2:2:end,:,1);
    result =   imcrop( result,[round(abs(shift/2)) 0 size(im,2)-1 size(im,1) ]);
else
    result = double(im);
end

end

