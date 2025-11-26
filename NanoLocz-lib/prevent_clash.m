% Function written for NanoLocz-lib (2025)
% prevent_clash - Adjusts 3D particle positions to eliminate overlaps based on minimum separation.
%
%   This function iteratively checks for and resolves spatial overlaps ("clashes")
%   between positions in 3D space. Particles that are closer than the specified 
%   minimum separation distance (Diameter) are moved apart until no clashes remain.
%
%  function used in AFM simulations with simulated dynamics 
%
%   Inputs:
%       Diameter - Minimum allowed distance between any two particles (scalar).
%       x, y, z  - Coordinates of positions.
%
%   Outputs:
%       x, y, z  - Updated vectors of particle positions with no overlaps closer
%                 than the specified Diameter.

function [x,y,z] = prevent_clash(Diameter,x,y,z)
dp = 0.2;
   numclash = 1;
    while numclash > 0
        dists = squareform(pdist([x;y;z]'));  % Distances between all particles
        dists(dists < Diameter) = NaN;       % Those too close are assigned NaN
        tooclose = isnan(tril(dists,-1)); % All NaNs identified by logical
        [clash1,clash2] = find(tooclose); % Get particles which are clashing
        numclash = numel(clash1);         % Get number of clashes
        % All points where there was a clash, move away from each other

        x(clash1) = x(clash1) + (x(clash1)-x(clash2))*dp;
        x(clash2) = x(clash2) - (x(clash1)-x(clash2))*dp;
        y(clash1) = y(clash1) + (y(clash1)-y(clash2))*dp;
        y(clash2) = y(clash2) - (y(clash1)-y(clash2))*dp;
        z(clash1) = z(clash1) + (z(clash1)-z(clash2))*dp;
        z(clash2) = z(clash2) - (z(clash1)-z(clash2))*dp;
    end
end