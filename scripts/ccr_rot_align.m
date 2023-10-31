%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function rot_ang = ccr_rot_align(ref, T,range,~,thresh)

ri = range(1):0.5:range(2);
if range(2)-range(1) <=20
     ri = range(1):0.2:range(2);
end

if nargin <5
else
    T=T.*(T>thresh);
    ref=ref.*(ref>thresh);
end

sz_r = size(ref);
sz_T = size(T);

if sz_r(1) > sz_T(1)
    clip = sz_r(1) - sz_T(1);
    ref(1:clip,:)=[];
elseif sz_r(1) < sz_T(1)
    clip = sz_T(1) - sz_r(1);
    T(1:clip,:)=[];
end

if sz_r(2) > sz_T(2)
    clip = sz_r(2) - sz_T(2);
    ref(:,1:clip)=[];
elseif sz_r(2) < sz_T(2)
    clip = sz_T(2) - sz_r(2);
    T(:,1:clip)=[];
end


rot_cor= zeros(1,numel(ri));

for i = 1:numel(ri)
Tr = imrotate(T,ri(i),'crop','bicubic');
rot_cor(i) = corr2(Tr,ref);
end
    
[~,ID] = max(rot_cor(:));
F = griddedInterpolant(ri,rot_cor,'spline');
rot_ang = arrayfun(@(xx)fminsearch(@(ri)-F(ri),xx),ri(ID));

if rot_ang >360
  rot_ang = 360;  
else if rot_ang <-360
   rot_ang = -360; 
    end
end

end



