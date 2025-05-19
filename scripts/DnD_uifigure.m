function DnD_uifigure(target, dropFcn)
% Set up a callback when file/folder is dropped onto a uifigure component.
% 
% The target can be a uifigure or any uifigure component.
% 
% dropFcn is the callback function when a file is dropped. Its syntax is the
% same as general Matlab callback, like @myFunc or {@myFunc myOtherInput}.
% In the callback, the first argument is the target, and 2nd the data containing
%     ctrlKey: 0 % true if Ctrl key is down while dropping
%    shiftKey: 0 % true if Shift key is down while dropping
%       names: {'/myPath/myFile'} % cellstr for full file/folder names
% 
% Example to show dropped file/folder onto uilistbox:
%  target = uilistbox(uifigure, 'Position', [80 100 400 100]);
%  DnD_uifigure(target, @(o,dat)set(o,'Items',dat.names));

% 201001 Wrote it, by Xiangrui.Li at gmail.com 
% 201023 Remove uihtml by using ww.executeJS

narginchk(2, 2);
if isempty(target), target = uifigure; end
if numel(target)>1 || ~ishandle(target)
    error('DnD_uifigure:badInput', 'target must be a single uifigure component');
end

fh = ancestor(target, 'figure');
h = findall(fh, 'Type', 'uibutton', 'Tag', 'uiFileDnD');
if ~isempty(h)
    h.UserData(end+1,:) = {dropFcn target};
    return;
end

drawnow; ww = matlab.internal.webwindowmanager.instance.windowList;
ww = ww(strcmp(matlab.ui.internal.FigureServices.getFigureURL(fh), {ww.URL}));
try ww.enableDragAndDropAll; % DnD to whole uifigure: no-op for Linux till 2021a
catch, error('Matlab R2020b or later needed for file drag and drop');
end
h = uibutton(fh, 'Position', [1 1 0 0], 'Text', '4JS2identify_me', ...
    'ButtonPushedFcn', {@drop ww}, 'UserData', {dropFcn target}, ...
    'Tag', 'uiFileDnD', 'Visible', 'off', 'HandleVisibility', 'off');

jsStr = char(strjoin([ ... % webwindow accepts only char at least for R2020b
    "uiFileDnD = {rects: [], index: 0,"
    "    button: dojo.query('.mwPushButton').find(b => b.textContent==='%s')};"
    "document.ondragenter = (e) => { // prevent default before firing ondragover"
    "  e.dataTransfer.dropEffect = 'none';"
    "  return false;"
    "};"
    "document.ondragover = (e) => {"
    "  e.returnValue = false; // preventDefault & stopPropagation"
    "  var x = e.clientX+1, y = document.body.clientHeight-e.clientY;"
    "  for (var i = uiFileDnD.rects.length-1; i >= 0; i--) {"
    "    var p = uiFileDnD.rects[i]; // [left bottom width height]"
    "    if (x>=p[0] && y>=p[1] && x<p[0]+p[2] && y<p[1]+p[3]) {"
    "      uiFileDnD.index = i; // target index in rects"
    "      return; // keep OS default dropEffect"
    "    };"
    "  };"
    "  e.dataTransfer.dropEffect = 'none'; // disable drop"
    "};"
    "document.ondrop = (e) => {"
    "  e.returnValue = false;"
    "  uiFileDnD.data = {ctrlKey: e.ctrlKey, shiftKey: e.shiftKey};"
    "  uiFileDnD.button.click(); // fire Matlab callback"
    "};"], newline));
drawnow; ww.executeJS(sprintf(jsStr, h.Text));
ww.FileDragDropCallback = {@dragEnter h};

%% fired when drag enters uifigure
function dragEnter(ww, names, h)
for i = size(h.UserData,1):-1:1 %  redo in case pos changed or resized
    p{i} = round(getpixelposition(h.UserData{i,2}, 1));
    if h.UserData{i,2}.Type == "figure", p{i}(1:2) = 1; end
end
ww.executeJS(['uiFileDnD.rects=' jsonencode(p)]);
h.Text = cellstr(names); % store file names

%% fired by javascript fake button press in ondrop
function drop(h, ~, ww)
dat = jsondecode(ww.executeJS('uiFileDnD.data'));
dat.names = h.Text;
args = [h.UserData(jsondecode(ww.executeJS('uiFileDnD.index'))+1,:) dat];
if iscell(args{1}), args = [args{1}(1) args(2:3) args{1}(2:end)]; end
feval(args{:});
%%
