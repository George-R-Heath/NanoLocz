% pad_stacker - Centrally pads two 2D matrices to the same size and stacks them.
%
%   This function takes two 2D matrices, A and B, and pads them with zeros so
%   that they both have the same number of rows and columns (the maximum of 
%   their respective sizes). The padded matrices are then stacked along the 
%   third dimension to produce a single 3D array.
%
%   Inputs:
%       A - First 2D matrix (numeric).
%       B - Second 2D matrix (numeric).
%
%   Outputs:
%       C - 3D padded array where C(:,:,1) is the padded A and C(:,:,2) is the padded B.
%
%   Notes:
%   - Padding is applied symmetrically (centrally) where possible.
%   - If dimensions are odd, extra padding is added at the end (post) to avoid mismatch.

%
%   Example:
%       A = rand(100, 120);
%       B = rand(90, 140);
%       C = pad_stacker(A, B);
%       imagesc(C(:,:,1)); % Show padded A

function C = pad_stacker(A,B)
max_rows = max(size(A, 1), size(B, 1));
max_cols = max(size(A, 2), size(B, 2));

% Calculate padding for each matrix
pad_rows_A = floor((max_rows - size(A, 1)) / 2);
pad_cols_A = floor((max_cols - size(A, 2)) / 2);
pad_rows_B = floor((max_rows - size(B, 1)) / 2);
pad_cols_B = floor((max_cols - size(B, 2)) / 2);

% % Pad matrices A and B centrally with zeros
padded_A = padarray(A, [pad_rows_A, pad_cols_A]);
padded_B = padarray(B, [pad_rows_B, pad_cols_B]);

% Stack matrices in the 3rd dimension
try
    C = cat(3, padded_A, padded_B);
catch
    A = padded_A; B=padded_B;
    max_rows = max(size(A, 1), size(B, 1));
    max_cols = max(size(A, 2), size(B, 2));
    pad_rows_A = floor((max_rows - size(A, 1)));
    pad_cols_A = floor((max_cols - size(A, 2)));
    pad_rows_B = floor((max_rows - size(B, 1)));
    pad_cols_B = floor((max_cols - size(B, 2)));

    padded_A = padarray(A, [pad_rows_A, pad_cols_A],'post');
    padded_B = padarray(B, [pad_rows_B, pad_cols_B],'post');
    C = cat(3, padded_A, padded_B);
end
end