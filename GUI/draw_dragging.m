function [app, ax] = draw_dragging(app,~, ~, ax, type,img ,k)

startPos = ax.UserData.startPos;
currentPosD = ax.CurrentPoint(1, 1:2);
thickness = app.LineThickness.Value/2;
if isfield(ax.UserData, type)
    delete(ax.UserData.(type));
    ax.UserData = rmfield(ax.UserData, type);
end
C = hsv(8);
C = [C ;   jet(8)];
C = [C ;   parula(8)];
switch type
    case 'rectHandle'
        WidthHeight = abs(currentPosD - startPos);
        rect4 = [min(startPos(1), currentPosD(1)), min(startPos(2), currentPosD(2)), WidthHeight];
        rect4 = round(rect4);
        ax.UserData.rectHandle = rectangle('Parent', ax, 'Position', rect4, 'EdgeColor', C(k,:), 'LineWidth', 1);
        perimeter = round(ax.UserData.rectHandle.Position);
        app = draw_calc(app,perimeter,type,k);

        switch app.DrawTool.Value
            case 'Profile'
                if thickness >= 1
                    outer_x_start = perimeter(1) - thickness;
                    outer_y_start = perimeter(2) - thickness;
                    outer_width = perimeter(3) + 2 * thickness;
                    outer_height = perimeter(4) + 2 * thickness;
                    inner_x_start = perimeter(1) + thickness;
                    inner_y_start = perimeter(2) + thickness;
                    inner_width = max(0, perimeter(3) - 2 * thickness);
                    inner_height = max(0, perimeter(4) - 2 * thickness);

                    if isfield(ax.UserData, 'outerRect') && isvalid(ax.UserData.outerRect)
                        delete(ax.UserData.outerRect);
                    end
                    if isfield(ax.UserData, 'innerRect') && isvalid(ax.UserData.innerRect)
                        delete(ax.UserData.innerRect);
                    end

                    ax.UserData.outerRect = rectangle('Parent', ax, 'Position', [outer_x_start, outer_y_start, outer_width, outer_height], ...
                        'EdgeColor', C(k,:), 'LineWidth', 1);
                    ax.UserData.innerRect = rectangle('Parent', ax, 'Position', [inner_x_start, inner_y_start, inner_width, inner_height], ...
                        'EdgeColor', C(k,:), 'LineWidth', 1);
                end


                try
                    if sum(strcmp(app.RightPlotList.Items, 'Line Profile')) < 1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Line Profile'}];
                    end
                    app.RightPlotList.Value = 'Line Profile';
                    updatePlot2_type(app, 'plot');
                    app.OverlayDropDown.Value = 'Line Profile';
                    updatePlot2(app, 'live');
                    updateResultsTable(app, 'Line Profile');
                catch
                end
        end

    case {'lineHandle', 'PolyLinehandle'}
        switch app.DrawTool.Value
            case 'Profile'
                if isfield(ax.UserData, 'textHandle')
                    prevTextHandle = ax.UserData.textHandle;
                    delete(prevTextHandle);  % Delete the previous text
                end
                switch app.Draw.Value
                    case 'PolyLine'
                        try
                            startPos = [app.ROI.Line(k-1).Position(2,1), app.ROI.Line(k-1).Position(2,2)];
                        catch
                        end
                end

                dx = currentPosD(1) - startPos(1);
                dy = startPos(2) - currentPosD(2);
                angle_rad = atan2(dy, dx);
                angle_deg = rad2deg(angle_rad);
                angle_deg_rounded = angle_deg;
                roundedEndPos = currentPosD;

                fig = ancestor(img, 'figure');
                shiftHeld = ismember('shift', fig.CurrentModifier);

                if shiftHeld
                    angle_deg_rounded = round(angle_deg / 45) * 45;
                    angle_rad_rounded = deg2rad(angle_deg_rounded);
                    distance = sqrt(dx^2 + dy^2);
                    dx_rounded = cos(angle_rad_rounded) * distance;
                    dy_rounded = -sin(angle_rad_rounded) * distance;
                    roundedEndPos = [startPos(1) + dx_rounded, startPos(2) + dy_rounded];
                end
                app.ROI.Line(k).Position(:,1) = [startPos(1), roundedEndPos(1)];
                app.ROI.Line(k).Position(:,2) = [startPos(2), roundedEndPos(2)];

                if thickness >= 1
                    xo = app.ROI.Line(k).Position(:,1) + thickness * sin(angle_rad);
                    yo = app.ROI.Line(k).Position(:,2) + thickness * cos(angle_rad);
                    xi = app.ROI.Line(k).Position(:,1) - thickness * sin(angle_rad);
                    yi = app.ROI.Line(k).Position(:,2) - thickness * cos(angle_rad);
                end

                perimeter = app.ROI.Line(k).Position;
                switch app.Draw.Value
                    case 'PolyLine'
                        perimeter = [];
                        for i = 1:k
                            perimeter = [perimeter; app.ROI.Line(i).Position];
                        end
                end
                % Positioning text relative to the line
                if abs(angle_deg_rounded) == 0 || abs(angle_deg_rounded) == 180
                    px = 0;
                    py = 10; % Position above the line
                elseif abs(angle_deg_rounded) == 90 || abs(angle_deg_rounded) == 270
                    px = 10; % Position to the side of the line
                    py = 0;
                else
                    px = 10 * sign(dx); % Position to the side based on line direction
                    py = 10 * sign(dy); % Position above or below based on line direction
                end

                try
                    ax.UserData.lineHandle = line(ax, [startPos(1), roundedEndPos(1)], [startPos(2), roundedEndPos(2)], ...
                        'Color', C(k,:),'LineWidth', 1);
                catch
                    ax.UserData.lineHandle = line(ax, [startPos(1), roundedEndPos(1)], [startPos(2), roundedEndPos(2)], ...
                        'LineWidth', 1);
                end


                if thickness>=1
                    if isfield(ax.UserData, 'lineHandle1') && isvalid(ax.UserData.lineHandle1)
                        delete(ax.UserData.lineHandle1);
                    end
                    if isfield(ax.UserData, 'lineHandle2') && isvalid(ax.UserData.lineHandle2)
                        delete(ax.UserData.lineHandle2);
                    end

                    % Draw parallel lines
                    ax.UserData.lineHandle1 = line(ax, xi, yi, 'Color', C(k,:), 'LineWidth', 1);
                    ax.UserData.lineHandle2 = line(ax, xo, yo, 'Color', C(k,:), 'LineWidth', 1);
                end

                if numel(app.ImageInfo.ScanSize) > 1
                    fr = round(app.FrameSlider.Value);
                    switch app.FramePartSwitch.Value
                        case 'Particles'
                            fr = app.Part.Locs((app.Part.Locs(:,6) == fr), 5);
                    end
                else
                    fr = 1;
                end

                dist = round(sqrt((roundedEndPos(1) - startPos(1))^2 + (roundedEndPos(2) - startPos(2))^2) / app.ImageInfo.PixelPerNm(fr), 1);
                try
                    textHandle = text(app.UIAxes, mean([startPos(1), roundedEndPos(1)]) + px, mean([startPos(2), roundedEndPos(2)]) + py, [num2str(dist) 'nm'], 'Color', C(k,:), 'FontSize', 12);
                catch
                    textHandle = text(app.UIAxes, mean([startPos(1), roundedEndPos(1)]) + px, mean([startPos(2), roundedEndPos(2)]) + py, [num2str(dist) 'nm'], 'FontSize', 12);
                end
                ax.UserData.textHandle = textHandle;
                app = draw_calc(app,perimeter,type,k);

                if numel(app.ROI.Line(k).Profile(:,1))>2
                    if sum(strcmp(app.RightPlotList.Items, 'Line Profile')) < 1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Line Profile'}];
                    end
                    app.RightPlotList.Value = 'Line Profile';
                    updatePlot2_type(app, 'plot');
                    app.OverlayDropDown.Value = 'Line Profile';
                    updatePlot2(app, 'live');
                    updateResultsTable(app, 'Line Profile');
                else
                    return
                end
            otherwise
        end
    case 'circleHandle'
        radius = norm(currentPosD - startPos) / 2;
        center = (currentPosD + startPos) / 2;
        theta = linspace(0, 2 * pi, 180);
        x = center(1) + radius * cos(theta);
        y = center(2) + radius * sin(theta);
        perimeter = [x;y]';
        if thickness >=1 && radius >= thickness
            radius_o = norm(currentPosD - startPos) / 2 + thickness;
            radius_i = norm(currentPosD - startPos) / 2 - thickness;
            x_i = center(1) + radius_i * cos(theta);
            y_i = center(2) + radius_i * sin(theta);
            x_o = center(1) + radius_o * cos(theta);
            y_o = center(2) + radius_o * sin(theta);
        end

        if isfield(ax.UserData, 'circleHandle') && isvalid(ax.UserData.circleHandle)
            delete(ax.UserData.circleHandle); % Remove existing circle if any
        end
        if isfield(ax.UserData, 'thickline_o') && isvalid(ax.UserData.thickline_o)
            delete(ax.UserData.thickline_o); % Remove existing circle if any
        end
        if isfield(ax.UserData, 'thickline_i') && isvalid(ax.UserData.thickline_i)
            delete(ax.UserData.thickline_i); % Remove existing circle if any
        end
        ax.UserData.circleHandle = line(ax, x, y, 'Color', 'w', 'LineWidth', 1);
        if thickness >=1 && radius >= thickness
            ax.UserData.thickline_o = line(ax, x_o, y_o, 'Color', C(k,:), 'LineWidth', 1);
            ax.UserData.thickline_i = line(ax, x_i, y_i, 'Color', C(k,:), 'LineWidth', 1);
        end
        app = draw_calc(app,perimeter,type,k);

        switch app.DrawTool.Value
            case 'Profile'
                if numel(app.ROI.Line(k).Profile(:,1))>2
                    if sum(strcmp(app.RightPlotList.Items, 'Line Profile')) < 1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Line Profile'}];
                    end
                    app.RightPlotList.Value = 'Line Profile';
                    updatePlot2_type(app, 'plot');
                    app.OverlayDropDown.Value = 'Line Profile';
                    updatePlot2(app, 'live');
                    updateResultsTable(app, 'Line Profile');
                else
                    return
                end
        end
    case 'markerHandle'

        if isfield(ax.UserData, 'textHandle')
            prevTextHandle = ax.UserData.textHandle;
            delete(prevTextHandle);  % Delete the previous text
        end
        hold(app.UIAxes,'on')
        ax.UserData.markerHandle = plot(ax, currentPosD(1), currentPosD(2), ...
            'Marker', 'o', 'MarkerSize', 4, 'MarkerFaceColor', C(k,:));

        frame = round(app.Spinner.Value);

        switch  app.FramePartSwitch.Value
            case 'Frames'
                switch  app.LeftPlotList.Value
                    case 'Target'
                        img = app.ImageTarget;
                    case 'Preview'
                        img = app.ImagePreview;
                end
            case 'Particles'
                switch  app.LeftPlotList.Value
                    case 'Target'
                        img = app.Part.Image(:,:,app.Part.IncludeImages);
                    case 'Preview'
                        img = app.ImagePreview(:,:,app.Part.IncludeImages);
                end
        end
        if frame <= app.Spinner.Limits(2)
            prev = img(:,:,frame);
        else
            prev = img(:,:,1);
        end
        app.ROI.Point(k).Position = [currentPosD(1), currentPosD(2)];

        app.ROI.Point(k).h = round(prev(round( app.ROI.Point(k).Position(2)),round( app.ROI.Point(k).Position(1))),2);
        textHandle = text(app.UIAxes, app.ROI.Point(k).Position(1)+5, app.ROI.Point(k).Position(2),num2str( app.ROI.Point(k).h ),'Color',C(k,:),'FontSize',16,'FontWeight','bold');
        ax.UserData.textHandle = textHandle;
        drawnow;

    case 'scribble'
        ax.UserData.points = [ax.UserData.points; ax.CurrentPoint(1, 1:2)];
        % Draw the line connecting the current and previous points
        line(app.UIAxes,ax.UserData.points(:, 1), ax.UserData.points(:, 2), 'Color', C(k,:), 'LineWidth', 2);
        drawnow;
        perimeter = ax.UserData.points;
        app = draw_calc(app,perimeter,type,k);

        switch app.DrawTool.Value
            case 'Profile'
                if numel(app.ROI.Line(k).Profile(:,1))>2
                    if sum(strcmp(app.RightPlotList.Items, 'Line Profile')) < 1
                        app.RightPlotList.Items = [app.RightPlotList.Items , {'Line Profile'}];
                    end
                    app.RightPlotList.Value = 'Line Profile';
                    updatePlot2_type(app, 'plot');
                    app.OverlayDropDown.Value = 'Line Profile';
                    updatePlot2(app, 'live');
                    updateResultsTable(app, 'Line Profile');
                else
                    return
                end
        end
end
end