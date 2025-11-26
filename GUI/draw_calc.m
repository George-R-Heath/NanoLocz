function app = draw_calc(app,perimeter,type,k)
frame = round(app.Spinner.Value);
switch  app.FramePartSwitch.Value
    case 'Frames'
        img = app.ImageTarget;
    case 'Particles'
        img = app.Part.Image(:,:,app.Part.IncludeImages);
end

switch app.DrawTool.Value
    case 'ROI'
        switch type
            case 'rectHandle'
            otherwise
                if ~isempty(perimeter)
                    minX = min(perimeter(:,1));
                    maxX = max(perimeter(:,1));
                    minY = min(perimeter(:,2));
                    maxY = max(perimeter(:,2));
                    width = maxX - minX;
                    height = maxY - minY;
                end
                clear perimeter
                perimeter = [minX, minY, width, height];
                perimeter = round(perimeter);
        end
        app.ref.ROIimage =  imcrop(img(:,:,round(app.FrameSlider.Value)), [perimeter(1), perimeter(2), perimeter(3)-1, perimeter(4)-1]);
        app.ref.position = perimeter;
        app.SquareROI =[];
        app.SquareROI.Position = perimeter;
        if sum(strcmp(app.RightPlotList.Items,'Ref Image')) <1
            app.RightPlotList.Items = [app.RightPlotList.Items , {'Ref Image'}];
        end
        app.RightPlotList.Value = 'Ref Image';
        app.TabGroup2.SelectedTab = app.ReferenceTab;
        if sum(strcmp(app.RefListBox.Items,'ROI Reference')) <1
            app.RefListBox.Items = [app.RefListBox.Items , {'ROI Reference'}];
        end
        app.RefListBox.Value = 'ROI Reference';
        if perimeter(3)>1 && perimeter(4)>1
            updateRightPlot(app)
        end
        drawnow;
    case 'Profile'
        if numel(app.ImageInfo.ScanSize)>1
            fr = round(app.FrameSlider.Value);
            switch  app.FramePartSwitch.Value
                case 'Particles'
                    fr = app.Part.Locs((app.Part.Locs(:,6)==fr),5);
            end
        else
            fr=1;
        end
        switch type
            case 'rectHandle'
                app.ROI.Line(k).Position = [perimeter(1),perimeter(2); perimeter(1) + perimeter(3),  perimeter(2);
                    perimeter(1) + perimeter(3),  perimeter(2) + perimeter(4); perimeter(1),perimeter(2) + perimeter(4); perimeter(1),perimeter(2)];
            otherwise
                app.ROI.Line(k).Position = perimeter;
                
        end
perimeter = double(perimeter);
        [cx, cy, cz] = improfile(img(:,:,frame),perimeter(:,1),perimeter(:,2),'bilinear');
        if app.LineThickness.Value/2 >=1 && numel(cz)>5
            switch type
                case 'scribble'
                    app.LineThickness.Value = 1;
                otherwise
                    cz  = improfile_thick(app.LineThickness.Value/2,app.ROI.Line(k).Position,img(:,:,frame),app.Draw.Value);
            end
        end
        dist = sum(sqrt(diff(cx).^2 + diff(cy).^2))/app.ImageInfo.PixelPerNm(fr);
        x = dist/numel(cz):dist/numel(cz):dist;

        app.ROI.Line(k).Profile = [x', cz];

    case 'Average'
        sd = size(img);
       
        if numel(sd)>2
            switch type
                
                case 'rectHandle'
                    for i = 1:sd(3)
                        roi_pixels = img(perimeter(2):perimeter(2)+perimeter(4)-1, perimeter(1):perimeter(1)+perimeter(3)-1,i);
                        app.ROI.AreaAverage(i,k) = mean(roi_pixels(:));
                    end
                    app.ROI.Line(k).Position = [perimeter(1),perimeter(2); perimeter(1) + perimeter(3),  perimeter(2);
                        perimeter(1) + perimeter(3),  perimeter(2) + perimeter(4); perimeter(1),perimeter(2) + perimeter(4); perimeter(1),perimeter(2)];
                    %app.ROI.Line(k).Position = round(app.ROI.Line(k).Position);
                 
                otherwise
                    app.ROI.Line(k).Position = perimeter;
                    mask = poly2mask(perimeter(:,1),  perimeter(:,2), sd(1), sd(2));
                    for i = 1:sd(3)
                        temp = img(:,:,i);
                        roi_pixels = temp(mask);
                        app.ROI.AreaAverage(i,k) = mean(roi_pixels);
                    end
            end
            if sum(strcmp(app.RightPlotList.Items,'Time Profile')) <1
                app.RightPlotList.Items = [app.RightPlotList.Items , {'Time Profile'}];
            end
            app.RightPlotList.Value = 'Time Profile';
            updatePlot2_type(app,'plot')
            updatePlot2(app,'normal')

        else
            return
        end
    case {'+ Mask','- Mask'}
        switch type
            case 'rectHandle'
                app.ROI.Line(k).Position = [perimeter(1),perimeter(2); perimeter(1) + perimeter(3),  perimeter(2);
                    perimeter(1) + perimeter(3),  perimeter(2) + perimeter(4); perimeter(1),perimeter(2) + perimeter(4); perimeter(1),perimeter(2)];
            otherwise
             %   app.ROI.Line(k).Position = perimeter;
        end

end
end
