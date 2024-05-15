
% read_asd reads ASD files.
% ASD files contains the header and 12-bit HS-AFM images. 
% 
%   PARAMETERS
%
%       INPUT
%           fname - path and name of the .asd file; type - string
% 
%       OUTPUT
%           im - HS-AFM image or movie; type - double array
%           header - .asd header; type - matlab structure
%
% Written by Grigory Tagiltsev in Simon Scheuring's lab, Dec 2018
% Updated by G.R.Heath April 2024

function [im, header] = open_asd(fname)

asd_file = fopen(fname,'r', 'l');

header.fileVersion = fread(asd_file, 1,'int'); %File version
header.fileHeaderSize = fread(asd_file, 1,'int'); %Size of the file header
header.frameHeaderSize = fread(asd_file, 1, 'int'); %Size of the frame header
header.encNumber = fread(asd_file, 1, 'int'); %Charachteristic number for encoding
header.operationNameSize = fread(asd_file, 1, 'int'); %Size of the operation name
header.commentSize = fread(asd_file, 1, 'int'); %Size of the comment
header.dataTypeCh1 = fread(asd_file, 1, 'int'); %Data type of 1ch (Topography, Error or Phase) written by enum array
header.dataTypeCh2 = fread(asd_file, 1, 'int'); %Data type of 2ch (Topography, Error or Phase) written by enum array
header.numberFramesRecorded = fread(asd_file, 1, 'int'); %Number of frames when this asd file was originally recorded
header.numberFramesCurrent = fread(asd_file, 1, 'int'); %Number of frames contained in the current asd file
header.scanDirection = fread(asd_file, 1, 'int'); %Number showing scanning direction
header.fileName = fread(asd_file, 1, 'int'); %Name of the asd file
header.xPixel = fread(asd_file, 1, 'int'); %X pixel
header.yPixel = fread(asd_file, 1, 'int'); %Y pixel
header.xScanRange = fread(asd_file, 1, 'int'); %X scanning range in nm
header.yScanRange = fread(asd_file, 1, 'int'); %Y scanning range in nm
header.avgFlag = fread(asd_file, 1, 'bool'); %Flag of the averaging
header.avgNumber = fread(asd_file, 1, 'int'); %Number of data for the averaging
header.yearRec = fread(asd_file, 1, 'int'); %Year when this asd file was recorded
header.monthRec = fread(asd_file, 1, 'int'); % Month when this asd file was recorded
header.dayRec = fread(asd_file, 1, 'int'); %Day when this asd file was recorded
header.hourRec = fread(asd_file, 1, 'int'); %Hour when this asd file was recorded
header.minuteRec = fread(asd_file, 1, 'int'); %Minute when this asd file was recorded
header.secondRec = fread(asd_file, 1, 'int'); %Second when this asd file was recorded
header.xRoundDeg = fread(asd_file, 1, 'int'); % Degree of the rounding of x-scanning signal(%)
header.yRoundDeg = fread(asd_file, 1, 'int'); %Degree of the rounding of y-scanning signal(%)
header.frameAcqTime = fread(asd_file, 1, 'float'); %Frame acquisition time (ms)
header.sensorSens = fread(asd_file, 1, 'float'); %Sensor sensitivity (nm/V)
header.phaseSens = fread(asd_file, 1, 'float'); %Phase sensitivity (deg/V)
header.offset = fread(asd_file, 1, 'int', 12); %Offset
%reg12byte = fread(asd_file, 1, '12byte'); % Booked region of 12 byte\
header.machineNum = fread(asd_file, 1, 'int'); %Number of imaging machine
header.adRange = fread(asd_file, 1, 'int'); %Code showing AD range (AD_1V,AD2P5V, AD_5V of AD_80V)
header.adRes = fread(asd_file, 1, 'int'); %AD resolution (When this value is 12, the AD resolution is 4096(2^12))
header.xMaxScanRange = fread(asd_file, 1, 'float'); %X maximum scanning range (nm)
header.yMaxScanRange = fread(asd_file, 1, 'float'); %Y maximum scanning range (nm)
header.xExtCoef = fread(asd_file, 1, 'float'); %X piezo extention coefficient (nm/V)
header.yExtCoef = fread(asd_file, 1, 'float'); %Y piezo extention coefficient (nm/V)
header.zExtCoef = fread(asd_file, 1, 'float'); %Z piezo extention coefficient (nm/V)
header.zDriveGain = fread(asd_file, 1, 'float'); %Z piezo drive gain
header.operName = fread(asd_file, header.operationNameSize, '*char'); %Name of operator
header.comment = fread(asd_file, header.commentSize, '*char'); %Comment
header.AA = char(header.operName);
header.BB = char(header.comment);

%Make image sequence
preIm = zeros(header.yPixel, header.xPixel, header.numberFramesCurrent);
for k=1:header.numberFramesCurrent
    %Frame header structure
    header.frameNumber(k) = fread(asd_file, 1, 'int'); %Frame number
    header.frameMaxData(k) = fread(asd_file, 1, 'short'); %Maximum data in the frame
    header.frameMinData(k) = fread(asd_file, 1, 'short'); %Minimum data in the frame
    header.xOffset(k) = fread(asd_file, 1, 'short'); %X offset (nm)
    header.dataType(k) = fread(asd_file, 1, 'short'); %data type
     header.xTilt(k) = fread(asd_file, 1, 'float'); %X tilt
     header.yTilt(k) = fread(asd_file, 1, 'float'); %Y tilt
     header.flagLaserIr(k) = fread(asd_file, 1, 'bool', header.frameHeaderSize-21); %Flag laser radiation


    %Frame data order
    sub = fread(asd_file, header.xPixel*header.yPixel, 'short');
    preIm(:,:,k) = reshape(sub,[header.xPixel,header.yPixel]).'; % CHANGE HERE IF THE IMAGE HAS WRONG DIMENSIONS
end

im=-preIm/205.*header.zExtCoef;

im = flip(im);
fclose(asd_file);

end