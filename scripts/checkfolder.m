
function [dominantFormat, dominantFormatLocations] = checkfolder(folderPath)
% Specify the list of expected file types
expectedFileTypes = {'.ibw', '.jpk', '.nhf', '.gwy', 'NanoScope'};
fileList = dir(folderPath);
fileFormatCount = containers.Map;

% Initialize the fileFormat cell array
fileFormat = cell(1, length(fileList));

for i = 1:length(fileList)
    if ~fileList(i).isdir
        % Get the file name
        fileName = fileList(i).name;

        % Split the file name into parts using the dot (.) as the delimiter
        parts = strsplit(fileName, '.');

        % Get the file format (extension)
        if numel(parts) > 1
            fileFormat{i} = ['.', parts{end}]; % Include the dot in the format

            % Check if this file format is one of the expected formats
            if ismember(fileFormat{i}, expectedFileTypes)
                % Update the count for this file format
                if isKey(fileFormatCount, fileFormat{i})
                    fileFormatCount(fileFormat{i}) = fileFormatCount(fileFormat{i}) + 1;
                else
                    fileFormatCount(fileFormat{i}) = 1;
                end
            end

            fid = fopen(fullfile(folderPath, fileName), 'r');
            line = fgets(fid);
            fclose(fid);
            if length(strfind(line, '\*File list')) >= 1
                fileFormat{i} = 'NanoScope';

                if isKey(fileFormatCount, fileFormat{i})
                    fileFormatCount(fileFormat{i}) = fileFormatCount(fileFormat{i}) + 1;
                else
                    fileFormatCount(fileFormat{i}) = 1;
                end

            end
        end
    end
end

% Find the dominant file format among the expected types
dominantFormat = '';
maxCount = 0;
for i = 1:length(expectedFileTypes)
    format = expectedFileTypes{i};
    if isKey(fileFormatCount, format) && fileFormatCount(format) > maxCount
        maxCount = fileFormatCount(format);
        dominantFormat = format;
    end
end

% Find the locations of files with the dominant file format
dominantFormatLocations = {};
for i = 1:length(fileList)
    if ~fileList(i).isdir
        fileName = fileList(i).name;
        parts = strsplit(fileName, '.');
        if numel(parts) > 1 && strcmp(['.', parts{end}], dominantFormat)
            dominantFormatLocations{end + 1} = fullfile(folderPath, fileName);
        elseif isempty(fileparts(fileName)) && strcmp(fileFormat{i}, dominantFormat)
            % Check for files with no file extension and match the dominantFormat
            dominantFormatLocations{end + 1} = fullfile(folderPath, fileName);
        end
    end
end

end
