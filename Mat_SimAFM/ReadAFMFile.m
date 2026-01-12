% Function written for NanoLocz-lib (2025)
% ReadAFMFile reads AFM images and metadata from a variety of file formats.
%
%  Loads atomic force microscopy (AFM) images and associated metadata from the specified 
%   imageName. The function supports multiple file formats including JPK, NanoScope,
%   IBW, NHF, Gwyddion (.gwy), TIFF, HDF5 (.h5), and RIBM (.asd) files, as well as 
%   sequences of images in folders.
%
%   INPUTS:
%       imageName   - String specifying the path to a file or folder containing AFM data.
%       channel     - (Optional) String specifying the desired data channel (default: 'Height').
%       frames      - (Optional) Number of frames to load or 'all' (default: 'all').
%       app         - (Optional) App object for updating progress bar during loading.
%
%   OUTPUTS:
%       im          - 3D matrix containing loaded AFM image data.
%       ImageInfo   - Struct containing metadata including scan size, pixel size,
%                     frame timing, available channels, and other acquisition parameters.
%
%   Supported file types:
%       - JPK (.jpk)
%       - NanoScope (.spm)
%       - Igor Binary Wave (.ibw)
%       - NanoHybrid (.nhf)
%       - Gwyddion (.gwy)
%       - TIFF (.tif, .tiff)
%       - HDF5 (.h5)
%       - RIBM (.asd)
%
%   Notes:
%   - When provided with a folder, the function will attempt to load it as a sequence.
%   - Progress bar updates are shown if an app object with a valid 'loadbar' is provided.
%   - Pixel sizes are reported in pixels per nanometre.
%
%   Example:
%       [im, info] = ReadAFMFile('example.jpk', 'Height', 'all');
%
%   See also: open_h5jpk, open_JPK_info, open_nanoscope, open_IBW, open_NHF, open_gwychannel, open_h5, open_asd


function[im, ImageInfo] = ReadAFMFile(imageName, channel,frames, app)
if nargin < 2 || isempty(channel)
    channel = 'Height';  % Default channel
end
if nargin < 3 || isempty(channel)
    frames = 'all';  % Default channel
end

validTablesExtensions =  {'csv', 'txt', 'dat', 'tsv', ... % Delimited text files
    'xls', 'xlsx', 'xlsm', 'xlsb', 'xltx', 'xltm', 'ods'};
validRGBExtensions = {'jpg', 'jpeg', 'png', 'bmp', 'gif', ...
    'jp2', 'j2k', 'pbm', 'pgm', 'ppm', 'hdr', 'pfm', ...
    'ico', 'cur'};
    useGUI = exist('app', 'var') && isvalid(app) && isprop(app, 'loadbar');
    if useGUI
        cla(app.loadbar);
        rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
        progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', [0.30, 0.98, 0.40]);
        progressText = text(app.loadbar, 0.5, 0.5, 'Starting...', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'Color', 'black');
    end

