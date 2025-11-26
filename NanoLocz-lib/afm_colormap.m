function afm_colormap(map_name)
% afm_colormap Apply custom AFM colormap to current figure
% Usage:
%   c = afm_colormap('AFM gold');
%
% This function loads a set of custom AFM colormaps from 'AFM_luts_full.mat',
% applies the chosen colormap to the current figure, and returns the colormap.
    % Load saved colormaps
    persistent LUTs
    if isempty(LUTs)
        LUTs = load('AFM_luts_full.mat');
    end
   
    % Standardize input (remove case sensitivity and extra spaces)
    map_name = strtrim(lower(map_name));

    % Map input name to field names in LUTs
    switch map_name
        case 'afm brown'
            c = LUTs.AFM_brown;
        case 'afm dark gold'
            c = LUTs.AFM_Dark_Gold;
        case 'afm gold'
            c = LUTs.AFM_Gold;
        case 'orange hot'
            c = LUTs.AFM_orange;
        case 'fire'
            c = LUTs.AFM_fire;
        case 'rainbow'
            c = LUTs.Rainbow;
        case 'inferno'
            c = LUTs.inferno;
        case 'magma'
            c = LUTs.magma;
        case 'plasma'
            c = LUTs.plasma;
        case 'viridis'
            c = LUTs.viridis;
        case 'lafm color'
            c = LUTs.LAFMcolor;
        otherwise
            % Try built-in MATLAB colormap if not a known custom map
            try
                c = feval(map_name);
            catch
                warning('Unknown colormap name: using default "parula".');
                c = parula;
            end
    end

    % Apply colormap to current figure
    colormap(c);

end
