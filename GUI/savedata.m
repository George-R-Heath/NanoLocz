function savedata(app, target, addon)

ch = contains({app.stored.ImageName}, app.FilesListBox.Value);
if app.Settings.ExportSettings.AutoSave
    namesplit = split(app.ImageName,'.');
    Extensions =  {'csv', 'txt', 'dat', 'tsv', ... % Delimited text files
        'xls', 'xlsx', 'xlsm', 'xlsb', 'xltx', 'xltm', 'ods','jpg', 'jpeg', 'png', 'bmp', 'gif', ...
        'jp2', 'j2k', 'pbm', 'pgm', 'ppm', 'hdr', 'pfm', ...
        'ico', 'cur','jpk','spm','mat','h5','ibw','tif','tiff','asd','nhf', 'gwy','aris'};
    if ismember(namesplit(end), Extensions)
        filename_i = strcat(join(namesplit(1:end-1)));
    else
        filename_i = strcat(join(namesplit(1:end)));
    end
    if app.AutoSaveButton.Value 
        switch app.Settings.ExportSettings.FilenameType
            case {"Save to new location","Prompt for name"}
        app.Settings.ExportSettings.FilenameType = 'Auto save (same name)';
        end
    end
    switch app.Settings.ExportSettings.FilenameType

        case "Auto save (same name)"
            filename = filename_i;

        case "Prompt for name"
            initialPath = fullfile(app.Settings.Folder.Output, filename_i{1});
            [file, path] = uiputfile({'*.*'}, 'Save as', initialPath);
            file = {file};
            if isequal(file, 0)
                return; % User cancelled
            end
            filename = file;
            location = path;

        case "Add suffix _copy"
            filename = {[filename_i{1}, '_copy']};
        case "Add suffix _channel"
            filename = {[filename_i{1},'_', app.ChannelDropDown.Value]};
        case "Save to new location"
            newpath = uigetdir('', 'Select Save Location');
            if isequal(newpath, 0)
                return; % User cancelled
            end
            filename = filename_i;
            location = newpath;

        otherwise
            return; % Unsupported option
    end


    switch app.Settings.ExportSettings.FilenameType
        case {"Auto save (same name)","Add suffix _copy","Add suffix _channel"}

            % Handle subfolders logic
            if app.Settings.ExportSettings.SubFolders
                [~, currentFolderName, ~] = fileparts(app.Settings.Folder.Open);
                if ~contains(currentFolderName, ' NanoLocz Output')
                    subfolderNameWithNL = [currentFolderName, ' NanoLocz Output'];
                else
                    subfolderNameWithNL = currentFolderName;
                end
                location = fullfile(app.Settings.Folder.Output, subfolderNameWithNL);
                if ~isfolder(location)
                    mkdir(location);
                end
            else
                location = app.Settings.Folder.Output;
            end

            if app.Settings.ExportSettings.SubFolders_2
                if app.Settings.ExportSettings.SubFolders
                    FolderOut = location;
                else
                    FolderOut = app.Settings.Folder.Output;
                end
                namesplit = split(app.ImageName, '.');
                filename_base = strcat(join(namesplit(1:end-1)));
                location = fullfile(FolderOut, filename_base{1});
                if ~isfolder(location)
                    mkdir(location);
                end
            end
    end

    % Base name for output files (strip extension if present)

    format_Combi = app.Settings.ExportSettings.CombiFormat;
    format_Image = app.Settings.ExportSettings.ImageFormat;
    format_Table = app.Settings.ExportSettings.TableFormat;

    % Export combined format
    if ~strcmp(format_Combi, 'off')
        fname = strcat(filename, format_Combi);
        filepath = fullfile(location, fname);
        exporter(app.stored(ch), format_Combi, filepath, 0);
    end

    % Export image format
    invalidImages = {'Part Locs', 'LAFM Locs', 'Area', 'Area Frame'};
    if ~strcmp(format_Image, 'off') && ~ismember(addon, invalidImages)
        fname = strcat(filename, '_', addon, format_Image);
        filepath = fullfile(location, fname);
        exporter(target, format_Image, filepath, 0);
    end

    % Export table format
    invalidTables = {'Image', 'Ref avg', 'LAFM Movie', 'LAFM Movie sym', 'LAFM', 'LAFM sym'};
    if ~strcmp(format_Table, 'off') && ~ismember(addon, invalidTables)
        fname = strcat(filename, '_', addon, format_Table);
        filepath = fullfile(location, fname);

        if strcmp(addon, 'Part Locs')
            if size(app.Part.Locs, 2) > 9
                target = array2table(app.Part.Locs(app.Part.IncludeImages, :), ...
                    'VariableNames', {'x', 'y', 'Height', 'ccr', 'Frame', 'id', 'Track id', 'Angle', 'FWHM min', 'FWHM max', 'FWHM mean'});
            else
                target = array2table(app.Part.Locs(app.Part.IncludeImages, :), ...
                    'VariableNames', {'x', 'y', 'Height', 'ccr', 'Frame', 'id', 'Track id', 'Angle'});
            end
        elseif strcmp(addon, 'LAFM Locs')
            target = array2table(app.LAFM.Locs, ...
                'VariableNames', {'x', 'y', 'z', 'Peak Prominence', 'Particle', 'Frame', 'Time', 'ccr'});
        end
        exporter(target, format_Table, filepath, 1);
    end
    updateFolder(app)
end
end