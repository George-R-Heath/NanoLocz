
function locs = localize(app, target, locs)
sd = size(target);
loc_method = 'bicubic';

n = numel(locs(:,1));
cla(app.loadbar)
updateInterval = 5;
stepsPerUpdate = ceil(n * (updateInterval / 100));
rectangle(app.loadbar, 'Position', [0, 0, 1, 1], 'FaceColor', 'none', 'EdgeColor', 'black');
progressBar = rectangle(app.loadbar, 'Position', [0, 0, 0, 1], 'FaceColor', 'green');
progressText = text(app.loadbar, 0.5, 0.5, '0%', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');

locs(:,1:2) = round(locs(:,1:2));
w=3; expand_factor = 10;
for jj = 1:n
    if app.stop == 1
        return
    end
    if locs(jj,2)-w+1 > 2 && locs(jj,1)-w+1 > 2 &&  locs(jj,2)+w-1 < sd(1)-2 && locs(jj,1)+w-1 < sd(2)-2
        clip = target(locs(jj,2)-w+1:locs(jj,2)+w-1,locs(jj,1)-w+1:locs(jj,1)+w-1,locs(jj,5));
        clip = imresize(clip, expand_factor, loc_method);
        clip = clip(11:40,11:40);
        [~, imax] = max(clip(:));
        [locs_2y, locs_2x] = ind2sub(size(clip),imax);
        locs(jj,1) = locs(jj,1) + (locs_2x-size(clip,2)/2)/expand_factor;
        locs(jj,2) = locs(jj,2) + (locs_2y-size(clip,1)/2)/expand_factor;
    else
       locs(jj,1:2) = nan;
    end

        if mod(jj, stepsPerUpdate) == 0 || jj == n
            progressBar.Position(3) = jj / n;
           progressText.String = sprintf('Refining %d%%', round(jj/n*100));
           drawnow;
        end

end

delete(progressBar);
delete(progressText);
 
end
