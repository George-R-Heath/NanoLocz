%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [LinesOut] = LineAlign(Lines,type)
LinesOut = Lines;
y1 = Lines(1).Profile(:,2);
x1 = Lines(1).Profile(:,1);
w = gausswin(20, 5);
w = w/sum(w);
yf = filter(w, 1, y1);
[~, id1] = max(yf);
x1max = x1(id1);
for i = 2:numel(Lines)
    yi = Lines(i).Profile(:,2);
    xi =  Lines(i).Profile(:,1);
  
    switch type
        case 'Correlation'
            [ccr, lags] = xcorr(yi,y1,'none');
            [~, id] = max(ccr);
            shift = lags(id);

        case 'Max'
            yi = filter(w, 1, yi);
            [~, id2] = max(yi);
            ximax = xi(id2);
            shift =  ximax-x1max;
    end

    LinesOut(i).Profile(:,1) = Lines(i).Profile(:,1)-shift;
end
end

