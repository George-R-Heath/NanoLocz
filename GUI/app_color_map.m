function c = app_color_map(ColourmapDropDown, app)
cmap =load('AFM_luts_full.mat');
switch ColourmapDropDown
    case 'AFM brown'
        c = cmap.AFM_brown;
    case 'AFM dark gold'
        c = cmap.AFM_Dark_Gold;
    case 'AFM gold'
        c = cmap.AFM_Gold;
    case 'Orange hot'
        c = cmap.AFM_orange;
    case'fire'
        c = cmap.AFM_fire;
    case 'Rainbow'
        c = cmap.Rainbow;
    case'inferno'
        c = cmap.inferno;
    case'magma'
        c = cmap.magma;
    case'plasma'
        c = cmap.plasma;
    case'viridis'
        c = cmap.viridis;
    case 'LAFM color'
        c =  cmap.LAFMcolor;
    otherwise
        c = feval(ColourmapDropDown);
end

end