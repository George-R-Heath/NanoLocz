%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [LAFM_full] = LAFM_render(d, locs, img_gus, lut_mode, exp)
sd = size(d);
explocs = [round(locs(:,1:2)*exp), locs(:,3:end)];

n = max(locs(:,5));
id = 1:n;

LAFM_p(:,:,n) = zeros(sd(1:2)*exp);
for p = 1:n
    pos = locs(:,5)==id(p);
    sublocs = explocs(pos,:);
    for j = 1:sum(pos)
        if strcmp('LAFM', lut_mode)
            if sublocs(j,2) > 0 && sublocs(j,1) > 0 && sublocs(j,1) < exp*sd(2)  && sublocs(j,2) < exp*sd(1)
                LAFM_p(sublocs(j,2),sublocs(j,1),p) = 1;
            end
        else
            if sublocs(j,2) > 0 && sublocs(j,1) > 0 && sublocs(j,1) < exp*sd(2)  && sublocs(j,2) < exp*sd(1)
                LAFM_p(sublocs(j,2),sublocs(j,1),p) = sublocs(j,3);
            end
        end
    end
end

LAFM_p = imgaussfilt(LAFM_p,img_gus*exp/2);

if strcmp('LAFM', lut_mode)
    LAFM_p = (LAFM_p-min(LAFM_p(:)))./(max(LAFM_p(:))-min(LAFM_p(:)));
    LAFM_h =  (LAFM_p>0.05).*(imresize(d(:,:,id), exp, 'bicubic'));
    LAFM_hn =  (LAFM_h)./(max(LAFM_h(:)))*255;

    R = (-LAFM_hn.^2)/255+2.*LAFM_hn-2;
    G = (R.*LAFM_hn/255);
    B = (LAFM_hn.*(sin(0.036.*(LAFM_hn+127))+1)./2);

    R(isnan(R))=0;         G(isnan(G))=0;          B(isnan(B))=0;
    R=R.*LAFM_p;           G=G.*LAFM_p;            B=B.*LAFM_p;
    R_av = mean(R,3);      G_av = mean(G,3);       B_av = mean(B,3);

    LAFM = cat(3,R_av,G_av,B_av);
    LAFM_full =  (LAFM-min(LAFM(:)))./(max(LAFM(:))-min(LAFM(:)));
else
    LAFM_full = mean(LAFM_p,3);
end

end