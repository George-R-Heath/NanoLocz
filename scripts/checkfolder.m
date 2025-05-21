function [dominantFormat, dominantFormatLocations] = checkfolder(folderPath)

    expectedFileTypes = {'.ibw', '.jpk', '.nhf', '.gwy', 'NanoScope','.spm'};
     ignore = {'.jpeg', '.tiff', '.m', '.mat','.h5','.txt'};
    % List files in the folder
    fileList = dir(fullfile(folderPath, '*')); 
    fileFormatCount = containers.Map('KeyType', 'char', 'ValueType', 'double');
    dominantFormatLocations = {};
    
    % Process each file
    for i = 1:length(fileList)
        if fileList(i).isdir
            continue;
        end
        
        fileName = fileList(i).name;
        filePath = fullfile(folderPath, fileName);
        [~, ~, ext{i}] = fileparts(fileName);
       if ismember(ext{i}, ignore)
            continue;
        end
        % Check if the file type is in expected list
        if ismember(ext{i}, expectedFileTypes)
            if isKey(fileFormatCount, ext{i})
                fileFormatCount(ext{i}) = fileFormatCount(ext{i}) + 1;
            else
                fileFormatCount(ext{i}) = 1;
            end
        else
            % Check for NanoScope file
            fid = fopen(filePath, 'r');
            if fid ~= -1
                firstLine = fgets(fid);
                fclose(fid);
                if contains(firstLine, '\*File list')
                    ext{i} = '.spm';
                end
            end
            if ismember(ext{i}, expectedFileTypes)
                if isKey(fileFormatCount, ext{i})
                    fileFormatCount(ext{i}) = fileFormatCount(ext{i}) + 1;
                else
                    fileFormatCount(ext{i}) = 1;
                end
            end
        end


    end
    
    % Determine dominant format
    if isempty(fileFormatCount)
        dominantFormat = '';
        return;
    end
    
    [maxCount, idx] = max(cell2mat(values(fileFormatCount)));
    dominantFormat = keys(fileFormatCount);
    dominantFormat = dominantFormat{idx};
    
    % Find locations of dominant format files
    for i = 1:length(fileList)

        if strcmp(ext{i}, dominantFormat) 
      dominantFormatLocations{end+1} = fullfile(folderPath, fileList(i).name);
        end
    end
end