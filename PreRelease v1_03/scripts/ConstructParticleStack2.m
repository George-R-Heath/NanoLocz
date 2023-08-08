%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function Result = ConstructParticleStack2(app, ImageTarget, ref, Part)
updateInterval = 5;
if ~app.MultiReferenceCheckBox.Value
    n = numel(Part.Locs(:,1));
else
    n = numel(Part(:,1));
end    
cla(app.loadbar)
stepsPerUpdate = ceil(n * (updateInterval / 100));
rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

if ~app.MultiReferenceCheckBox.Value
    img_pad = padarray(ImageTarget,[round(ref.position(4)), round(ref.position(3))],0,'both');
    if rem(ref.position(4),2)==0
        dy1 = 0;
        dy2 = 1;
    else
        dy1 = 0.5;
        dy2 = 0.5;
    end
    if rem(ref.position(3),2)==0
        dx1 = 0;
        dx2 = 1;
    else
        dx1 = 0.5;
        dx2 = 0.5;
    end
    
    for i = 1:n
        clipy1 = round(Part.Locs(i,2)+ref.position(4)/2+dy1);
        clipy2 = round(Part.Locs(i,2)+ref.position(4)*1.5-dy2);
        clipx1 = round(Part.Locs(i,1)+ref.position(3)/2+dx1);
        clipx2 = round(Part.Locs(i,1)+ref.position(3)*1.5-dx2);
        try
        Result(:,:,i) = img_pad(clipy1:clipy2,clipx1:clipx2,Part.Locs(i,5));
        catch
        Result(:,:,i) = Part.Image(:,:,Part.Locs(i,5));
        end
    
        if i == 1
            Result(:,:,numel(Part.Locs(:,1))) = Result(:,:,i);
        end
    
        shifty = round(Part.Locs(i,2)+ref.position(4)/2+dy1)-(Part.Locs(i,2)+ref.position(4)/2+dy1);
        shiftx = round(Part.Locs(i,1)+ref.position(3)/2+dx1)-(Part.Locs(i,1)+ref.position(3)/2+dx1);
    try
        tform = rigidtform2d(-Part.Locs(i,8),[shiftx, shifty]);
        sameAsInput = affineOutputView(size(Result(:,:,i)),tform,"BoundsStyle","CenterOutput");
        Result(:,:,i) = imwarp(Result(:,:,i),tform,"OutputView",sameAsInput,'interp','bicubic');
    catch
      Result(:,:,i) = imrotate(Result(:,:,i), Part.Locs(i,8), 'crop');
      Result(:,:,i) = imtranslate(Result(:,:,i), [shiftx, shifty] );
    end     
        if mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            progressText.String = sprintf([num2str(i),' particles assembled']);
            drawnow;
        end
    end
else
    position = ref{2};
    img_pad = padarray(ImageTarget,[round(position(4)), round(position(3))],0,'both');
    if rem(position(4),2)==0
        dy1 = 0;
        dy2 = 1;
    else
        dy1 = 0.5;
        dy2 = 0.5;
    end
    if rem(position(3),2)==0
        dx1 = 0;
        dx2 = 1;
    else
        dx1 = 0.5;
        dx2 = 0.5;
    end
    
    for i = 1:n
        clipy1 = round(Part(i,2)+position(4)/2+dy1);
        clipy2 = round(Part(i,2)+position(4)*1.5-dy2);
        clipx1 = round(Part(i,1)+position(3)/2+dx1);
        clipx2 = round(Part(i,1)+position(3)*1.5-dx2);
        try
        Result(:,:,i) = img_pad(clipy1:clipy2,clipx1:clipx2,Part(i,5));
        catch
        Result(:,:,i) = Part.Image(:,:,Part(i,5));
        end
    
        if i == 1
            Result(:,:,numel(Part(:,1))) = Result(:,:,i);
        end
    
        shifty = round(Part(i,2)+position(4)/2+dy1)-(Part(i,2)+position(4)/2+dy1);
        shiftx = round(Part(i,1)+position(3)/2+dx1)-(Part(i,1)+position(3)/2+dx1);
      try
        tform = rigidtform2d(-Part(i,8),[shiftx, shifty]);
        sameAsInput = affineOutputView(size(Result(:,:,i)),tform,"BoundsStyle","CenterOutput");
        Result(:,:,i) = imwarp(Result(:,:,i),tform,"OutputView",sameAsInput,'interp','bicubic');
      catch
          Result(:,:,i) = imrotate(Result(:,:,i), Part.Locs(i,8), 'crop');
          Result(:,:,i) = imtranslate(Result(:,:,i), [shiftx, shifty] );
      end 
        if mod(i, stepsPerUpdate) == 0 || i == n
            progressBar.Position(3) = i / n;
            progressText.String = sprintf([num2str(i),' particles assembled']);
            drawnow;
        end
    end
end
end





