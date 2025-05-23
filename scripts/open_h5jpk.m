function [im, s ] = open_h5jpk(f, ch)
info = h5info(f);
n_ch = numel(info.Groups.Groups)-1;
for i = 1:n_ch
    attrs = info.Groups.Groups(i).Attributes;
    names = {attrs.Name};
    fancy_idx = strcmp(names, 'channel.fancy-name');
    fancyName = attrs(fancy_idx).Value;
    type_idx = strcmp(names, 'retrace');
    channelType = attrs(type_idx).Value;

    if strcmp(channelType, 'true')
        s.channels{i} = [fancyName, '-retrace'];
    else
        s.channels{i} = [fancyName, '-trace'];
    end
end
attrs = info.Groups.Attributes;
names = {attrs.Name};

idx = strcmp(names, 'timing-settings.scanRate');
s.LineRate = attrs(idx).Value;
idx = strcmp(names, 'position-pattern.grid.ilength');
s.xPixel = attrs(idx).Value;
idx = strcmp(names, 'position-pattern.grid.jlength');
s.yPixel = attrs(idx).Value;
idx = strcmp(names, 'position-pattern.grid.ulength');
s.xsize = attrs(idx).Value;
idx = strcmp(names, 'position-pattern.grid.vlength');
s.ysize = attrs(idx).Value;


found_ch = find(strcmp(s.channels, ch));

if  any(found_ch)
    s.channel = ch;
else
    s.channel = 'Height-trace';
    ch = 'Height-retrace';
end

id_ch = find(strcmp(s.channels, ch));
attrs = info.Groups.Groups(id_ch).Attributes;
names = {attrs.Name};
idx = strcmp(names, 'net-encoder.scaling.offset');
offs = attrs(idx).Value;
idx = strcmp(names, 'net-encoder.scaling.multiplier');
multi = attrs(idx).Value;

image_group = info.Groups.Groups(id_ch);
dataset_name = image_group.Datasets(1).Name;
full_path = [image_group.Name '/' dataset_name];
img_data = h5read(f, full_path);

s.numberofFrames = size(img_data, 1)-1;
im = zeros(s.xPixel, s.yPixel, s.numberofFrames);

for i = 1:s.numberofFrames
    im(:, :, i) = reshape(img_data(i, :), [s.xPixel, s.yPixel])';
end

 im = (flip(im)*multi)+offs;
 switch s.channel
    case {'Height-retrace','Height-trace'}
       im = im*1e9;
    otherwise
end
end