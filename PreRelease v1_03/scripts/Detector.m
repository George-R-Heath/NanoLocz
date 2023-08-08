%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [locs] = Detector(app, img, method, ref, filt_img, filt_ccr, min_thresh, ex_edge, rotfreedom, angles)
%OUTPUT:
% locs(:,1) = x,
% locs(:,2) = y,
% locs(:,3) = height,
% locs(:,4) = ccr,
% locs(:,5) = frame,
% locs(:,6) = angle,
% locs(:,9) = reference no
% rotfreedom =1;
% angles = -start:interval:end;

locs = [];
n = numel(img(1,1,:));

if filt_img >0
    img_g = imgaussfilt(img,filt_img);
else
    img_g = img;
end

ns = round(min(size(ref))/2);
updateInterval = 5;
cla(app.loadbar)
stepsPerUpdate = ceil(n * (updateInterval / 100));
rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

for i = 1:n
    if app.stop == 1
        return
    end
    locs_i = [];
    h=[];
    if strcmp('Peak picker', method)
        locs_i = peaks2D(img_g(:,:,i), min_thresh,ref);
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
            locs_i = peaks2D(val, min_thresh, ns);
            if  numel(locs_i) >0
                locs_i(:,8) = locs_i(:,3);
                for j = 1:numel(locs_i(:,1))
                    locs_i(j,8) = id(round(locs_i(j,2)),round(locs_i(j,1)));
                    locs_i(j,8) = -angles(locs_i(j,8));
                end
            else
            end

            s = any(locs_i);
            if s(1)~=0
                if ex_edge ==1 && strcmp('ccr', method)
                else
                    locs_i(:,2) = locs_i(:,2)-size(ref,1)/2;
                    locs_i(:,1) = locs_i(:,1)-size(ref,2)/2;
                end
                if strcmp('ccr', method)
                    locs_i(:,4) = locs_i(:,3);
                end
                for j = 1:numel(locs_i(:,1))
                    if round(locs_i(j,2))>0 && round(locs_i(j,1))>0
                        h(:,j) = img(round(locs_i(j,2)),round(locs_i(j,1)));
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

                if mod(i, stepsPerUpdate) == 0 || i == n
                    progressBar.Position(3) = i / n;
                    progressText.String = sprintf([num2str(numel(locs(:,1))),' particles detected']);
                    drawnow;
                end
            else
                if mod(i, stepsPerUpdate) == 0 || i == n
                    progressBar.Position(3) = i / n;
                    drawnow;
                end
            end

            %% single ref no rotation code 
        elseif ~app.MultiReferenceCheckBox.Value && rotfreedom ==0
            ccr = normxcorr2(ref,img_g(:,:,i));
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
                ccr = ccr(round(size(ref,1)/2):round(end - size(ref,1)/2),round(size(ref,2)/2):round((end - (size(ref,2))/2)),:);
            end

            locs_i = peaks2D(ccr, min_thresh, ns);
            locs_i(:,8) = 0;

                s = any(locs_i);
                if s(1)~=0
                    if ex_edge ==1 && strcmp('ccr', method)
                    else
                        locs_i(:,2) = locs_i(:,2)-size(ref,1)/2;
                        locs_i(:,1) = locs_i(:,1)-size(ref,2)/2;
                    end
                    if strcmp('ccr', method)
                        locs_i(:,4) = locs_i(:,3);
                    end
                    for j = 1:numel(locs_i(:,1))
                        if round(locs_i(j,2))>0 && round(locs_i(j,1))>0
                            h(:,j) = img(round(locs_i(j,2)),round(locs_i(j,1)));
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

                    if mod(i, stepsPerUpdate) == 0 || i == n
                        progressBar.Position(3) = i / n;
                        progressText.String = sprintf([num2str(numel(locs(:,1))),' particles detected']);
                        drawnow;
                    end
                else
                    if mod(i, stepsPerUpdate) == 0 || i == n
                        progressBar.Position(3) = i / n;
                        drawnow;
                    end
                end
        end
        %% end of rotation if
    end

if app.MultiReferenceCheckBox.Value
        max_ref_height = 0;
    max_ref_width = 0;
    for k = 1:app.RefNo
         locs{k,1} = [];
        for i = 1:n
            ref_img = ref(k);
            [ref_height, ref_width] = size(ref_img{1});
            max_ref_height = max(max_ref_height, ref_height);
            max_ref_width = max(max_ref_width, ref_width);

            resized_ref_img = imresize(ref_img{1}, [max_ref_height, max_ref_width]);
            ccr = normxcorr2(resized_ref_img, img_g(:,:,i));
            if filt_ccr >0
                ccr = imgaussfilt(ccr,filt_ccr);
            end
            if ex_edge ==1
                ccr = ccr(round(size(ref,1)/2):round(end - size(ref,1)/2),round(size(ref,2)/2):round((end - (size(ref,2))/2)),:);
            end

            locs_i = [];
            h = [];
            locs_i = peaks2D(ccr, min_thresh, ns);
            locs_i(:,8) = 0;
            s = any(locs_i);
            if s(1)~=0
                if ex_edge ==1 && strcmp('ccr', method)
                else
                    locs_i(:,2) = locs_i(:,2)-size(ref,1)/2;
                    locs_i(:,1) = locs_i(:,1)-size(ref,2)/2;
                end
                if strcmp('ccr', method)
                    locs_i(:,4) = locs_i(:,3);
                end
                for j = 1:numel(locs_i(:,1))
                    if round(locs_i(j,2))>0 && round(locs_i(j,1))>0
                        h(:,j) = img(round(locs_i(j,2)),round(locs_i(j,1)));
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
                locs_i(:,9) = k;
                
                locs{k,1} = [locs{k,1}; locs_i];
                

                if mod(i, stepsPerUpdate) == 0 || i == n
                    progressBar.Position(3) = i / n;
                    progressText.String = sprintf([num2str(numel(locs{k}(:,1))),' particles detected']);
                    drawnow;
                end
            else
                if mod(i, stepsPerUpdate) == 0 || i == n
                    progressBar.Position(3) = ii / n;
                    drawnow;
                end
            end
        end
    end


end

if numel(locs) >0

else
    locs=nan;
end


end
