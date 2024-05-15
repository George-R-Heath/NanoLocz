function exporter(Data, format, filepath,table)
filepath = filepath{1};
switch format
    case '.mat'
        save(filepath, 'Data');
    case '.h5'
        write_h5(filepath, Data)
    case '.tiff'
        tiff_exporter(Data,filepath)
    case {'.txt', '.xlsx', '.csv'}

        if table
            writetable(Data,filepath);
        else
            for i = 1:numel(Data(1,1,:))
                Out{i} = Data(:,:,i);
            end
            switch format
                case {'.txt','.csv'}
                    for jj=1:numel(Out)
                        if jj==1
                            writematrix(Out{1},filepath);
                        else
                            writematrix(Out{jj},filepath,'WriteMode','append');
                        end
                    end

                case '.xlsx'

                    for jj=1:numel(Out)

                        if jj==1
                            writematrix(Out{1},filepath);
                        else
                            writematrix(Out{jj},filepath,'Sheet',jj,'WriteMode','append');
                        end
                    end
            end
        end
end
end