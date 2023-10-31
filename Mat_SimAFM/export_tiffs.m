%A function to export tiff files in 32-bit format

function [outputFileName, folder] = export_tiffs(image_sequence)
[outputFileName,folder] = uiputfile('AFM_sim.tiff');
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
        tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
        tagstruct.Software        = 'MATLAB';
        t.setTag(tagstruct)
        t.write(data);
        t.close();
    end
end
end
end