% Function written for NanoLocz app 2025 
% DESCRIPTION:
%   Loads image data and associated metadata into the NanoLocz app from
%   supported file types (.mat or .h5). Updates app properties and UI
%   elements (e.g., channel selection) based on the loaded content.
%
% USAGE:
%   im = app_openmat(app, imageName, filetype)
%
% INPUTS:
%   app        - NanoLocz app instance
%   imageName  - Full path to the image file to load
%   filetype   - File extension as string: '.mat' or '.h5'
%
% OUTPUTS:
%   im         - Image data extracted from the file
%
% NOTES:
%   - Supports both multi-channel files and single images.
%   - Extracts and updates ImageInfo, reference data (ref), particle
%     locations (Part), and LAFM locations when available.
%   - For session files, populates stored data and updates dropdowns/lists.

function im = app_openmat(app, imageName, filetype)

if strcmp(filetype,'.mat')
    loadedData = load(imageName);
    if isfield(loadedData, 'multi_channel_file')
        app.ImageInfo = loadedData.ImageInfo;
        app.ChannelDropDown.Items = app.ImageInfo.Channels;
        app.ChannelDropDown.Visible =1;
        searchCh = app.ChannelDropDown.Value;
        app.ImageInfo.Channel = searchCh;
        rowNumber = strcmp(app.ChannelDropDown.Items, searchCh);
        temp = 1:numel(rowNumber);
        ch = temp(rowNumber);
        im = loadedData.Image{ch};

    else
        if isfield(loadedData, 'Data')
            imageDataStruct = loadedData.Data;
        elseif isfield(loadedData, 'Images')
            imageDataStruct = loadedData.Images;

        else
            return
        end
        if numel(imageDataStruct) == 1
            im = imageDataStruct.Imagedata;
            app.ImageInfo = imageDataStruct.ImageInfo;
            if app.ImageInfo.n > 1
                if numel(app.ImageInfo.ScanSize)<app.ImageInfo.n
                    app.ImageInfo.ScanSize(1:app.ImageInfo.n) = app.ImageInfo.ScanSize(1);
                end
                if numel(app.ImageInfo.PixelPerNm)<app.ImageInfo.n
                    app.ImageInfo.PixelPerNm(1:app.ImageInfo.n) = app.ImageInfo.PixelPerNm(1);
                end
                if ~isfield(app.ImageInfo, 'time') || numel(app.ImageInfo.time)<app.ImageInfo.n
                    for i = 1:app.ImageInfo.n
                        app.ImageInfo.time(i) = round(i/app.ImageInfo.ScanSpeed,4,"significant");
                    end
                end
            end
            if ~isfield(app.ImageInfo, 'Channel')
                app.ImageInfo.Channel = {'unknown'};
                app.ImageInfo.Channels = {app.ImageInfo.Channel};
            end
            if isfield(imageDataStruct.ref,'position')
                app.ref = imageDataStruct.ref;
                if isfield(loadedData, 'Data')
                    app.ref = imageDataStruct.ref;
                elseif isfield(loadedData, 'Images')
                    app.ref = imageDataStruct.ref;
                    app.ref.ROIimage =  app.ref.image;
                end

            end

            if isfield(imageDataStruct.ImageLocs,'Locs')

                if isfield(loadedData, 'Data')
                     app.Part = imageDataStruct.ImageLocs;
                elseif isfield(loadedData, 'Images')
                     app.Part.Locs = imageDataStruct.ImageLocs;
                end
                
            end

            if isfield(imageDataStruct.LAFMLocs,'Locs')
                app.LAFM = imageDataStruct.LAFMLocs;
            end

        else
            %session file opening
            filepath = fullfile(imageName);
            loadedData = load(filepath);
            try
                app.stored = loadedData.Data;
            catch
                app.stored = loadedData.Images;
            end

            app.FilesDropDown.Value = 'Processed';
            try
                app.FilesListBox.Items = {app.stored.ImageName};
                app.FilesListBox.Value = app.stored(1).ImageName;
                im = app.stored(1).Imagedata;
                app.ImageInfo = app.stored(1).ImageInfo;
            catch
                app.FilesListBox.Items = {'no files'};
            end

        end
    end
elseif strcmp(filetype,'.h5')

    loadedData = open_h5(imageName);
    im = loadedData.Imagedata;
    app.ImageInfo = loadedData.ImageInfo;
    app.ImageInfo.Channels = app.ImageInfo.Channel;

    updateTable(app)

    if isfield(loadedData,'ref')
        app.ref = loadedData.ref;
    end

    if isfield(loadedData,'ImageLocs')
        app.Part = loadedData.ImageLocs;
    end

    if isfield(loadedData,'LAFMLocs')
        app.LAFM = loadedData.LAFMLocs;
    end
end