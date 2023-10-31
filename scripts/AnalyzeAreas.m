function [T1, T2] = AnalyzeAreas(M,img,props,scale,time,speed)

%   props = {'Area','Centroid','Orientation','Circularity','Perimeter',...
%           'MinIntensity','MaxIntensity','MeanIntensity'};

if scale(1) ==0
    scale(1) =1;
end
sd = size(img);

if numel(sd)>2
    n = sd(3);

    for i = 1:n
        if numel(scale)>1
            fr = i;
        else
            fr=1;
        end
        
        if i==1
            T1 = struct2table(regionprops(M(:,:,i),img(:,:,i),props));
            frame= ones(numel(T1(:,1)),1).*i;
            times = ones(numel(T1(:,1)),1).*time(i);
            T1 = addvars(T1,frame,'Before',1,'NewVariableNames','Frame');
            T1 = addvars(T1,times,'Before',2,'NewVariableNames','Time (s)');

            if ismember('Area', props)
                T1.('Radius') = ([T1.('Area')]/pi).^0.5;
                T1.Radius = T1.Radius*scale(fr);
                T1.Area = T1.Area*(scale(fr)*scale(fr));
                if ismember('MeanIntensity', props)
                    T1.('Vol. (nm3)') =  T1.Area.*T1.MeanIntensity;
                end
            end

            if ismember('Perimeter', props)
                T1.Perimeter = T1.Perimeter*scale(fr);
            end

        else
            si = struct2table(regionprops(M(:,:,i),img(:,:,i),props));
            frame= ones(numel(si(:,1)),1).*i;
        try             
            times = ones(numel(si(:,1)),1).*time(i);
        catch
             times = frame/speed;
        end
            si = addvars(si,frame,'Before',1,'NewVariableNames','Frame');
            si = addvars(si,times,'Before',2,'NewVariableNames','Time (s)');
            
            
           if ismember('Area', props)
                si.('Radius') = ([si.('Area')]/pi).^0.5;
                si.Radius = si.Radius*scale(fr);
                si.Area = si.Area*(scale(fr)*scale(fr));
                if ismember('MeanIntensity', props)
                    si.('Vol. (nm3)') =  si.Area.*si.MeanIntensity;
                end
            end

            if ismember('Perimeter', props)
                si.Perimeter = si.Perimeter*scale(fr);
            end


            T1 = [T1;si];
        end

    end

T1.('Track id') = zeros(numel(T1.Frame),1);

else
    T1 = struct2table(regionprops(M,img,props));
      frame= ones(numel(T1(:,1)),1);
      T1 = addvars(T1,frame,'Before',1,'NewVariableNames','Frame');

      if ismember('Area', props)
          T1.('Radius') = ([T1.('Area')]/pi).^0.5;
          T1.Radius = T1.Radius*scale;
          T1.Area = T1.Area*(scale*scale);
          if ismember('MeanIntensity', props)
              T1.('Vol. (nm3)') =  T1.Area.*T1.MeanIntensity;
          end
      end

if ismember('Perimeter', props)
    T1.Perimeter = T1.Perimeter*scale;
end
end


if numel(sd)>2
    for i = 1:n
         if numel(scale)>1
            fr = i;
        else
            fr=1;
        end
        temp = M(:,:,i);
        temp_img = img(:,:,i);
        Area_p(i) = sum(temp(:))/(sd(1)*sd(2))*100;
        h =temp.*temp_img;
        av_h(i) = sum(h(:))/sum(temp(:));
        hb =(temp<0.5).*temp_img;
        av_hb(i) = sum(hb(:))/sum(temp(:)<0.5);
        %av_h =mean height of mask and av_h2 = mean of other area
        Vol(i) = av_h(i).*sum(temp(:))*(scale(fr)*scale(fr));
    end
    frame = 1:n;
    if time(1) ==0 && numel(time) ==1
        times = frame;
    else
    times = time;
    end
else
     temp = M(:,:);
        temp_img = img(:,:);
        Area_p = sum(temp(:))/(sd(1)*sd(2))*100;
        h =temp.*temp_img;
        av_h = sum(h(:))/sum(temp(:));
        hb =(temp<0.5).*temp_img;
        av_hb = sum(hb(:))/sum(temp(:)<0.5);
        %av_h =mean height of mask and av_h2 = mean of other area
        Vol = av_h.*sum(temp(:))*(scale(1)*scale(1));
          times = 1;
          frame = 1;
end
    varNames = {'Frame','Time (s)', 'Area (%)','Mean z (nm)','Background z (nm)', 'Vol. (nm3)'};
    T2 = table(frame', times', Area_p', av_h', av_hb', Vol','VariableNames',varNames);
    
end


