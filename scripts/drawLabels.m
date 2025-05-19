function drawLabels(ax, img, frame, app)
if app.ScalebarCheckBox.Value ==1
    [r, cs, ~] = size(img(:,:,1));

    if numel(app.ImageInfo.PixelPerNm)>1
        fr = frame;
        switch  app.FramePartSwitch.Value
            case 'Particles'
                fr = app.Part.Locs((app.Part.Locs(:,6)==fr),5);
        end
    else
        fr=1;
    end

    sb = cs./app.ImageInfo.PixelPerNm(fr);
    try
        scale_bar = round(sb/5,1,"significant");
        scale_bar_pix = scale_bar.*app.ImageInfo.PixelPerNm(fr);

        switch app.Settings.label.ScaleBar.position
            case 'Top Right'
                if app.Settings.label.ScaleBar.offimage
                    xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
                    ypos = [-r*0.07, -r*0.07];
                    ylim(ax, [-r*0.1, r]); % expand vertical axis upwards
                else
                    xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
                    ypos = round([r*0.05, r*0.05]);
                end
            case 'Top Left'
                if app.Settings.label.ScaleBar.offimage
                    xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
                    ypos = [-r*0.07, -r*0.07];
                    ylim(ax, [-r*0.1, r]); % expand vertical axis upwards
                else
                    xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
                    ypos = round([r*0.05, r*0.05]);
                end
            case 'Bottom Left'
                if app.Settings.label.ScaleBar.offimage
                    xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
                    ypos = [r + r*0.07, r + r*0.07];
                    ylim(ax, [0, r + r*0.1]); % expand vertical axis downwards
                else
                    xpos = [round(cs*0.05), round(cs*0.05) + scale_bar_pix];
                    ypos = round([r*0.95, r*0.95]);
                end
            case 'Bottom Right'
                if app.Settings.label.ScaleBar.offimage
                    xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
                    ypos = [r + r*0.07, r + r*0.07];
                    ylim(ax, [0, r + r*0.1]); % expand vertical axis downwards
                else
                    xpos = [round(cs*0.95) - scale_bar_pix, round(cs*0.95)];
                    ypos = round([r*0.95, r*0.95]);
                end
        end

        line(ax,xpos,ypos,'LineWidth',2,'Color',app.Settings.label.ScaleBar.color);
        if ~app.Settings.label.ScaleBar.baronly
            if scale_bar >1000

                text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar/1000) char(181),'m'],...
                    'FontWeight','bold','FontSize', str2num(app.Settings.label.ScaleBar.font),'Color', app.Settings.label.ScaleBar.color,'HorizontalAlignment','center');
            else
                text(ax, xpos(1)+scale_bar_pix/2, round(ypos(1) - r*.03), [num2str(scale_bar) 'nm'],...
                    'FontWeight','bold','FontSize', str2num(app.Settings.label.ScaleBar.font),'Color', app.Settings.label.ScaleBar.color,'HorizontalAlignment','center');
            end
        end
    catch
    end
end


if app.TimescaleCheckBox.Value==1
    [r, cs, ~] = size(img(:,:,1));

    time = app.ImageInfo.time(frame);

    switch app.Settings.label.TimeStamp.position
        case 'Top Right'
            if app.Settings.label.TimeStamp.offimage_2
                xpos = round(cs*.97);
                ypos = -r*.05;
                ylim(ax, [-r*.1, r]);  % expand axis upwards
            else
                xpos = round(cs*.97);
                ypos = round(r*.05);
            end
        case 'Top Left'
            if app.Settings.label.TimeStamp.offimage_2
                xpos = round(cs*.03);
                ypos = -r*.05;
                ylim(ax, [-r*.1, r]);  % expand axis upwards
            else
                xpos = round(cs*.03);
                ypos = round(r*.05);
            end
        case 'Bottom Left'
            if app.Settings.label.TimeStamp.offimage_2
                xpos = round(cs*.03);
                ypos = r + r*.05;
                ylim(ax, [0, r + r*.1]);  % expand axis downwards
            else
                xpos = round(cs*.03);
                ypos = round(r*.95);
            end
        case 'Bottom Right'
            if app.Settings.label.TimeStamp.offimage_2
                xpos = round(cs*.97);
                ypos = r + r*.05;
                ylim(ax, [0, r + r*.1]);  % expand axis downwards
            else
                xpos = round(cs*.97);
                ypos = round(r*.95);
            end
    end

decimals = app.Settings.label.TimeStamp.decimalPlaces;
showUnits = app.Settings.label.TimeStamp.showUnits;

switch app.Settings.label.TimeStamp.format
    case 'seconds'
        timeStr = num2str(round(time, decimals), ['%0.', num2str(decimals), 'f']);
        if showUnits
            formattedTime = [timeStr ' s'];
        else
            formattedTime = timeStr;
        end

    case 'milliseconds'
        msVal = round(time * 1000, decimals);
        msFormat = ['%0.', num2str(decimals), 'f'];
        timeStr = sprintf(msFormat, msVal);
        if showUnits
            formattedTime = [timeStr ' ms'];
        else
            formattedTime = timeStr;
        end

    case 'minutes:seconds'
        minutes = floor(time / 60);
        seconds = floor(mod(time, 60));
        if showUnits
            formattedTime = sprintf('%02d:%02d min', minutes, seconds);
        else
            formattedTime = sprintf('%02d:%02d', minutes, seconds);
        end

    case 'hh:mm:ss'
        hours = floor(time / 3600);
        minutes = floor(mod(time, 3600) / 60);
        seconds = floor(mod(time, 60));
        if showUnits
            formattedTime = sprintf('%02d:%02d:%02d h', hours, minutes, seconds);
        else
            formattedTime = sprintf('%02d:%02d:%02d', hours, minutes, seconds);
        end

    otherwise  % fallback to seconds
        timeStr = num2str(round(time, decimals), ['%0.', num2str(decimals), 'f']);
        if showUnits
            formattedTime = [timeStr ' s'];
        else
            formattedTime = timeStr;
        end
end

parts = strsplit(app.Settings.label.TimeStamp.position);
secondWord = parts{2};

text(ax, xpos, ypos, formattedTime, ...
    'FontWeight', 'bold', 'FontSize', str2num(app.Settings.label.TimeStamp.font), ...
    'Color', app.Settings.label.TimeStamp.color, ...
    'HorizontalAlignment', secondWord);
end

 