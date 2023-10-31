
%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   31.10.2023        


function [im, s ] = open_NHF(f,ch)
% INPUTS:
% f = filename 
% ch = channel number (1,2,3...)
% Trace = 0 for Trace, 1 for Retrace  
trace = 0;
% OUTPUTS:
% im = image data matrix
% s = struct containing scan/channel info

%scan attributes:
info = h5info(f);
fr = info.Groups.Attributes;
s.ScanSize = fr(strcmpi({fr.Name}, 'image_size_x')).Value;
s.xPixel = fr(strcmpi({fr.Name}, 'image_points_per_line')).Value;
try
s.yPixel = fr(strcmpi({fr.Name}, 'image_number_of_lines')).Value;
catch
    s.yPixel = fr(strcmpi({fr.Name}, 'image_number_of_lines_aquired')).Value;
end
s.linerate = fr(strcmpi({fr.Name}, 'image_line_rate')).Value;
s.frameAcqTime = s.yPixel./s.linerate;

channel_data = struct2table(info.Groups.Groups(1).Datasets);
sz = (channel_data.ChunkSize);
pos = 0;
for i = 1:numel(sz)
    if sz(i) ==sz(1)
        pos = pos+1;
        channel_type{pos} =  channel_data.Attributes{i,1}(3).Value;
        if  strcmp(ch,channel_type{pos})
            d = channel_data.Name(i);
            dataset = d{1,1};
        end
    end
end
s.channels = channel_type';
%load image:
groupName = ['/measurement_0/segment_',num2str(trace)];
imageData = h5read(f, [groupName '/' dataset]);
im = reshape(imageData, s.xPixel, s.yPixel)';

%image attributes:
s.channel = h5readatt(f, [groupName '/' dataset], 'name');
cali_min = h5readatt(f, [groupName '/' dataset], 'base_calibration_min');
cali_max = h5readatt(f, [groupName '/' dataset], 'base_calibration_max');
s.channel_units = h5readatt(f, [groupName '/' dataset], 'base_calibration_unit');
Bit = 2^31;
cali_factor =  (cali_max - cali_min)/(double(Bit*2));

im = (double(im)+ Bit)*cali_factor + cali_min;
im = flip(im,1);
end
