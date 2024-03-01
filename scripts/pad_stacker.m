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