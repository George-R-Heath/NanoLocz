%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

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
            'StartPoint',[30,0,20], 'Lower', [0, -40, 1], 'Upper', [1000,40,50]);
        [hy, x] = hist(shift_i,bins);
        gfit  = fit(x',hy','gauss1',fo);
        shift = -round(gfit.b1);
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
    result = im;
end

end

