% time_elapsed - Calculate elapsed time in seconds relative to first timestamp
%
% DESCRIPTION:
%   Extracts time strings in 'HH:MM:SS AM/PM' format from a cell array of strings
%   and returns the elapsed time in seconds from the first extracted time.
%
% INPUT:
%   str - Cell array of strings containing timestamps in 'HH:MM:SS AM/PM' format
%
% OUTPUT:
%   time - Numeric array of elapsed time values in seconds relative to the first timestamp

function time = time_elapsed(str)
% Define a regular expression pattern to match the time
pattern = '(\d{2}:\d{2}:\d{2} [APap][Mm])';
timeInSeconds = zeros(size(str));
for i = 1:length(str)
    match = regexp(str(i), pattern, 'match');
    if ~isempty(match)
        extractedTime = match{1};
        timeSerialDate = datenum(extractedTime, 'hh:MM:SS AM');
        timeInSeconds(i) = timeSerialDate * 24 * 3600; % Convert to seconds
    else
    end
      time(i) = timeInSeconds(i)-timeInSeconds(1);
end
