%%  Function written for NanoLocz GUI and NanoLocz-lib (2025) 

% tiff_exporter - Export a sequence of images as a multi-page TIFF file
%
% DESCRIPTION:
%   Saves a 2D or 3D image sequence to a TIFF file, supporting multi-frame TIFFs.
%   Image data is stored as single precision floating point (32-bit).
%   Optionally sets image resolution tags based on pixels per nanometer.
%
% INPUTS:
%   image_sequence - 2D (single image) or 3D (stack) numeric array of images
%   fullFileName   - String with full path and filename for output TIFF
%   PixPer_nm      - (Optional) Resolution in pixels per nanometer (sets X/YResolution tags)
%
% OUTPUT:
%   Creates a TIFF file at the specified location with the image sequence saved.
%

function tiff_exporter(image_sequence,fullFileName,PixPer_nm)

data = single(image_sequence(:,:,1));
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
