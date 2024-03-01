% Define the modified extended reverse rainbow colors in RGB format

for i = 1:numel(R(:,1))
RainbowColors(i,:) = [ mean(R(i,:)), mean(G(i,:)), mean(B(i,:))];  
end
RainbowColors =double(flip(RainbowColors/255,1));
numColors = 256; % Number of colors in the colormap
AFM_Gold = interp1(linspace(0, 1, size(RainbowColors, 1)), RainbowColors, linspace(0, 1, numColors));

colormap(AFM_Gold);

colorbar
