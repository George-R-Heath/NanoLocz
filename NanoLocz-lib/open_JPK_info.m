% Modified version of: open_JPK.m
% 
% Ortuso, Roberto D., Kaori Sugihara.
% "Detailed Study on the Failure of the Wedge Calibration Method at Nanonewton Setpoints for Friction Force Microscopy." The Journal of Physical Chemistry C 122.21 (2018): 11464-11474.
% Author: Dr. Ortuso, R.D.
% Adolph Merkle Institute, Fribourg, CH.
% Contact: roberto.ortuso@unifr.ch 

function [info, Channels] = open_JPK_info(afm_file)
file_info=imfinfo(afm_file);

i=1;
if(~isempty(find([file_info(i).UnknownTags.ID]==32832, 1)))
    x_Origin=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32832).Value);
else
    x_Origin=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==32833, 1)))
    y_Origin=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32833).Value);
else
    y_Origin=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==32834, 1)))
    x_scan_length=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32834).Value);
else
    x_scan_length=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==32835, 1)))
    y_scan_length=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32835).Value);
else
    y_scan_length=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==32838, 1)))
    x_scan_pixels=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32838).Value);
else
    x_scan_pixels=nan;
end


if(~isempty(find([file_info(i).UnknownTags.ID]==32839, 1)))
    y_scan_pixels=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32839).Value);
else
    y_scan_pixels=nan;
end


if(~isempty(find([file_info(i).UnknownTags.ID]==32821, 1)))
    Reference_Amplitude=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32821).Value);
else
    Reference_Amplitude=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==33028, 1)))
    Set_Amplitude=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32822).Value);
else
    Set_Amplitude=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==33028, 1)))
    Oscillation_Freq=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32823).Value);
else
    Oscillation_Freq=nan;
end

if(~isempty(find([file_info(i).UnknownTags.ID]==33028, 1)))
    Scan_Rate=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32841).Value);
else
    Scan_Rate=nan;
end

info=struct(...
    'x_Origin', x_Origin,...
    'y_Origin', y_Origin,...
    'x_scan_length', x_scan_length,...
    'y_scan_length', y_scan_length,...
    'x_scan_pixels', x_scan_pixels,...
    'y_scan_pixels', y_scan_pixels,...
    'Reference_Amp', Reference_Amplitude,...
    'Set_Amplitude', Set_Amplitude,...
    'Oscillation_Freq', Oscillation_Freq,...
    'Scan_Rate', Scan_Rate);
%'Vertical_Sn', Vertical_Sn,...
%'Vertical_kn', Vertical_kn);

for i = 2:numel(file_info)
    Channel_Name=(file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32850).Value);
    strsp=(strsplit((file_info(i).UnknownTags([file_info(i).UnknownTags.ID]==32851).Value)))';
    for k=1:size(strsp,1)
        if(strcmp(strsp{k,1},'retrace')==1)
            if(strcmp(strsp{k+2,1},'true'))
                if strcmp(strsp{k-1,1},'Smooth')
                    trace_type_flag='Bi-Directional Raw';
                else
                    trace_type_flag='ReTrace';
                end
            else
                if strcmp(strsp{k-1,1},'Smooth')
                    trace_type_flag='Bi-Directional Smooth';
                else
                    trace_type_flag='Trace';
                end
            end
            
            break
         
        end
    end
    Channels(i-1)=struct(...
        'Channel_name',...
        Channel_Name,...
        'Trace_type',...
        trace_type_flag);
end


end
