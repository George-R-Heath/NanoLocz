
function [img, s] = open_nanoscope(fname,bi)
pft=1;
%This code is modified from:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This work by EPFL STI IBI LBNI is licensed under
% a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
% Based on a work at http://lbni.epfl.ch/.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_name    = fname;                   % Generates the filname to open for this particular iteration
%
% if strcmp(remain,'.jpg') || strcmp(remain,'.jpeg') || strcmp(remain,'.tif') || strcmp(remain,'.tiff') || strcmp(remain,'.png')
%     ImageType = 'Image';
% else
%     fid = fopen(file_name,'r');
%     line = fgets(fid);
%     fclose(fid);
%     if      length(strfind(line,'\*File list'))>=1
%         ImageType = 'Nanoscope';
%     else
%         ImageType = 'Unknown';
%     end
% end


% Read in DI Image and image propreties  This code is mostly from Jaco De Groot at University College London
searchstring(1).label='@2:Z scale:';
searchstring(2).label='Samps';
searchstring(3).label='Lines:';
searchstring(4).label='Data offset';
searchstring(5).label='Image Data:';
searchstring(6).label='\Scan Size:';
searchstring(7).label='@Sens. Zsens:';
searchstring(8).label='@Z magnify:';

searchstring(9).label='Scan Rate:';
searchstring(10).label='@Sens. DeflSens: V';
searchstring(11).label='@2:CantFrequency: V';
searchstring(12).label='@2:CantDrive: V';
searchstring(13).label='@2:TMSetAmplitude: V';
searchstring(14).label='@Sens. ZsensSens: V';
searchstring(15).label='@Sens. Amplitude Error: V';
searchstring(16).label='@Sens. Amplitude: V';
searchstring(17).label='@Sens. ForceDeflSens: V';
searchstring(18).label='Aspect Ratio:';
searchstring(19).label='Capture direction:';


fid = fopen(file_name,'r');
[message,errnum] = ferror(fid);
if(errnum)
    fprintf(1,'I/O Error %d \t %s',[errnum,message]);
end
header_end=0; eof = 0; counter = 1; byte_location = 0;
nstrings=size(searchstring,2);
parcounter = ones(nstrings,1);
paramters = struct('trace',cell(1,nstrings),'values',cell(1,nstrings),'channel',cell(1,nstrings));

for ij=1:nstrings
    parcounter(ij)=1;
    parameters(ij).trace=0;
end

while( and( ~eof, ~header_end ) )

    byte_location = ftell(fid);
    line = regexprep(fgets(fid),'Zscan','Zsens');

    for ij=1:nstrings
        if strfind(lower(line),lower(searchstring(ij).label))
            if (extract_num(line))
                b = strfind(line, 'LSB');
                if (b>0)
                    parameters(ij).values(parcounter(ij))=extract_num(line(b(1):end));
                else
                    parameters(ij).values(parcounter(ij))=extract_num(line);
                end


            elseif strcmp(searchstring(ij).label,'Aspect Ratio:')
                b= strfind(line,':');
                parameters(ij).values(parcounter(ij))=extract_num(line(b(1):b(2)-1));

            elseif strcmp(searchstring(ij).label,'Capture direction:')
                b= strfind(line,':');
                parameters(ij).values(parcounter(ij)) = strcmp(line(b(1)+2),'D');

            else
                b= strfind(line,'"');
                if (b>0)
                    parameters(ij).channel(parcounter(ij)).name=line(b(1)+1:b(2)-1);
                else
                    if (strfind(line,'Trace')>0)
                        parameters(ij).trace=1;
                    end
                end
            end
            parcounter(ij)=parcounter(ij)+1;
        end
    end

    if( (-1)==line )
        eof  = 1;
    end

    if ~isempty( strfind( line, '\*File list end' ) )
        header_end = 1;
    end

    counter=counter+1;
end

fclose(fid);

fid = fopen(file_name,'r');
C = textscan(fid, '%s', 3,'delimiter','\n');
fclose(fid);
C = C{1};
C = char(C(3));
Time = C(8:end);

param           = parameters;
scaling         = param(1).values;                % Scaling parameters
spl             = param(2).values(1);             % Samples per line
s.line_no           = param(3).values(1);             % No of lines
image_pos       = param(4).values;
% Data position
if param(6).values(1) <= 100
    s.ScanSize    = param(6).values(2);
