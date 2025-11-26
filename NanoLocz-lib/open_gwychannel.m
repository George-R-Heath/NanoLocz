% Modified version of:

% Copyright © 2011, Lennart Fricke
%
% E-Mail: lennart.fricke@kabelmail.de
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the BSD 2-Clause License.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% BSD 2-Clause License for more details.
% 
% You should have received a copy of the BSD 2-Clause License
% along with this program.

function [im, meta] = open_gwychannel(filename)

 fid = fopen(filename);
  c = transpose(fread(fid,4,'*char'));
  if ~strcmp(c,'GWYP')
      return
  end
  t = readobj(fid);
  if ~strcmp(t,'GwyContainer')
      return;
  end
 

    counter =0;
    while ~feof(fid)
        try
         [n,t,~] = readcomponent(fid);
        if t == 'o'
            [t, ~] = readobj(fid);
            if strcmp(t, 'GwyDataField') && endsWith(n, '/data')
                % Extract the channel number from the channel name
                counter= counter+1;
                chno(counter) = sscanf(n, '/%u/data');
            end
        end
        catch
        end
        
    end


for i = 1:numel(chno)
    channel{i} = 0;
    title = 0;
    cname = sprintf('/%u/data', chno(i));
    fseek(fid, 0, 'bof');  % Move to the beginning of the file
    c = transpose(fread(fid, 4, '*char'));
    t = readobj(fid);
    [n, t, ret] = readcomponent(fid);

    while ~feof(fid)
        if t == 'o'
            [~, s] = readobj(fid);
            if ~strcmp(n, cname)
                fseek(fid, s, 'cof');
            else
                channel{i} = readdatafield(fid, s);
                if ischar(title)
                    channel_type{i} = title;
                end
            end
        elseif t == 's' && strcmp(n, [cname, '/title'])
            title = ret;
            if isstruct(channel{i})
                channel_type{i} = title;    
            end
        end
        [n, t, ret] = readcomponent(fid);
    end

    im{i} = channel{i}.data;
    
end
meta =  rmfield(channel{1}, 'data');
meta.channels =   cellfun(@(x) x{1}, channel_type, 'UniformOutput', false);
fclose(fid);

 end
 

function rfield = readdatafield(fid, size)
    p = ftell(fid);
    while ftell(fid) < size + p
        [n, t, r] = readcomponent(fid);
        if t ~= 'o'
            rfield.(n) = r;
        else
            [~, s] = readobj(fid);
            fseek(fid, s, 'cof');
        end
    end

    rfield.data = transpose(reshape(rfield.data, rfield.xres, rfield.yres));
end

function [s] = readstr(fid)
    s = blanks(100);
    c = fread(fid, 1, '*char');
    count = 1;
    
    while ~feof(fid) && c ~= 0 && count < 100
        s(count) = c;
        c = fread(fid, 1, '*char');
        count = count + 1;
    end
    
    if count > 1
        s = s(1:count-1);
    else
        s = 0;
    end
end

function [type, size] = readobj(fid)
    type = readstr(fid);
    size = fread(fid, 1, 'uint32', 'l');
end

function [name, type, ret] = readcomponent(fid)
    name = readstr(fid);
    type = fread(fid, 1, '*char');
    
    if feof(fid)
        ret = 0;
        return
    end
    
    switch lower(type)
        case 'b'
            r = '*uint8';
        case 'c'
            r = '*char';
        case 'i'
            r = '*int32';
        case 'q'
            r = '*int64';
        case 'd'
            r = '*double';
        case {'s', 'o'}
            r = 0;
    end
    
    if isstrprop(type, 'upper')
        rep = fread(fid, 1, 'uint32', 'l');
    else
        rep = 1;
    end
    
    if r ~= 0
        ret = fread(fid, rep, r, 'l');
    elseif lower(type) == 's'
        ret = cell(rep, 1);
        
        for i = 1:rep
            ret{i} = readstr(fid);
        end
    else
        ret = 0;
    end
    
    type = lower(type);
end

function fieldName = createValidFieldName(name)
    name = regexprep(name, '[^a-zA-Z0-9_]', '_');
    if isstrprop(name(1), 'digit')
        name = ['x' name];
    end
    
    fieldName = name;
end