if isfolder(imageName)  %if folder try open as Video
    [Format, fileNames] = checkfolder(imageName);
    n = length(fileNames);
    if useGUI
        updateInterval = 5;  % Ensures n is included
        stepsPerUpdate = ceil(n * (updateInterval / 100));
    end
       if n == 0
        im = 0;
        return
    else
        ImageInfo.n = n;
       end
       switch frames
           case 'all'
               loadn = ImageInfo.n;
           otherwise
               if frames<n
                   loadn = frames;
               else
                   loadn = ImageInfo.n;
               end
       end

    switch Format
        case '.jpk'

            count = 0;
            if ImageInfo.n ==1
            else
                ImageInfo.n =ImageInfo.n-1;
 
            end
            %    if View1stCheckBox.Value ==1 && View1st.Value < ImageInfo.n
            %       loadn = View1st.Value;
            %  else
            % end
            for ii = 1:loadn
                if ii ==1
                    [info, Channels] = open_JPK_info(fileNames{ii});
                    ImageInfo.Channels = strcat({Channels.Channel_name}', ' - ', {Channels.Trace_type}');
                    searchCh = channel;
                    ImageInfo.Channel = searchCh;
                    if contains(ImageInfo.Channel, 'Directional')
                        Bidir =1;
                    else
                        Bidir = 0;
                    end

                    rowNumber = strcmpi(ImageInfo.Channels, searchCh);
                    temp = 1:numel(rowNumber);
                    ch = temp(rowNumber);
                    if ~any(ch)
                        rowNumber = contains(ImageInfo.Channels, searchCh, 'IgnoreCase', true);
                        temp = 1:numel(rowNumber);
                        ch = temp(rowNumber);
                        try
                        ImageInfo.Channel =  ImageInfo.Channels{ch(1)};
                        ImageInfo.Channels{ch(1)};
                        catch
                            ch=1;
                        end

                    end

                    im = zeros(info.y_scan_pixels,info.x_scan_pixels,loadn);
                    [im(:,:,ii),multi,offs] = open_JPK_image(fileNames{ii},ch(1)+1);

                    ImageInfo.LineSpeed = info.Scan_Rate;
                    ImageInfo.ScanSize = round(info.x_scan_length*1e9);
                    ImageInfo.yPixels = info.y_scan_pixels;
                    ImageInfo.xPixels = info.x_scan_pixels;
                    ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
                    ImageInfo.ScanSpeed = ImageInfo.LineSpeed./ImageInfo.yPixels.*(1.*(Bidir)+1);
                    pause(0.001)
                    ImageInfo.time(ii) =  0;
                else
                    try
                        im(:,:,ii-count) = imread(fileNames{ii},ch(1)+1);
                        ImageInfo.time(ii-count) =  round((ii-1-count)/ImageInfo.ScanSpeed,4,"significant");
                        ImageInfo.PixelPerNm(ii-count) = ImageInfo.PixelPerNm(1);
                        ImageInfo.ScanSize(ii-count) = ImageInfo.ScanSize(1);
                        if useGUI && (mod(ii, stepsPerUpdate) == 0 || ii == n)
                            progressBar.Position(3) = ii / n;
                            progressText.String = sprintf('Loading file %d of %d', ii, n);
                            drawnow;
                        end

                    catch
                    end
                end

            end
            im = (flip(im)*multi)+offs;
            if contains(ImageInfo.Channel, {'Height', 'Lock-In Amplitude', 'Deflection'})
                im = im*1e9;
            end
            if contains(ImageInfo.Channel, 'Height')
                im(:,:,1) = level(im(:,:,1), 0, ImageInfo.ScanSpeed, 'log_y');
            end

        case {'NanoScope','.spm'}       %open nanoSCOPE
           count = 0;
            for ii = 1:loadn
                if ii ==1

                    try
                        [im(:,:,ii), info] = open_nanoscope(fileNames{ii},channel,0);
                    catch
                        try
                            [im(:,:,ii), info] = open_nanoscope(fileNames{ii},'Height',0);
                            channel ='Height';
                        catch

                            [im(:,:,ii), info] = open_nanoscope(fileNames{ii},'Height Sensor',0);
                            channel = 'Height Sensor';
                        end
                    end

                    ImageInfo.ScanSize(ii) = info.ScanSize;
                    ImageInfo.yPixels = info.line_no;
                    ImageInfo.xPixels = size(im,2);
                    ImageInfo.PixelPerNm(ii) = ImageInfo.xPixels./ImageInfo.ScanSize(ii);
                    ImageInfo.ScanSpeed = 1/(info.line_no.*info.Scan_Rate);
                    ImageInfo.LineSpeed = 1/info.Scan_Rate;
                    Timetemp{ii} = info.Time;
                    ImageInfo.Channels = info.channels;
                    ImageInfo.Channel = channel;
                    pause(0.001)
                else
                    if useGUI && (mod(ii, stepsPerUpdate) == 0 || ii == n)
                        progressBar.Position(3) = ii / n;
                        progressText.String = sprintf('Loading file %d of %d', ii, n);
                        drawnow;
                    end
                        [im(:,:,ii-count), info]  = open_nanoscope(fileNames{ii},channel,0);
                        ImageInfo.ScanSize(ii-count) = info.ScanSize;
                        ImageInfo.PixelPerNm(ii-count) = ImageInfo.xPixels./ImageInfo.ScanSize(ii-count);
                        ImageInfo.Channel = channel;
                        Timetemp{ii-count} = info.Time;
                    
                     %   count = count +1;
                      %  ImageInfo.n = ImageInfo.n-1;
                    

                end
            end
            ImageInfo.time = time_elapsed(Timetemp);
        case '.ibw'
            count = 0;
            for ii = 1:loadn
                if stop == 1
                    return
                end
                if ii==1
                    [im(:,:,ii), info] = open_IBW(fileNames{ii});
                    ImageInfo.ScanSize(ii) = info.ScanSize./1e-9;
                    ImageInfo.yPixels = info.yPixel;
                    ImageInfo.xPixels = info.xPixel;
                    ImageInfo.PixelPerNm(ii) = ImageInfo.xPixels./ImageInfo.ScanSize(ii);
                    ImageInfo.ScanSpeed = 1/info.frameAcqTime;
                    ImageInfo.LineSpeed = info.yPixel.*ImageInfo.ScanSpeed;
                    ImageInfo.Channel = 'Height';
                    ImageInfo.Channels = {ImageInfo.Channel};
                    ImageInfo.time(ii) =  0;
                else

                    try
                        [im(:,:,ii-count), info] = open_IBW(fileNames{ii});
                        if useGUI && ismember(ii, updateSteps)
                            progressBar.Position(3) = ii / n;
                            progressText.String = sprintf('Loading file %d of %d', ii, n);
                            drawnow;
                        end
                        ImageInfo.ScanSize(ii-count) = info.ScanSize./1e-9;
                        ImageInfo.PixelPerNm(ii-count) = ImageInfo.yPixels./ImageInfo.ScanSize(ii-count);
                        ImageInfo.time(ii-count) =  round((ii-1-count)/ImageInfo.ScanSpeed,4,"significant");
                    catch
                        count = count +1;
                        ImageInfo.n = ImageInfo.n-1;
                    end

                end
            end
            im = im.*1e9;
            im = flip(im);

        case '.nhf'

            count = 0;

            for ii = 1:loadn
                if ii ==1
                    try
                        [im(:,:,ii), info] = open_NHF(fileNames{ii},channel);
                    catch
                        [im(:,:,ii), info] = open_NHF(fileNames{ii},'Topography');
                    end
                    ImageInfo.ScanSize(ii)  = double(info.ScanSize)./1e-9;
                    ImageInfo.yPixels = double(info.yPixel);
                    ImageInfo.xPixels = double(info.xPixel);
                    ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize(ii);
                    ImageInfo.ScanSpeed = 1/double(info.frameAcqTime);
                    ImageInfo.LineSpeed = double(info.yPixel).*ImageInfo.ScanSpeed;
                    ImageInfo.Channel = info.channel;
                    ImageInfo.Channels = info.channels;
                    ImageInfo.time(ii-count) =  0;
                    pause(0.001)
                else
                    try
                        try
                            [im(:,:,ii-count), info] = open_NHF(fileNames{ii},channel);
                        catch
                            [im(:,:,ii-count), info] = open_NHF(fileNames{ii},'Topography');
                        end
                        ImageInfo.ScanSize(ii-count) = double(info.ScanSize)./1e-9;
                        ImageInfo.PixelPerNm(ii-count) = ImageInfo.xPixels./ImageInfo.ScanSize(ii-count);
                        ImageInfo.time(ii-count) =  round((ii-1-count)/ImageInfo.ScanSpeed,4,"significant");
                    catch
                        count = count +1;
                        ImageInfo.n = ImageInfo.n-1;
                    end

                end
            end
            im = im.*1e9;

        case '.gwy'

            count = 0;
            for ii = 1:loadn
                if stop == 1
                    return
                end
                if ii ==1
                    [img, info] = open_gwychannel(fileNames{ii});
                    ImageInfo.ScanSize(ii) = double(info.xreal)./1e-9;
                    ImageInfo.yPixels = double(info.yres);
                    ImageInfo.xPixels = double(info.xres);
                    ImageInfo.PixelPerNm(ii) = ImageInfo.xPixels./ImageInfo.ScanSize(ii);
                    ImageInfo.ScanSpeed = 0;
                    ImageInfo.LineSpeed = 0;
                    ImageInfo.Channels = (info.channels);

                    searchCh = channel;
                    ImageInfo.Channel = searchCh;
                    rowNumber = strcmp(ImageInfo.Channels, searchCh);
                    im(:,:,ii) = img{rowNumber};

                    ImageInfo.time(ii-count) =  0;
                    pause(0.001)
                else
                    try
                        [img, info] = open_gwychannel(fileNames{ii});
                        ImageInfo.ScanSize(ii-count) = double(info.xreal)./1e-9;
                        ImageInfo.PixelPerNm(ii-count) = ImageInfo.xPixels./ImageInfo.ScanSize(ii-count);
                        ImageInfo.Channels = (info.channels);

                        searchCh = channel;
                        ImageInfo.Channel = searchCh;
                        rowNumber = strcmp(ImageInfo.Channels, searchCh);
                        im(:,:,ii-count) = img{rowNumber};
                        ImageInfo.time(ii-count) =  round((ii-1-count)/ImageInfo.ScanSpeed,4,"significant");
                    catch
                        count = count +1;
                        ImageInfo.n = ImageInfo.n-1;
                    end
                end
            end
            im = im.*1e9;
        otherwise
            'Unrecognized Format';
            return
    end
