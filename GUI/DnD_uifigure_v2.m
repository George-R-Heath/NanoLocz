function DnD_uifigure_v2(target, dropFcn)
% Attach a drag-and-drop callback to a uifigure or container component
% target: uifigure or container
% dropFcn: @(src, data) callback with data.names, data.ctrlKey, data.shiftKey

narginchk(2,2);

if isempty(target)
    target = uifigure;
end

if numel(target) > 1 || ~ishandle(target)
    error('DnD_uifigure:badInput', 'Target must be a single uifigure or container.');
end

% Store callback
if ~isfield(target.UserData,'DnDCallbacks') || isempty(target.UserData.DnDCallbacks)
    target.UserData.DnDCallbacks = {};
end
target.UserData.DnDCallbacks{end+1} = dropFcn;

% Attach built-in DropFcn
target.DropFcn = @(src,event) handleDropWrapper(src,event);
end

function handleDrop(app, data)
    % data.names = dropped file paths
    app.FilesListBox.Items = [app.FilesListBox.Items; string(data.names)];
end
