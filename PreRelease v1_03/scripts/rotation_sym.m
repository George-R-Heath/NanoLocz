
    function [sym_av] = rotation_sym(d,fold)
        dr{1} = d;
        av = dr{1};
        for i = 2:fold
            r(i) = (i-1)*360/(fold);
            dr{i} = imrotate(d,r(i),'crop','bicubic');
            av = av + dr{i};
        end
        sym_av = av/fold;
    end
