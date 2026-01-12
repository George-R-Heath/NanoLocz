%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function locs = peaks2D(Img, thresh, ns, min_prom)

% find local maxima above a threshold value 'thresh',
% within a circular neighbourhood pixel distance of 'ns'
% with a prominance greater than 'min_prom'

%output = peak [x, y, z, prominace(if min_prom is set)]

if nargin <2
else
    Img = Img.*(Img>thresh);
end

if nargin <3
    ns=1;
else
end

sd=size(Img);
ns = round(ns+1);
[x, y]=find(Img(ns:sd(1)-ns,ns:sd(2)-ns));
[hx,hy] = ndgrid(-(ns-1):(ns-1));
H = real(sqrt((-(hx.^2)-(hy.^2)+ns^2)))>ns/2;

peak=[]; peak_h=[];

x=x+ns-1;
y=y+ns-1;
nsi = ns-1;
target = round(((ns*2-1)^2)/2);
for j=1:length(y)
    [h, id] = max(H.*Img((x(j)-nsi):(x(j)+nsi),(y(j)-nsi):(y(j)+nsi)),[],'all','linear');
    if id== target
        peak = [peak ;  y(j) ; x(j)];
        peak_h = [peak_h;h];
    end
end
peak_co = [peak(1:2:end),peak(2:2:end)];

if any(peak_co)
    locs = [peak_co, peak_h];

    if nargin ==4 && min_prom>0
        if any(peak_co)
            for j = 1:numel(peak_co(:,1))
                di = (peak_co(j,1:2)-peak_co(:,1:2)).^2;
                d = sum(di,2).^0.5; %distance
                [~, order_id] = sort(d);

                if peak_h(j) >= peak_h(:)
                    prom(j) = peak_h(j);
                else
                    pos = (peak_h(order_id) > peak_h(j));
                    V1 = find(pos,1,'first'); %find closest peak with greater height
                    prom(j) = peak_h(j) - min(improfile(Img,[peak_co(order_id(V1),1), peak_co(j,1)],...
                        [peak_co(order_id(V1),2), peak_co(j,2)]));
                end
            end

        end
        keep_locs = prom>min_prom;
        locs = [locs(keep_locs,:), prom(keep_locs)'];
    else
        locs = [locs, zeros(numel(locs(:,1)),1)];
    end
else
    locs = [];
end

