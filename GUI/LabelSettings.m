function LabelSettings
allfigs = findall(0,'Type', 'figure');
% isolate the NanoLocz handle
app2Handle = findall(allfigs, 'Name', 'NanoLocz');

% Ensures data is sent to already open NanoLocz window
app.mainApp = app2Handle(1).RunningAppInstance;
            
    % Create the main figure
    fig = uifigure('Name', 'Label Settings', 'Position', [200, 200, 270, 200]);
    
    % Define the options for colors and positions
    colorOptions = {'white','black', 'cyan', 'magenta', 'red', 'green', 'blue'};
    positionOptions = {'Top Left', 'Top Right', 'Bottom Left', 'Bottom Right'};
    
    % Create labels for scalebar color and position
    uilabel(fig, 'Text', 'Scale Bar', 'Position', [80, 175, 120, 22],'FontWeight', 'bold');
    uilabel(fig, 'Text', 'Time Stamp', 'Position', [180, 175, 120, 22],'FontWeight', 'bold');
    
    uilabel(fig, 'Text', 'Color', 'Position', [25, 155, 120, 22],'FontWeight', 'bold');
    
    uilabel(fig, 'Text', 'Position', 'Position', [10, 130, 120, 22],'FontWeight', 'bold');
  
    
   
   % uilabel(fig, 'Text', 'Position:', 'Position', [120, 130, 120, 22],'FontWeight', 'bold');
    
    % Create dropdown for scalebar color
    scalebarColorDropdown = uidropdown(fig, ...
        'Items', colorOptions, ...
        'Position', [60, 155, 100, 22], ...
        'ValueChangedFcn', @onScalebarColorChanged);
    
    % Create dropdown for scalebar position
    scalebarPositionDropdown = uilistbox(fig, ...
        'Items', positionOptions, ...
        'Position', [60, 80, 100, 70], ...
        'ValueChangedFcn', @onScalebarPositionChanged);
    
    % Create dropdown for timescale color
    timescaleColorDropdown = uidropdown(fig, ...
        'Items', colorOptions, ...
        'Position', [160, 155, 100, 22], ...
        'ValueChangedFcn', @onTimescaleColorChanged);
    
    % Create dropdown for timescale position
    timescalePositionDropdown = uilistbox(fig, ...
        'Items', positionOptions, ...
        'Position', [160, 80, 100, 70], ...
        'ValueChangedFcn', @onTimescalePositionChanged);
    
    function onScalebarColorChanged(src, ~)
        selectedColor = src.Value;
        app.mainApp.LabelColor(selectedColor,'scalebar')
    end

    function onScalebarPositionChanged(src, ~)
        selectedPosition = src.Value;
        app.mainApp.LabelPosition(selectedPosition,'scalebar')
    end

    function onTimescaleColorChanged(src, ~)
        selectedColor = src.Value;
        app.mainApp.LabelColor(selectedColor,'timestamp')
    end

    function onTimescalePositionChanged(src, ~)
        selectedPosition = src.Value;
        app.mainApp.LabelPosition(selectedPosition,'timestamp')
    end
end
