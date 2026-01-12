function [app, ax] = draw_finish(app, ~, ~, ax,type,k)
fig = ancestor(ax, 'figure');
props = getappdata(fig, 'TestGuiCallbacks');
set(fig, props);
setappdata(fig, 'TestGuiCallbacks', []);
ax.UserData.startPos = [];
C = hsv(8);
C = [C ;   jet(8)];
C = [C ;   parula(8)];
switch type
    case {'lineHandle','PolyLinehandle'}
        try
            try
                app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                    'Color', C(k,:), 'LineWidth', 2);
                hold on
                plot(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                    '.','Color', C(k,:), 'LineWidth', 2)
                hold off
            catch
                app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                    'LineWidth', 2);
                hold on
                 plot(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                   '.', 'LineWidth', 2);
                 hold off
            end
            drawnow;
        catch
        end

    case {'circleHandle', 'rectHandle'}
        switch app.DrawTool.Value
            case {'Profile', 'Average'}
                try
                    try
                        app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                            'Color', C(k,:), 'LineWidth', 2);
                        hold on
                        plot(ax, [app.ROI.Line(k).Position(1,1),app.ROI.Line(k).Position(end,1)], [app.ROI.Line(k).Position(1,2),app.ROI.Line(k).Position(end,2)], ...
                            'v','Color', C(k,:), 'LineWidth', 2)
                        hold off
                    catch
                        app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                            'LineWidth', 2);
                        hold on
                        plot(ax, [app.ROI.Line(k).Position(1,1),app.ROI.Line(k).Position(end,1)], [app.ROI.Line(k).Position(1,2),app.ROI.Line(k).Position(end,2)], ...
                            'v', 'LineWidth', 2)
                        hold off
                    end

                catch
                end

                drawnow;
            case {'+ Mask','- Mask'}
                sd= size(ax.Children(end).CData);
                perimeter =  app.ROI.Line(k).Position;
                mask = poly2mask(perimeter(:,1),  perimeter(:,2), sd(1), sd(2));
                if isfield(app.Mask,'ROI')
                    s = any(app.Mask.ROI);
                else
                    s(1)=0;
                end

                switch app.DrawTool.Value
                    case '+ Mask'
                        % Determine whether to remove or add regions to the mask

                        if s(1) == 1
                            app.Mask.ROI = app.Mask.ROI .* (mask < 1);
                        else
                            app.Mask.ROI = mask < 1;
                        end
                    case '- Mask'
                        % Add to the mask if ROIThresholdButton is pressed
                        if s(1) == 1
                            app.Mask.ROI = app.Mask.ROI | mask;
                        else
                            app.Mask.ROI = mask;
                        end
                end
                app.filter_already =0;
                app.PreviewonoffButton.Value =1;
                previewOnOff(app)
                run_filter(app)
                updatePlot2(app,'normal')
                ax.UserData.points = [];
        end


    case 'markerHandle'
        hold(app.UIAxes,'on')
        plot(ax, app.ROI.Point(k).Position(1), app.ROI.Point(k).Position(2), 'Marker', 'o', 'MarkerSize', 4, 'MarkerFaceColor', C(k,:));
        text(ax, app.ROI.Point(k).Position(1)+5, app.ROI.Point(k).Position(2),num2str(app.ROI.Point(k).h),'Color',C(k,:),'FontSize',16,'FontWeight','bold');
        drawnow;
        hold(app.UIAxes,'off')
    case 'scribble'
        points = ax.UserData.points;
        if size(points, 1) >= 2
            switch app.DrawTool.Value
                case {'+ Mask','- Mask'}

                    % Connect the start point to the end point
                    line(app.UIAxes, [points(1, 1), points(end, 1)], [points(1, 2), points(end, 2)], ...
                        'Color', 'r', 'LineWidth', 2);
                    x = points(:, 1);
                    y = points(:, 2);
                    mask = freehandROItoLogicMatrix(x, y, size(ax.Children(end).CData));

                    if isfield(app.Mask,'ROI')
                        s = any(app.Mask.ROI);
                    else
                        s(1)=0;
                    end

                    % Determine whether to remove or add regions to the mask
                    switch app.DrawTool.Value
                        case '+ Mask'
                            % Determine whether to remove or add regions to the mask

                            if s(1) == 1
                                app.Mask.ROI = app.Mask.ROI .* (mask < 1);
                            else
                                app.Mask.ROI = mask < 1;
                            end
                        case '- Mask'
                            % Add to the mask if ROIThresholdButton is pressed
                            if s(1) == 1
                                app.Mask.ROI = app.Mask.ROI | mask;
                            else
                                app.Mask.ROI = mask;
                            end
                    end
                    app.filter_already =0;
                    app.PreviewonoffButton.Value =1;
                    previewOnOff(app)
                    run_filter(app)
                    ax.UserData.points = [];
                  app.ROI.Line =[];
                case 'Profile'
                               
                
                    try
                        app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                            'Color', C(k,:), 'LineWidth', 2);
                        hold on
                        plot(ax, [app.ROI.Line(k).Position(1,1),app.ROI.Line(k).Position(end,1)], [app.ROI.Line(k).Position(1,2),app.ROI.Line(k).Position(end,2)], ...
                            'v','Color', C(k,:), 'LineWidth', 2)
                        hold off
                    catch
                        app.ROI.Line(k).plt = line(ax, app.ROI.Line(k).Position(:,1), app.ROI.Line(k).Position(:,2), ...
                            'LineWidth', 2);
                        hold on
                        plot(ax, [app.ROI.Line(k).Position(1,1),app.ROI.Line(k).Position(end,1)], [app.ROI.Line(k).Position(1,2),app.ROI.Line(k).Position(end,2)], ...
                            'v', 'LineWidth', 2)
                        hold off
                    end
            
            drawnow;
            
            end

        end

end



    function mask = freehandROItoLogicMatrix(x, y, imageSize)
        [X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));
        warning('off');
        polygon = polyshape(x, y);
        warning('on');
        mask = inpolygon(X(:), Y(:), polygon.Vertices(:, 1), polygon.Vertices(:, 2));
        mask = reshape(mask, imageSize);
    end

end

