%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [x,y] = FineAlign_Frames(app, ImageTarget,refimg,pixel_shift,sub_pix,~)  

sz = size(ImageTarget);
ImageTarget(isnan(ImageTarget)) = 0;
window = round(pixel_shift);

updateInterval = 5;
stepsPerUpdate = ceil(sz(3) * (updateInterval / 100));
rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
n = sz(3);
for i = 1:n
    if app.stop == 1
        return
    end

   ccr = normxcorr2(refimg, ImageTarget(:,:,i));
   ccr_sz = size(ccr);
         % 
         % if filt_cr>0
         %     ccr = imgaussfilt(ccr , filt_cr);
         % end
   [~,imax] = max(abs(ccr(:)));
   [y(i),x(i)] = ind2sub(size(ccr),imax(1));
   
           if pixel_shift>0 && i >1    
               if (y(i-1)-window+1)>0 && (y(i-1)+window-1)< ccr_sz(1) && (x(i-1)-window+1) > 0 && x(i-1)+window-1 < ccr_sz(2)
                   ccr_p  = ccr(y(i-1)-window+1:y(i-1)+window-1,x(i-1)-window+1:x(i-1)+window-1);
                   [~,imax] = max(abs(ccr_p(:)));
                   [yw(i),xw(i)] = ind2sub(size(ccr_p),imax(1));  %find position of max cross correlation
       
                   xw(i) = xw(i) - window;
                   yw(i) = yw(i) - window;

                   x(i) = x(1) + sum(xw(1:i));
                   y(i) = y(1) + sum(yw(1:i));
                   try
                       if sub_pix == 1
                           c_wind = 3;
                           clip_c = ccr(y(i)-c_wind+1:y(i)+c_wind-1,x(i)-c_wind+1:x(i)+c_wind-1);
                           c_zoom = imresize(clip_c, 100, 'bicubic');

                           [~,imax] = max(abs(c_zoom(:)));
                           [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
                           ypeak2 = ypeak2-1;
                           xpeak2 = xpeak2-1;
                           x_offset_2(i) = (xpeak2-size(c_zoom,2)/2)/100;
                           y_offset_2(i) = (ypeak2-size(c_zoom,1)/2)/100;
                       else
                           x_offset_2(i) = 0;
                           y_offset_2(i) = 0;
                       end
                   catch
                       x_offset_2(i) = 0;
                       y_offset_2(i) = 0;
                   end

               else
               end
           end
      
       if i ==1 || pixel_shift == 0
            if sub_pix == 1
            c_wind = 3;
            clip_c = ccr(y(i)-c_wind+1:y(i)+c_wind-1,x(i)-c_wind+1:x(i)+c_wind-1);
            c_zoom = imresize(clip_c, 100, 'bilinear');
            [~,imax] = max(abs(c_zoom(:)));
            [ypeak2,xpeak2] = ind2sub(size(c_zoom),imax(1));
            ypeak2 = ypeak2-1;
             xpeak2 = xpeak2-1;
            x_offset_2(i) = (xpeak2-size(c_zoom,2)/2)/100; 
            y_offset_2(i) = (ypeak2-size(c_zoom,1)/2)/100;
            else
            x_offset_2(i) = 0; 
            y_offset_2(i) = 0;
            end   
       else
       end

        if mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            progressText.String = sprintf([num2str(i),' frames aligned']);
            drawnow;
        end
   end

   x = x' + x_offset_2(:)-sz(2);
   y = y' + y_offset_2(:)-sz(1);

   end