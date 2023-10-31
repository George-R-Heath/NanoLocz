%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         

function [outputFileName, folder] = tiff_exporter(image_sequence,suggestname,PixPer_nm)
[outputFileName,folder] = uiputfile([suggestname,'.tiff']);
if any(outputFileName)
data = single(image_sequence(:,:,1));
fullFileName = fullfile(folder, outputFileName);
t = Tiff(fullFileName,'w');
setTag(t,'Photometric',Tiff.Photometric.MinIsBlack);
setTag(t,'Compression',Tiff.Compression.None);
setTag(t,'SampleFormat',Tiff.SampleFormat.IEEEFP);
tagstruct.ImageLength     = size(data,1);
tagstruct.ImageWidth      = size(data,2);
tagstruct.BitsPerSample   = 32;
tagstruct.SamplesPerPixel = 1;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
if nargin>2
    tagstruct.XResolution = PixPer_nm;
    tagstruct.YResolution = PixPer_nm;
end
tagstruct.Software        = 'MATLAB';
t.setTag(tagstruct)
t.write(data);
t.close();
if size(image_sequence,3)>1
    for i = 2:numel(image_sequence(1,1,:))
        data = single(image_sequence(:,:,i));
        t = Tiff(fullFileName,'a');
        setTag(t,'Photometric',Tiff.Photometric.MinIsBlack);
        setTag(t,'Compression',Tiff.Compression.None);
        setTag(t,'SampleFormat',Tiff.SampleFormat.IEEEFP);
        tagstruct.ImageLength     = size(data,1);
        tagstruct.ImageWidth      = size(data,2);
        tagstruct.BitsPerSample   = 32;
        tagstruct.SamplesPerPixel = 1;
        if nargin>2
            tagstruct.XResolution = PixPer_nm;
            tagstruct.YResolution = PixPer_nm;
        end
        tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
        tagstruct.Software        = 'MATLAB';
        t.setTag(tagstruct)
        t.write(data);
        t.close();
    end
end
end
end