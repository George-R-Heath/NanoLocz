%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023   
%  Updated for multichannel and varying ScanSize: 15.09.2023


function [im, s ] = open_ARIS(f,ch)

info = h5info(f);
datainfo = (h5info(f,'/DataSetInfo'));
Framename = {info.Groups(1).Groups.Groups.Name};
newStr = extractAfter(Framename,"Frame ");
X = str2double(newStr);
[~, M] = sort(X);
list = info.Groups(2).Groups(2).Groups(2).Groups(8).Attributes;

found_ch=0;
ch_info = h5info(f, '/DataSetInfo/Global/Channels');
for i = 1:numel(ch_info.Groups)
    temp = ch_info.Groups(i).Name;
    s.channels{i} = extractAfter(temp,"Channels/");
    if  strcmp(ch, s.channels{i})
        found_ch = 1;
    end
end

if  found_ch == 0
    s.channel = 'HeightTrace';
    ch = 'HeightTrace';
else
     s.channel = ch;
end

scale0 = max(h5readatt(f,'/DataSetInfo/Global/Channels/HeightTrace/ImageDims','DimScaling'),[],'all');
%s.units = h5readatt(f,'/DataSetInfo/Global/Channels/HeightTrace/ImageDims','DataUnits');

scan_size_list = info.Groups(2).Groups(1).Groups;
for i = 1:numel(scan_size_list)
    if i ==1
    else
        if numel(scan_size_list(i).Groups)>1
            temp = scan_size_list(i).Name;
            scan_size_frame(i) = str2double(extractAfter(temp,"Frame "));
            temp = scan_size_list(i).Groups(2).Groups.Attributes;
            ScanSize(i) = temp(strcmpi({temp.Name}, 'ScanSize')).Value;
        end
    end
end
try
scan_size_frame = scan_size_frame(scan_size_frame ~= 0);
ScanSize = ScanSize(ScanSize ~= 0);
[Scale_sortV,Scale_sortID ] = sort(scan_size_frame);
catch
    Scale_sortV =[];
   Scale_sortID =[];
end
for i = 1:numel(X)
    if i==1
        s.scale(i) = scale0;
    else
        if any(Scale_sortV)
            
            if i<Scale_sortV(1)
                s.scale(i) = s.scale(i-1);
            else
                s.scale(i) = ScanSize(Scale_sortID(1));
                Scale_sortV(1) = [];
                Scale_sortID(1) = [];
            end
        else
             s.scale(i) = s.scale(i-1);
        end
          
    end
end
   
s.yPixel = list(strcmpi({list.Name}, 'ScanLines')).Value;
s.xPixel = list(strcmpi({list.Name}, 'ScanPoints')).Value;
s.frameAcqTime = list(strcmpi({list.Name}, 'TimePerFrame')).Value;
s.numberofFrames = numel(M);

%Load Images
for i = 1:numel(M)
    img_loc = info.Groups(1).Groups.Groups(M(i)).Name;
    im(:,:,i) = h5read(f, [img_loc '/' ch,'/Image'])';
end
im(isnan(im))=0;
end
