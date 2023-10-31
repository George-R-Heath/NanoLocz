
[im, s] =  open_park_1('230621_086_Z Height_Forward.tiff');

function [im, s] = open_park_1(afm_file)
im= imread(afm_file);
info = imfinfo(afm_file);
parameters=info.UnknownTags(4,1).Value;
s.scale=typecast(uint8(parameters(141:148)),'double');
s.frameAcqTime = typecast(uint8(parameters(173:180)),'double')*size(im,1);
dfDataGain=typecast(uint8(parameters(221:228)),'double');
im=-dfDataGain*double(im);
end

