
function [Aligned_Locs,rmse] = Align_PtCloud(app, Locs, LAFM)

LAFM_ref = LAFM./max(LAFM(:));
LAFM_ref = rgb2gray(LAFM_ref);%.*max(app.ref.av(:));

Img_locs = Fast_peaks2D(LAFM_ref, 0.1, 2, 0);
Img_locs(:,5) = 1;
Img_locs  = localize_v2(app, LAFM_ref, Img_locs,'sphere',1);
Img_locs(:,1:2) = Img_locs(:,1:2)/app.LAFM_exp.Value;
pt = pointCloud(Img_locs(:,1:3));

frames = unique(Locs(:,5));
n = length(frames);
Aligned_Locs = Locs;

for i=1:n
   try
    pos = Locs(:,5) == frames(i);
    
    ptCloud_f = pointCloud(Locs(pos,1:3));
    [~,movingReg,rmse(i)] = pcregistericp(ptCloud_f,pt);

    if rmse(i) <20
        Aligned_Locs(pos,1:2) = movingReg.Location(:,1:2);
    else
        Aligned_Locs(pos,1:2) = Locs(pos,1:2);
      % Aligned_Locs(pos,1:2) = 0;
    end
     Aligned_Locs(pos,9) = rmse(i);
   catch
   end
    clear ptCloud_f movingReg 
end
end