else %it is a file
    namesplit = split(imageName,'.');
    filetype = namesplit{end};

    if strcmp(filetype,'tif') || strcmp(filetype,'tiff')
        Format = 'Tiff';
        info = imfinfo(imageName);   ImageInfo.n = numel(info);
        if any(info(1).XResolution)
            ImageInfo.PixelPerNm =  info(1).XResolution;
        else
            ImageInfo.PixelPerNm =  1;
        end
        ImageInfo.xPixels = info(1).Width;
        ImageInfo.yPixels  = info(1).Height;
        ImageInfo.LineSpeed = 0;
        ImageInfo.ScanSpeed = 0;

        % if View1stCheckBox.Value ==1 && View1st.Value < ImageInfo.n
        %    loadn = View1st.Value;
        %else
        loadn = ImageInfo.n;
        % end
        ImageInfo.PixelPerNm(1:loadn) = ImageInfo.PixelPerNm(1);
        if ImageInfo.PixelPerNm(1) >0
            ImageInfo.ScanSize(1:loadn) = ImageInfo.xPixels./ImageInfo.PixelPerNm;
        else
            ImageInfo.ScanSize(1:loadn) = 0;
        end
        im = zeros(ImageInfo.yPixels ,ImageInfo.xPixels, loadn);
        try
            for ii = 1:loadn
                im(:,:,ii) = imread(imageName,ii);
            end
            im = double(im);
            ImageInfo.Channel = 'Tiff';
        catch
            im = imread(imageName);
            im = double(rgb2gray(im(:,:,1:3)));
            ImageInfo.Channel = 'RGB Tiff';
        end

        ImageInfo.Channels = {ImageInfo.Channel};
        ImageInfo.time = 0;
        
    elseif strcmp(filetype,'h5')
        Format = 'h5';

        loadedData = open_h5(imageName);
        im = loadedData.Imagedata;
        ImageInfo = loadedData.ImageInfo;
    elseif strcmp(filetype,'asd')
        Format = 'RIBM';
        try
            [im, info] = open_asd(imageName,channel);
        catch
            [im, info] = open_asd(imageName,'Height');
        end
        ImageInfo.Channels = info.channels;
        ImageInfo.Channel = info.Ch;
        ImageInfo.ScanSize = info.xScanRange;
        ImageInfo.yPixels = info.yPixel;
        ImageInfo.xPixels = info.xPixel;
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = 1000/info.frameAcqTime;
        ImageInfo.LineSpeed = info.yPixel.*ImageInfo.ScanSpeed;
        ImageInfo.n = info.numberFramesCurrent;

        ImageInfo.time = double(0:1/ImageInfo.ScanSpeed:(ImageInfo.n-1)/ImageInfo.ScanSpeed);
        ImageInfo.PixelPerNm(1:ImageInfo.n) = ImageInfo.PixelPerNm(1);

    elseif strcmp(filetype,'ARIS')
        Format = 'ARIS';
        [im, info] = open_ARIS(imageName,channel);
        ImageInfo.ScanSize = info.scale./1e-9;
        ImageInfo.yPixels = info.yPixel;
        ImageInfo.xPixels = info.xPixel;
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = 1/info.frameAcqTime;
        ImageInfo.LineSpeed = info.yPixel.*ImageInfo.ScanSpeed;
        ImageInfo.n = info.numberofFrames;
        ImageInfo.Channel = info.channel;
        ImageInfo.Channels = info.channels;
        im = im.*1e9;
        ImageInfo.time = 0:info.frameAcqTime:(info.frameAcqTime*(ImageInfo.n-1));
    elseif strcmp(filetype,'ibw')
        Format = 'ibw';
        ImageInfo.n = 1;


        [im, info] = open_IBW(imageName);
        ImageInfo.ScanSize = info.ScanSize./1e-9;
        ImageInfo.yPixels = info.yPixel;
        ImageInfo.xPixels = info.xPixel;
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = 1/info.frameAcqTime;
        ImageInfo.LineSpeed = info.yPixel.*ImageInfo.ScanSpeed;
        ImageInfo.Channel = 'Height';
        ImageInfo.Channels = {ImageInfo.Channel};

        im = im.*1e9;
        im = flip(im);
        ImageInfo.time =0;
    elseif strcmp(filetype,'h5-jpk')
        Format = 'h5-jpk';
        [im, info] = open_h5jpk(imageName,channel);
        ImageInfo.ScanSize = double(info.xsize)./1e-9;
        ImageInfo.yPixels = info.yPixel;
        ImageInfo.xPixels = info.xPixel;
        ImageInfo.PixelPerNm = double(ImageInfo.xPixels)./ImageInfo.ScanSize;
        ImageInfo.LineSpeed = info.LineRate;
        ImageInfo.ScanSpeed = info.LineRate./double(info.yPixel);

        ImageInfo.n = info.numberofFrames;
        ImageInfo.Channel = info.channel;
        ImageInfo.Channels = info.channels;
        ImageInfo.time = 0;

        for  ii = 2:ImageInfo.n
            ImageInfo.time(ii) = (ii-1)/ImageInfo.ScanSpeed;
            ImageInfo.PixelPerNm(ii) = ImageInfo.PixelPerNm(1);
            ImageInfo.ScanSize(ii) = ImageInfo.ScanSize(1);
        end
        if contains(ImageInfo.Channel, {'Lock-In Amplitude', 'Deflection','Error'})
            im = im*1e9;
        end
        if contains(ImageInfo.Channel, 'Height')
            im(:,:,1) = level(im(:,:,1), 0, ImageInfo.ScanSpeed, 'log_y');
        end

    elseif strcmp(filetype,'nhf')
        Format = 'nhf';
        ImageInfo.n = 1;

        try
            [im, info] = open_NHF(imageName,channel);
        catch
            [im, info] = open_NHF(imageName,'Topography');
        end

        ImageInfo.ScanSize = double(info.ScanSize)./1e-9;
        ImageInfo.yPixels = double(info.yPixel);
        ImageInfo.xPixels = double(info.xPixel);
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = 1/double(info.frameAcqTime);
        ImageInfo.LineSpeed = double(info.yPixel).*ImageInfo.ScanSpeed;
        ImageInfo.Channel = info.channel;
        ImageInfo.Channels = info.channels;


        im = im.*1e9;
        ImageInfo.time =0;
    elseif strcmp(filetype,'gwy')
        Format = 'gwy';
        ImageInfo.n = 1;


        [img, info] = open_gwychannel(imageName);
        ImageInfo.ScanSize = double(info.xreal)./1e-9;
        ImageInfo.yPixels = double(info.yres);
        ImageInfo.xPixels = double(info.xres);
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = 0;
        ImageInfo.LineSpeed = 0;

        ImageInfo.Channels = (info.channels);

        searchCh = channel;
        ImageInfo.Channel = searchCh;
        rowNumber = strcmp(ImageInfo.Channels, searchCh);
        im = img{rowNumber};

        im = im.*1e9;
        ImageInfo.time =0;
    elseif ismember(filetype, validRGBExtensions)
        Format = 'RGB';
        ImageInfo.n = 1;

        im = imread(imageName);
        im = double(rgb2gray(im));
        info = imfinfo(imageName);
        ImageInfo.xPixels = info(1).Width;
        ImageInfo.yPixels  = info(1).Height;
        ImageInfo.LineSpeed = 0;
        ImageInfo.ScanSpeed = 0;
        ImageInfo.ScanSize = 0;
        ImageInfo.PixelPerNm = 0;
        ImageInfo.Channel = 'RGB';

        ImageInfo.time =0;
    elseif ismember(filetype, validTablesExtensions)
        Format = 'Table';
        ImageInfo.n = 1;

        T = readtable(imageName,'NumHeaderLines',0);
        im = table2array(T);
        ImageInfo.xPixels = size(im,1);
        ImageInfo.yPixels  = size(im,2);
        ImageInfo.LineSpeed = 0;
        ImageInfo.ScanSpeed = 0;
        ImageInfo.ScanSize = 0;
        ImageInfo.PixelPerNm = 0;
        ImageInfo.Channel = 'Table';

        ImageInfo.time =0;
    elseif strcmp(filetype,'jpk')
        Format = 'jpk';
        ImageInfo.n = 1;
        [info, Channels] = open_JPK_info(imageName);

        ImageInfo.Channels = strcat({Channels.Channel_name}', ' - ', {Channels.Trace_type}');
        searchCh = channel;
        ImageInfo.Channel = searchCh;
        if contains(ImageInfo.Channel, 'Directional')
            Bidir =1;
        else
            Bidir = 0;
        end

        rowNumber = strcmpi(ImageInfo.Channels, searchCh);
        temp = 1:numel(rowNumber);
        ch = temp(rowNumber);
        if ~any(ch)
            rowNumber = contains(ImageInfo.Channels, searchCh, 'IgnoreCase', true);
            temp = 1:numel(rowNumber);
            ch = temp(rowNumber);
            try
            ImageInfo.Channel =  ImageInfo.Channels{ch(1)};
            catch
                ch =1;
            end
        end
        im = zeros(info.y_scan_pixels,info.x_scan_pixels,1);
        [im(:,:,:),multi,offs] = open_JPK_image(imageName,ch(1)+1);

        ImageInfo.LineSpeed = info.Scan_Rate;
        ImageInfo.ScanSize = round(info.x_scan_length*1e9);
        ImageInfo.yPixels = info.y_scan_pixels;
        ImageInfo.xPixels = info.x_scan_pixels;
        ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
        ImageInfo.ScanSpeed = ImageInfo.LineSpeed./ImageInfo.yPixels.*(1.*(Bidir)+1);
        ImageInfo.time =  0;

        im = (flip(im)*multi)+offs;
        if contains(ImageInfo.Channel, {'Height', 'Lock-In Amplitude', 'Deflection'})
            im = im*1e9;
        end


    else
        fid = fopen(imageName,'r');
        line = fgets(fid);
        fclose(fid);
        if      length(strfind(line,'\*File list'))>=1
            Format = 'NanoScope';
            try
                [im, info] = open_nanoscope(imageName,channel,0);
            catch
                try
                    [im, info] = open_nanoscope(imageName,'Height',0);
                catch
                    [im, info] = open_nanoscope(imageName,'Height Sensor',0);
                end
            end
            ImageInfo.ScanSize = info.ScanSize;
            ImageInfo.xPixels = size(im,2);
            ImageInfo.yPixels = info.line_no;
            ImageInfo.PixelPerNm = ImageInfo.xPixels./ImageInfo.ScanSize;
            ImageInfo.ScanSpeed = 1/(info.line_no.*info.Scan_Rate);
            ImageInfo.LineSpeed = 1/info.Scan_Rate;
            ImageInfo.n = 1;
            ImageInfo.Channels = info.channels;
            ImageInfo.Channel = channel;

            ImageInfo.time =0;
        else
            Format = 'Unknown';
        end

    end
