%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         


function [im, s ] = open_ARIS(f)

info = h5info(f);
datainfo = (h5info(f,'/DataSetInfo'));
Framename = {info.Groups(1).Groups.Groups.Name};
newStr = extractAfter(Framename,"Frame ");
X = str2double(newStr);
[I, M] = sort(X);
list = info.Groups(2).Groups(2).Groups(2).Groups(8).Attributes;
fr = info.Groups(2).Groups(1).Groups(2).Groups(2).Groups.Attributes;
s.ScanSize =  fr(4).Value;
s.yPixel = list(strcmpi({list.Name}, 'ScanLines')).Value;
s.xPixel = list(strcmpi({list.Name}, 'ScanPoints')).Value;
s.frameAcqTime = list(strcmpi({list.Name}, 'TimePerFrame')).Value;
s.numberofFrames = numel(M);

%Load Images
for i = 1:numel(M)
    loc = info.Groups(1).Groups.Groups(M(i)).Groups(3).Name; %Group 3 =Height Trace
    loc = insertAfter(loc,"Trace","/Image");
    im(:,:,i) =h5read(f,loc)';
   
end
im(isnan(im))=0;
end