else
    s.ScanSize    = param(6).values(1);
end
s.Z_Sensitivity   = param(7).values;
s.Z_Magnification = param(8).values;

s.Scan_Rate   = param(9).values(1);

s.Defl_Sens       = param(10).values;
s.Drive_Freq      = param(11).values;
s.Drive_Amp       = param(12).values;
s.Amp_Set_Point   = param(13).values;
s.Z_sensor_sens   = param(14).values;
s.Amp_sens        = max([param(15).values,param(16).values]);
if s.Amp_sens == 1
    s.Amp_sens = 1000*s.Amp_sens;
end
s.SpringConst     = param(17).values;
s.AspectRatio     = param(18).values;
s.Direction       = param(19).values;
[tok, remain]    = strtok(fname,'.');
file_number     = str2double(remain(2:4));

L = length(image_pos);                                                                                                       % Sets the number of image channels
channel_info = struct('Trace',cell(L,1),'Name',cell(L,1),'Finalscaling',cell(L,1),'Unit',cell(L,1));
finalscaling = zeros(L,1);
for im=1:L                                                                                                                  % Loops for the number of channels
    channel_info(im).Trace = char((param(6).trace)*'Trace  '+(1-param(6).trace)*'Retrace');                                   % Determines if Channel is Trace or Retrace
    channel_info(im).Name = param(5).channel(im).name;                                                                        % Name of channel 1
    channel_info(im).Finalscaling(im) = param(8).values(im)*param(1).values(im);                                              % Computes some of the scaling paramters

    switch channel_info(im).Name                                                                                            % Sets Units according to recorded channel
        case 'Height'                                                                                                      % If height...
            channel_info(im).Unit='nm' ;                                                                                    % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                     % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);                                                           % Sets bit scaling

        case 'Height Sensor'                                                                                                                                                              % If height...
            channel_info(im).Unit='nm' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(8).values(im)*param(1).values(im);                                                                                             % Sets final scaling value
            finalscaling(im)=(scaling(im))*s.Z_sensor_sens/(2^16);

        case 'Deflection'                                                                                                                                                          % If Deflection...
            if s.Defl_Sens == 1
                channel_info(im).Unit='V';
            else
                channel_info(im).Unit='nm';                                                                                                                                             % Units are V
            end
            finalscaling(im)=(scaling(im))*s.Defl_Sens/(2^16);                                                                                                                                  % Sets bit scaling

        case 'Deflection Error'                                                                                                                                                          % If Deflection...
            if s.Defl_Sens == 1
                channel_info(im).Unit='V';
            else
                channel_info(im).Unit='nm';                                                                                                                                             % Units are V
            end
            finalscaling(im)=(scaling(im))*s.Defl_Sens/(2^16);                                                                                                                                  % Sets bit scaling

        case 'Phase'                                                                                                                                                               % If Phase...
            channel_info(im).Unit='Degree';                                                                                                                                        % Units are degrees
            finalscaling(im)=(scaling(im))/(2^16);                                                                                                                                 % Sets bit scaling

        case 'Amplitude'                                                                                                                                                           % If Potential...
            if s.Amp_sens == 1000
                channel_info(im).Unit='mV';
                s.Amp_sens = s.Amp_sens/1000;
            else
                channel_info(im).Unit='nm';                                                                                                                                             % Units are V
                s.Amp_sens = s.Amp_sens/1000;
            end
            channel_info(im).Finalscaling(im)=param(8).values(im)*param(1).values(im);                                                                                             % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Amp_sens)/(2^16);

        case 'Amplitude Error'                                                                                                                                                           % If Potential...
            if s.Amp_sens == 1000
                channel_info(im).Unit='mV';
                s.Amp_sens = s.Amp_sens/1000;
            else
                channel_info(im).Unit='nm';
                s.Amp_sens = s.Amp_sens/1000;
            end                                                                                                                                            % Units are V
            channel_info(im).Finalscaling(im)=param(8).values(im)*param(1).values(im);                                                                                             % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Amp_sens)/(2^16);

        case 'Potential'                                                                                                                                                           % If Potential...
            channel_info(im).Unit='V';                                                                                                                                             % Units are V
            channel_info(im).Finalscaling(im)=param(8).values(im)*param(1).values(im);                                                                                             % Sets final scaling value
            finalscaling(im)=(scaling(im))/(2^16);                                                                                                                                 % Sets bit scaling

        case 'Peak Force Error'                                                                                                                                                              % If height...
            channel_info(im).Unit='nN' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);
            pft = 2;

        case 'DMTModulus'                                                                                                                                                              % If height...
            channel_info(im).Unit='MPa' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);

        case 'LogDMTModulus'                                                                                                                                                              % If height...
            channel_info(im).Unit='log(MPa)' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);

        case 'Adhesion'                                                                                                                                                              % If height...
            channel_info(im).Unit='nN  ' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);

        case 'Deformation'                                                                                                                                                              % If height...
            channel_info(im).Unit='nm' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);

        case 'Dissipation'                                                                                                                                                              % If height...
            channel_info(im).Unit='eV' ;                                                                                                                                            % Units are nm
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);                                                                              % Sets final scaling value
            finalscaling(im)=(scaling(im)*s.Z_Sensitivity)/(2^16);

            %                 case 'Input1'                                                                                                                                                              % If height...
            %                    channel_info(im).Unit='nm' ;                                                                                                                                            % Units are nm
            %                    channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);
            %                    finalscaling(im)=(scaling(im)*Z_Sensitivity*Defl_Sens)/(2^16);
            %
        case 'Input2'
            channel_info(im).Unit='nm' ;
            channel_info(im).Finalscaling(im)=param(7).values*param(8).values(im)*param(1).values(im);
            finalscaling(im)=-1*(scaling(im)*s.Z_Sensitivity*1000)/(2^16);


        otherwise
            channel_info(im).Unit='V';
            channel_info(im).Finalscaling(im)=param(8).values(im)*param(1).values(im);
            finalscaling(im)=(scaling(im))/(2^16);

    end