end

if strcmp(Format,'Unknown')
    im = [];
    ImageInfo.n = 0;
    rectangle(loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'red');
    text(loadbar, 0.5, 0.5, 'No images loaded', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
else
    im = single(im - mean(im(:),'omitnan'));
end
if useGUI
    progressBar.Position(3) = 1;
    progressText.String = 'Done!';
    drawnow;
end
end

function [dominantFormat, dominantFormatLocations] = checkfolder(folderPath)

expectedFileTypes = {'.ibw', '.jpk', '.nhf', '.gwy', 'NanoScope', '.spm'};
ignore = {'.jpeg', '.tiff', '.m', '.mat', '.h5', '.txt'};

fileList = dir(fullfile(folderPath, '*'));

% -------- Filter: ONLY real files (no directories at all) --------
isFile = ~[fileList.isdir];
files = fileList(isFile);  % <-- only files remain

fileFormatCount = containers.Map('KeyType', 'char', 'ValueType', 'double');
extensions = cell(1, numel(files));

% -------- FIRST PASS: detect formats --------
for i = 1:numel(files)

    fileName = files(i).name;
    filePath = fullfile(folderPath, fileName);

    [~, ~, ext] = fileparts(fileName);

    % Skip ignored extensions
    if ismember(ext, ignore)
        continue;
    end

    % Check for NanoScope (Bruker) files
    if ~ismember(ext, expectedFileTypes)
        fid = fopen(filePath, 'r');
        if fid ~= -1
            firstLine = fgets(fid);
            fclose(fid);
            if contains(firstLine, '\*File list')
                ext = '.spm';
            end
        end
    end

    extensions{i} = ext;

    if ismember(ext, expectedFileTypes)
        if isKey(fileFormatCount, ext)
            fileFormatCount(ext) = fileFormatCount(ext) + 1;
        else
            fileFormatCount(ext) = 1;
        end
    end
end

% -------- Determine dominant format --------
if isempty(fileFormatCount)
    dominantFormat = '';
    dominantFormatLocations = {};
    return;
end

valuesArray = cell2mat(values(fileFormatCount));
[~, idx] = max(valuesArray);
keyArray = keys(fileFormatCount);
dominantFormat = keyArray{idx};

% -------- SECOND PASS: collect files of dominant format --------
dominantFormatLocations = {};

for i = 1:numel(files)
    if strcmp(extensions{i}, dominantFormat)
        dominantFormatLocations{end+1} = fullfile(folderPath, files(i).name);
    end
end

end

