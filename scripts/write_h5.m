
% Write NanoLocz data to HDF5 file

function write_h5(filepath,Data)
fields = fieldnames(Data);
dataCell = struct2cell(Data);

for i = 1:numel(fields)
    fieldData = dataCell{i};
    
    if ischar(fieldData)
        fieldData = string(fieldData); 
    end

    if isstruct(fieldData)
        fieldNames = fieldnames(fieldData);
        fieldDataCell = struct2cell(fieldData);
        for j = 1:numel(fieldNames)
            subFieldData = fieldDataCell{j};
            
            if ischar(subFieldData)
                subFieldData = string(subFieldData);
            end
            if iscell(subFieldData)
                subFieldData = string(subFieldData);
            end
            if islogical(subFieldData)
                subFieldData = uint8(subFieldData);
            end
            try
                h5create(filepath, ['/' fields{i} '/' fieldNames{j}], size(subFieldData), 'Datatype', class(subFieldData));
            catch
            end
            try
                h5write(filepath, ['/' fields{i} '/' fieldNames{j}], subFieldData);
            catch
            end
        end
    else
        try
            h5create(filepath, ['/' fields{i}], size(fieldData), 'Datatype', class(fieldData));
        catch
        end
        try
            h5write(filepath, ['/' fields{i}], fieldData);
        catch
        end
    end
end
