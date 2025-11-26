% Create a UI figure
f = uifigure('Name', 'Drag and Drop Example', 'Position', [100 100 400 300]);

% Assign the WindowDropFcn callback
f.WindowDropFcn = @fileDropCallback;

% Create a UI label to provide instructions
uilabel(f, 'Text', 'Drag and drop files here', 'Position', [100 140 200 22], 'HorizontalAlignment', 'center');

% The callback function definition
function fileDropCallback(src, event)
    % Get the list of dropped file paths
    droppedFiles = event.Files;

    % Display the file names in the Command Window
    disp('Dropped files:');
    for i = 1:length(droppedFiles)
        disp(droppedFiles{i});
    end
    
    % You can add logic here to process the files, 
    % e.g., read data, display images, etc.
    uialert(src, sprintf('Successfully dropped %d files.', length(droppedFiles)), 'Files Dropped');
end
