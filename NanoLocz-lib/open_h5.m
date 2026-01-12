% Function part of NanoLocz GUI and NanoLocz-lib (2025).
% open_h5 - Open and read NanoLocz data stored in HDF5 (.h5) file format.
%
%   This function reads all datasets and group datasets from an HDF5 file 
%   (such as those produced by NanoLocz) and returns the contents as a structured 
%   MATLAB variable.
%
%   Inputs:
%       f - Full file path or filename of the HDF5 (.h5) file.
%
%   Outputs:
%       Data - A MATLAB structure containing all datasets in the HDF5 file. 
%              Top-level datasets are stored as fields of Data.
%              Group datasets are stored as nested fields: Data.GroupName.DatasetName
%
%   Notes:
%   - The function reads both top-level datasets and datasets within groups.
%   - Group names are used as structure fields, with any leading '/' removed.
%   - Uses built-in MATLAB functions: h5info, h5read, H5F.open, H5F.close.
%
%   Example:
%       Data = open_h5('example_data.h5');

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
