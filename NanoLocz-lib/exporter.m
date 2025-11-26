%  EXPORTER function - NanoLocz-lib (2025)
%  Exports data to various file formats (.mat, .h5, .tiff, .txt, .xlsx, .csv).
%
% This function saves numerical or tabular data to disk in a variety of formats.
% It supports exporting matrices, tables, and multi-slice image stacks.
%
% Usage:
%   exporter(Data)                              % Prompts for file path, saves as .mat
%   exporter(Data, format)                      % Saves using specified format
%   exporter(Data, format, filepath)            % Saves to specified path
%   exporter(Data, format, filepath, table)     % Optionally treat Data as a table for text-based formats
%
% Inputs:
%   Data     - The data to export (matrix, 3D array, or table)
%   format   - (Optional) File extension (e.g., '.mat', '.h5', '.tiff', '.txt', '.xlsx', '.csv')
%              Default is '.mat' if not provided.
%   filepath - (Optional) Full file path including filename and extension.
%              If not provided, user will be prompted to select path.
%   table    - (Optional) Logical flag indicating whether Data is a MATLAB table.
%              Set to true when exporting tabular data to text-based formats.
%
% Notes:
% - Multi-slice 3D arrays are automatically split across multiple sheets or appended blocks in text formats.
% - Unsupported formats trigger a warning without saving.
% - For '.tiff' and '.h5' formats, helper functions `tiff_exporter` and `write_h5` must be available.

function exporter(Data, format, filepath, table)

    if nargin < 2 || isempty(format)
        format = '.mat';  % Default export format
    end

    if nargin < 3 || isempty(filepath)
        [file, path] = uiputfile(['*' format], 'Save As');
        if isequal(file, 0)
            disp('Export cancelled.');
            return;
        end
        filepath = fullfile(path, file);
    elseif iscell(filepath)
        filepath = filepath{1};  % Handle cell array input
    end

    if nargin < 4 || isempty(table)
        table = false;  % Default: assume not table format
    end

    % --- Export based on format ---
    switch format
        case '.mat'
            save(filepath, 'Data');

        case '.h5'
            write_h5(filepath, Data);

        case {'.tiff','tif'}
            tiff_exporter(Data, filepath);

        case {'.txt', '.xlsx', '.csv'}
            if table
                writetable(Data, filepath);
            else
                % Split 3D matrix into slices
                for i = 1:size(Data, 3)
                    Out{i} = Data(:, :, i);
                end

                switch format
                    case {'.txt', '.csv'}
                        for jj = 1:numel(Out)
                            if jj == 1
                                writematrix(Out{jj}, filepath);
                            else
                                writematrix(Out{jj}, filepath, 'WriteMode', 'append');
                            end
                        end

                    case '.xlsx'
                        for jj = 1:numel(Out)
                            if jj == 1
                                writematrix(Out{jj}, filepath);
                            else
                                writematrix(Out{jj}, filepath, 'Sheet', jj, 'WriteMode', 'append');
                            end
                        end
                end
            end

        otherwise
            warning('Unsupported export format: %s', format);
    end
end



  
