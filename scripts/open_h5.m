
% Open NanoLocz data in HDF5 file format

function Data = open_h5(f)
% f = filepath or filename
fileID = H5F.open(f, 'H5F_ACC_RDONLY', 'H5P_DEFAULT');
info = h5info(f);
Data = struct();

for i = 1:numel(info.Datasets)
    datasetName = ['/' info.Datasets(i).Name];
    data = h5read(f, datasetName);
    Data.(info.Datasets(i).Name) = data;
end

for i = 1:numel(info.Groups)
    for j = 1:numel(info.Groups(i).Datasets)
        datasetName = ['/' info.Groups(i).Datasets(j).Name];
        data = h5read(f, [info.Groups(i).Name datasetName]);
        G = info.Groups(i).Name; % G = variable Group name 
        G = G(2:end);
        Data.(G).(info.Groups(i).Datasets(j).Name) = data;
    end
end
H5F.close(fileID);
end
