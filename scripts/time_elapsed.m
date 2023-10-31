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