end



    fid = fopen(file_name,'r');
    images = zeros(s.line_no, spl);
    for i = 1  % change this for other channels 
        fseek(fid,image_pos(i),-1);
        A  = fread(fid, [spl s.line_no],'int16');
        images   = rot90(finalscaling(i)*A);
        [~, fre] = mode(images(:));
            img = images;
        if fre > 2000|| pft ==2
            img=[];
            fid = fopen(file_name,'r');
            images = zeros(s.line_no, 2*spl);
                fseek(fid,image_pos(i),-1);
                A   = fread(fid, [2*spl s.line_no],'int16');
                images   = rot90(finalscaling(i)*A);
                images   = images-median(reshape(images,size(images,1)*size(images,2),1));
            img = images(:,pft:2:end);
            if std(img(:))>1000 || std(img(:))< 0.01
                img = images(:,pft+1:2:end);
            end
        end

    end


% else
%     fid = fopen(file_name,'r');
%     images = zeros(s.line_no, 2*spl);
%     for i = 1
%     
%         fseek(fid,image_pos(i),-1);
%         A   = fread(fid, [2*spl s.line_no],'int16');
%         images   = rot90(finalscaling(i)*A);
%        % images   = images-median(reshape(images,size(images,1)*size(images,2),1));
%     end
%     img = images(:,pft:2:end);
% 
% end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code has been adapted from the ALEX toolbox and incorporated into this m-file.
% The original free source code, which is copywritten by Claudio Rivetti and Mark Young
% for ALEX is available at www.mathtools.net.
%
%This function/script is authorized for use in government and academic
%research laboratories and non-profit institutions only. Though this
%function has been tested prior to its posting, it may contain mistakes or
%require improvements. In exchange for use of this free product, we
%request that its use and any issues relating to it be reported to us.
%Comments and suggestions are therefore welcome and should be sent to
%Prof. Robert Carpick <carpick@engr.wisc.edu>, Engineering Physics
%Department, UW-Madison.
%Date posted: 7/8/2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function val = extract_num(str)
eos = 0;
R = str;

while(~eos)

    [T,R] = strtok(str);
    if( length(R) == 0) eos = 1; end
    I = find( (T>=48) & (T<=57) | 101==T | 69==T | T==173 | T== 45 | T==46 | T==40);

    LT = length(T);
    LI = length(I);

    if( LI == LT )
        J = find(T~='(');
        val = str2num(T(J));
        break
    end
    str =R;
end
end