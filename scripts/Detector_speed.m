%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

[locs] = Detector_2( ImageTarget, 'ccr', ref.image, 1, 1, 0.5, 1, 0, 0);




function [locs] = Detector_2( img, method, ref, filt_img, filt_ccr, min_thresh, ex_edge, rotfreedom, angles)
%OUTPUT:
% locs(:,1) = x,
% locs(:,2) = y,
% locs(:,3) = height,
% locs(:,4) = ccr,
% locs(:,5) = frame,
% locs(:,6) = angle,
% rotfreedom =1;
% angles = -start:interval:end;

locs = [];
n = numel(img(1,1,:));
img(isnan(img)) = 0;
if filt_img >0
    img_g = imgaussfilt(img,filt_img);
else
    img_g = img;
end
img_g = imresize(img_g, 1/2, 'bilinear');
ref = imresize(ref, 1/2, 'bilinear');

ns = 1;

for i = 1:n

    locs_i = [];
    h=[];
    if strcmp('Peak picker', method)
        locs_i = Fast_peaks2D(img_g(:,:,i), min_thresh,ref);
        locs_i(:,8) = 0;
    elseif strcmp('ccr', method)
        %% rotational freedom code
        if rotfreedom ==1
            ccr=[];
            for j = 1:numel(angles)
                ref_img = imrotate(ref,angles(j),'crop');
                ccr(:,:,j) = normxcorr2(ref_img,img_g(:,:,i));
            end
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
                ccr = ccr(round(size(ref,1)/2):round(end - size(ref,1)/2),round(size(ref,2)/2):round((end - (size(ref,2))/2)),:);
            end

            [val, id] = max(ccr,[],3);
            % locs_i = findpeaks2D(val, min_thresh);
            locs_i = Fast_peaks2D(val, min_thresh, ns);
            if  numel(locs_i) >0
                locs_i(:,8) = locs_i(:,3);
                for j = 1:numel(locs_i(:,1))
                    locs_i(j,8) = id(round(locs_i(j,2)),round(locs_i(j,1)));
                    locs_i(j,8) = -angles(locs_i(j,8));
                end
            else
            end
            %% no rotation code
        else
           
            ccr = normxcorr2(ref,img_g(:,:,i));
 
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
                ccr = ccr(round(size(ref,1)/2):round(end - size(ref,1)/2),round(size(ref,2)/2):round((end - (size(ref,2))/2)),:);
            end

            locs_i = Fast_peaks2D(ccr, min_thresh, ns);
            locs_i(:,8) = 0;
        end
        %% end of rotation if
    end

    s = any(locs_i);
    if s(1)~=0
        if ex_edge ==1 && strcmp('ccr', method)
        else
            locs_i(:,2) = (locs_i(:,2)-size(ref,1)/2);
            locs_i(:,1) = (locs_i(:,1)-size(ref,2)/2);
        end
        if strcmp('ccr', method)
            locs_i(:,4) = locs_i(:,3);
        end
        for j = 1:numel(locs_i(:,1))
            if round(locs_i(j,2))>0 && round(locs_i(j,1))>0
                h(:,j) = img(round(locs_i(j,2)),round(locs_i(j,1)),i);
            else
                h(:,j) = 0;
            end
        end
        locs_i(:,3) = h(:,:);
    else
        locs_i = [];
    end


    if numel(locs_i) >0
        frame = []; frame(1:numel(locs_i(:,1)),1) = i;
        locs_i(:,5) = frame;
        locs = [locs; locs_i];

     
    else

    end


end

if numel(locs) >0

else
    locs=nan;
end

            locs(:,1:2) = locs(:,1:2)*2;
         
end
