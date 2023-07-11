function [D, img, s] = OpenIBW(f)
% IBWread - read Igor wave from IBW file
%   D = IBWread('Foo.ibw') reads Igor file Foo.ibw into struct D.

if exist('fullfilename', 'file'), FFN = fullfilename(f, cd, '.ibw');
else, FFN = f;
end

% read headers
[D.binHeader, D.waveHeader, FFN] = readIBWheaders(f);
fid = fopen(FFN,'r');
fid = fopen(FFN,'r');
% 	For numeric waves, the type field is interpreted bitwise. One of the following bits, as represented by symbols defined in IgorBin.h, will be set:
% 
% % #define NT_CMPLX 1   % Complex numbers.
% % #define NT_FP32 2   % 32 bit fp numbers.
% % #define NT_FP64 4   % 64 bit fp numbers.
% % #define NT_I8 8    % 8 bit signed integer. Requires Igor Pro 2.0 or later.
% % #define NT_I16  0x10  % 16 bit integer numbers. Requires Igor Pro 2.0 or later.
% % #define NT_I32  0x20  % 32 bit integer numbers. Requires Igor Pro 2.0 or later.
% % #define NT_UNSIGNED 0x40 % Makes above signed integers unsigned. Requires Igor Pro 3.0 or later.
% 	NT_FP64		64-bit floating point (double)
% 	NT_FP32		32-bit floating point (float)
% 	NT_I32		32 bit integer (long)
% 	NT_16			16 bit integer (short)
% 	NT_I8			8 bit integer (char)
datatype = D.waveHeader.type;
CMPLX = rem(datatype,2);
if CMPLX, datatype = datatype-1; end
switch datatype,
    case 0,     prec = '*char';
    case 2,     prec = 'single';
    case 4, prec = 'double';
    case 8, prec = 'int8';
    case 16, prec = 'int16';
    case 32, prec = 'int32';
    case 64+8, prec = 'uint8';
    case 64+16, prec = 'uint16';
    case 64+32, prec = 'uint32';
    otherwise, error('Invalid numerical datatype.');
end

D.bname = D.waveHeader.bname;
% The date/time is store as seconds since midnight, January 1, 1904.
D.creationDate = local_igorTime2vec(D.waveHeader.creationDate);
D.modDate = local_igorTime2vec(D.waveHeader.creationDate);
switch D.binHeader.version,
    case 2,
        %         The version 2 file has the following general layout.
        %         BinHeader2 structure: 16 bytes
        %         WaveHeader2 structure excluding wData field; 110 bytes
        %         Wave data: Variable size
        D.Nsam = D.waveHeader.npnts;
        D.Ndim = 1;
        % X value for point p = hsA*p + hsB
        D.dx = D.waveHeader.hsA;
        D.x0 = D.waveHeader.hsB;
        D.x1 = D.x0+D.Nsam*D.dx;
        fseek(fid, 16+110, 'bof');
        NN = D.Nsam*(1+double(CMPLX)); % if complex, read twice as many numbers
        D.y = fread(fid, NN, prec);
        if CMPLX, D.y = D.y(1:2:end) + i*D.y(2:2:end); end; % Re & Im values are interleaved
    case 5,
        % The version 5 file has the following general layout.
        % BinHeader5 structure 64 bytes
        % WaveHeader5 structure excluding wData field 320 bytes
        % Wave data Variable size
        % Optional wave dependency formula Variable size
        % Optional wave note data Variable size
        D.Nsam = D.waveHeader.npnts;
        D.Ndim = sum(D.waveHeader.nDim>0);
        % X offset & spacing (documentation is obscure)
        D.dx = D.waveHeader.sfA(1:D.Ndim);
        D.x0 = D.waveHeader.sfB(1:D.Ndim);
        D.x1 = nan; % D.x0+D.Nsam*D.dx;
        fseek(fid, 64+320, 'bof');
        NN = D.Nsam*(1+double(CMPLX)); % if complex, read twice as many numbers
        if isequal(0,datatype), % text data
            % Number of bytes of wave data = wfmSize - (sizeof(WaveHeader5) - 4)
            NN = D.binHeader.wfmSize-320;
            D.y = fread(fid, NN, prec)';
        else, % numerical data
            D.y = fread(fid, NN, prec);
        end
        if CMPLX, D.y = D.y(1:2:end) + i*D.y(2:2:end); end; % Re & Im values are interleaved
        if ~isempty(D.y) && D.Ndim>1,
            D.y = reshape(D.y, D.waveHeader.nDim(1:D.Ndim));
        end
end
D.WaveNotes = local_readNotes(fid, D.binHeader);
if isequal(0,datatype), % partition text data into lines using string indices stored @ eof 
    D = local_partition_text(fid, D);
end



a =extractBetween(D.WaveNotes,'ScanSize: ','FastScanSize');
s.ScanSize = str2double(a{1});

a = extractBetween(D.WaveNotes,'ScanPoints: ','ScanLines');
s.yPixel = str2double(a{1});

a = extractBetween(D.WaveNotes,'ScanLines: ','ScanAngle');
s.xPixel = str2double(a{1});

a = extractBetween(D.WaveNotes,'ScanRate: ','XOffset');
s.frameAcqTime = str2double(a{1}).*s.yPixel;

%a = extractBetween(D.WaveNotes,'Channel1DataType: H','Channel2');
%s.channel1 = a{1};

img = D.y(:,:,1)';

fseek(fid,0,'eof');
D.fileSize = ftell(fid);
fclose(fid);

%===============================
function DV=local_igorTime2vec(it);
% igor time -> date vector a la Matlab
% The date/time is store as seconds since midnight, January 1, 1904.
Nsec_4year = 126230400;
idate_1988 = 21*uint32(Nsec_4year); % # seconds between 1-jan-1904 & 1-jan-1988
it = double(it-idate_1988); % smaller numbers-> use ordinary numbers ("doubles")
M4 = floor(it/Nsec_4year);
YR = double(1988+4*M4);
it = double(it-M4*Nsec_4year);
last_it = it;
while 1, % subtract years as long as they fit
    s = etime([YR+1 1 1 0 0 0], [YR 1 1 0 0 0]);
    if it<s, break; end % we went too far
    YR = YR+1;
    it = it-s;
end
MNTH = 1;
while 1, % subtract months as long as they fit
    s = etime([YR MNTH+1 1 0 0 0], [YR MNTH 1 0 0 0]);
    if it<s, break; end % we went too far
    MNTH = MNTH+1;
    it = it-s;
end
DAY = 1;
while 1, % subtract days as long as they fit
    s = etime([YR MNTH DAY+1 0 0 0], [YR MNTH DAY 0 0 0]);
    if it<s, break; end % we went too far
    DAY = DAY+1;
    it = it-s;
end
HR = floor(it/60^2); it = it-HR*60^2;
MIN = floor(it/60); SEC = it-MIN*60;
DV = [YR, MNTH, DAY, HR, MIN, SEC];
if ~isequal(last_it, etime(DV, [1988+4*M4 1 1 0 0 0])),
    error('date error');
end

function Nts = local_readNotes(fid, B);
switch B.version, 
    case 2,
        % BinHeader2 structure 16 bytes
        % WaveHeader2 structure excluding wData field 110 bytes
        % Wave data Variable size
        % 16 bytes of padding 16 bytes
        dum = fread(fid,16,'char');
        % Optional wave note data
        Nts = fread(fid, B.noteSize, '*char').';
    case 5,
        % BinHeader5 structure 64 bytes
        % WaveHeader5 structure excluding wData field 320 bytes
        % Wave data Variable size
        % Optional wave dependency formula Variable size
        dum = fread(fid,B.formulaSize, 'char');
        % Optional wave note data Variable size
        Nts = fread(fid, B.noteSize, '*char').';
end

function D = local_partition_text(fid, D);
% read sizeindices and chop text accordingly, must be called after reading
% notes
bH = D.binHeader;
% skip other stuff in file
% The version 5 file has the following general layout.
% BinHeader5 structure	64 bytes
% WaveHeader5 structure excluding wData field	320 bytes
% Wave data	Variable size
% Optional wave dependency formula	Variable size
% Optional wave note data	Variable size
% Optional extended data units data	Variable size
% Optional extended dimension units data	Variable size
% Optional dimension label data	Variable size
% String indices used for text waves only	Variable size
dum=fseek(fid, -bH.sIndicesSize, 'eof'); % string indices are last in file; it's easier to refer from end-of-file
% bH.sIndicesSize; # bytes of string indices stored for the wave if the wave type is text. 
% String indices are used to determine the offset in the file and the number of bytes for each element of the text wave.
sIdx = [0 fread(fid, bH.sIndicesSize/4, 'uint32').']; 
for ii=1:numel(sIdx)-1,
    STR{ii,1} = D.y(sIdx(ii)+1:sIdx(ii+1));
end
D.y = STR;


% long sIndicesSize; The size of string indicies if this is a text wave.




function H = readIBWbinheader(FFN);
% readIBWbinheader - read BinHeader segment of Igor IBW file
%  H = readIBWbinheader('foo') reads BinHeader of file Foo.ibw
%   IBW version 2,5 only
MAXDIMS = 4;

fid = fopen(FFN,'r');
H.version = fread(fid,1,'int16');
switch H.version,
    case 2,   %    typedef struct BinHeader2 {
        H.wfmSize = fread(fid,1,'uint32'); %  long wfmSize;      // The size of the WaveHeader2 data structure plus the wave data plus 16 bytes of padding.
        H.noteSize = fread(fid,1,'uint32'); %  long noteSize;      // The size of the note text.
        H.pictSize = fread(fid,1,'uint32'); %  long pictSize;      // Reserved. Write zero. Ignore on read.
        H.checksum = fread(fid,1,'int16'); %  short checksum;      // Checksum over this header and the wave header.
    case 5,
        H.checksum = fread(fid,1,'short');
        H.wfmSize =  fread(fid,1,'long'); % The size of the WaveHeader5 data structure plus the wave data.
        H.formulaSize =  fread(fid,1,'long');   % The size of the dependency formula, if any.
        H.noteSize =  fread(fid,1,'long');   % The size of the note text.
        H.dataEUnitsSize =  fread(fid,1,'long');  % The size of optional extended data units.
        H.dimEUnitsSize =  fread(fid,MAXDIMS,'long');  % The size of optional extended dimension units.
        H.dimLabelsSize =  fread(fid,MAXDIMS,'long'); % The size of optional dimension labels.
        H.sIndicesSize =  fread(fid,1,'long'); ;     % The size of string indicies if this is a text wave.
        H.optionsSize1 =  fread(fid,1,'long'); ;     % Reserved. Write zero. Ignore on read.
        H.optionsSize2 =  fread(fid,1,'long'); ;     % Reserved. Write zero. Ignore on read.
    otherwise,
end % switch H.Version
fclose(fid);

if ~ismember(H.version,[2 5]),
    error(['Cannot read version ' num2str(H.version) ' IBW files - only versions 2,5 are okay.']);
end
%==FROM IgorBin.h =====================
%  #define MAXDIMS 4
%
% typedef struct BinHeader5 {
%  short version;      // Version number for backwards compatibility.
%  short checksum;      // Checksum over this header and the wave header.
%  long wfmSize;      // The size of the WaveHeader5 data structure plus the wave data.
%  long formulaSize;     // The size of the dependency formula, if any.
%  long noteSize;      // The size of the note text.
%  long dataEUnitsSize;    // The size of optional extended data units.
%  long dimEUnitsSize[MAXDIMS];  // The size of optional extended dimension units.
%  long dimLabelsSize[MAXDIMS];  // The size of optional dimension labels.
%  long sIndicesSize;     // The size of string indicies if this is a text wave.
%  long optionsSize1;     // Reserved. Write zero. Ignore on read.
%  long optionsSize2;     // Reserved. Write zero. Ignore on read.
% } BinHeader5;

function [BH, H, FFN] = readIBWheaders(FFN);
% readIBWheaders - read BinHeader & WaveHeader segments of Igor IBW file
%  [BH, WH, FFN] = readIBWheaders('foo') reads BinHeader & WaveHeader of
%   file Foo.ibw - Versions 2 and 5 only. FFN is full filename.

% % 1 byte char
% % 2 bytes short
% % 4 bytes int, long, float, Handle, any kind of pointer
% % 8 bytes double
MAXDIMS = 4;
MAX_WAVE_NAME2 = 18; % Maximum length of wave name in version 1 and 2 files. Does not include the trailing null.
MAX_WAVE_NAME5 = 31; % Maximum length of wave name in version 5 files. Does not include the trailing null.
MAX_UNIT_CHARS = 3;


BH = readIBWbinheader(FFN);
fid = fopen(FFN,'r');
switch BH.version
    case 2,
        %         The version 2 file has the following general layout.
        %         BinHeader2 structure: 16 bytes
        %         WaveHeader2 structure excluding wData field; 110 bytes
        %         Wave data: Variable size
        fseek(fid,16,'bof'); % start of wave header of IBW vs 2; % struct WaveHeader2 {
        H.type = fread(fid,1, 'uint16'); %  short type; % See types (e.g. NT_FP64) above. Zero for text waves.
        H.WaveHeader2 = fread(fid,1, 'uint32'); %  struct WaveHeader2 **next;   // Used in memory only. Write zero. Ignore on read.
        H.bname = local_char(fread(fid, MAX_WAVE_NAME2+2, 'char')); %  char bname[MAX_WAVE_NAME2+2];  // Name of wave plus trailing null.
        H.whVersion = fread(fid,1, 'uint16'); %  short whVersion; // Write 0. Ignore on read.
        H.srcFldr = fread(fid,1, 'uint16'); %  short srcFldr;      // Used in memory only. Write zero. Ignore on read.
        H.fileName = fread(fid,1, 'uint32'); %  Handle fileName;     // Used in memory only. Write zero. Ignore on read.
        %
        H.dataUnits = local_char(fread(fid, MAX_UNIT_CHARS+1, 'char')); %  char dataUnits[MAX_UNIT_CHARS+1]; // Natural data units go here - null if none.
        H.xUnits = local_char(fread(fid, MAX_UNIT_CHARS+1, 'char')); %  char xUnits[MAX_UNIT_CHARS+1];  // Natural x-axis units go here - null if none.
        %
        H.npnts = fread(fid,1, 'uint32'); %  long npnts;       // Number of data points in wave.
        %
        H.aModified = fread(fid,1, 'uint16'); %  short aModified;     // Used in memory only. Write zero. Ignore on read.
        H.hsA = fread(fid,1, 'double'); %  double hsA,hsB;      // X value for point p = hsA*p + hsB
        H.hsB = fread(fid,1, 'double'); %  double hsA,hsB;      // X value for point p = hsA*p + hsB
        %
        H.wModified = fread(fid,1, 'uint16'); %  short wModified;     // Used in memory only. Write zero. Ignore on read.
        H.swModified = fread(fid,1, 'uint16'); %  short swModified;     // Used in memory only. Write zero. Ignore on read.
        H.fsValid = fread(fid,1, 'uint16'); %  short fsValid;      // True if full scale values have meaning.
        H.topFullScale = fread(fid,1, 'double'); %  double topFullScale,botFullScale; // The min full scale value for wave.
        H.botFullScale = fread(fid,1, 'double'); %  double topFullScale,botFullScale; // The min full scale value for wave.
        %
        H.useBits = fread(fid,1, 'char'); %  char useBits;      // Used in memory only. Write zero. Ignore on read.
        H.kindBits = fread(fid,1, 'char'); %  char kindBits;      // Reserved. Write zero. Ignore on read.
        H.formula = fread(fid,1, 'uint32'); %  void **formula;      // Used in memory only. Write zero. Ignore on read.
        H.depID = fread(fid,1, 'uint32'); %  long depID;       // Used in memory only. Write zero. Ignore on read.
        H.creationDate = fread(fid,1, '*uint32'); %  unsigned long creationDate;   // DateTime of creation. Not used in version 1 files.
        H.platform = fread(fid,1, 'uint8'); %  unsigned char platform;    // 0=unspecified, 1=Macintosh, 2=Windows; Added for Igor Pro 5.5.
%        dummy = fread(fid,1, 'uint8'); %  align
        H.wUnused = fread(fid,1, 'uint8'); %  char wUnused[1];     // Reserved. Write zero. Ignore on read.
        %
        H.modDate = fread(fid,1, '*uint32'); %  unsigned long modDate;    // DateTime of last modification.
        H.waveNoteH = fread(fid,1, 'uint32'); %  Handle waveNoteH;     // Used in memory only. Write zero. Ignore on read.
        %
        H.wData = fread(fid,4, 'single').'; %  float wData[4];      // The start of the array of waveform data.
    case 5,
        %         The version 5 file has the following general layout.
        %         BinHeader5 structure: 64 bytes
        %         WaveHeader5 structure excluding wData field: 320 bytes
        %         Wave data: Variable size
        fseek(fid,64,'bof'); % start of wave header of IBW vs 5
        %
        H.next = fread(fid,1, 'int32');  % link to next wave in linked list.
        %
        H.creationDate = fread(fid,1, 'uint32');  % DateTime of creation.
        H.modDate = fread(fid,1, 'uint32');  % DateTime of creation.
        %
        H.npnts = fread(fid,1, 'int32');  % Total number of points (multiply dimensions up to first zero).
        H.type = fread(fid,1, 'uint16'); % See types (e.g. NT_FP64) above. Zero for text waves.
        H.dLock = fread(fid, 1, 'int16'); % Reserved. Write zero. Ignore on read.
        %
        H.whpad1 = fread(fid, 6, 'char').'; % Reserved. Write zero. Ignore on read.
        H.whVersion = fread(fid, 1, 'int16'); % Write 1. Ignore on read.
        H.bname = local_char(fread(fid, MAX_WAVE_NAME5+1, 'char')); % Name of wave plus trailing null.
        H.whpad2 = fread(fid, 1, 'int32'); % long Reserved. Write zero. Ignore on read.
        H.dFolder = fread(fid, 1, 'int32'); % ptr Used in memory only. Write zero. Ignore on read.

        %  % Dimensioning info. [0] == rows, [1] == cols etc
        H.nDim = fread(fid, MAXDIMS, 'int32').'; % long nDim[MAXDIMS] Number of of items in a dimension -- 0 means no data.
        H.sfA = fread(fid, MAXDIMS, 'double').'; % double sfA[MAXDIMS]; Index value for element e of dimension d = sfA[d]*e + sfB[d].
        H.sfB = fread(fid, MAXDIMS, 'double').'; % double sfB[MAXDIMS];%  double sfB[MAXDIMS];
        % %
        % %  % SI units
        H.dataUnits = local_char(fread(fid, MAX_UNIT_CHARS+1, 'char')); %  char dataUnits[MAX_UNIT_CHARS+1];   % Natural data units go here - null if none.
        H.dimUnits = fread(fid, MAXDIMS*(MAX_UNIT_CHARS+1), '*char').'; % %  char dimUnits[MAXDIMS][MAX_UNIT_CHARS+1]; % Natural dimension units go here - null if none.
        % %
        H.fsValid = fread(fid, 1, 'uint16'); % %  short fsValid;      % TRUE if full scale values have meaning.
        H.whpad3 = fread(fid, 1, 'int16'); % %  short whpad3;      % Reserved. Write zero. Ignore on read.
        H.topFullScale = fread(fid, 1, 'double');
        H.botFullScale = fread(fid, 1, 'double'); % %  double topFullScale,botFullScale; % The max and max full scale value for wave.
        % %
        H.dataEUnits = fread(fid, 1, 'int32'); % %  Handle dataEUnits;     % Used in memory only. Write zero. Ignore on read.
        H.dimEUnits = fread(fid, MAXDIMS, 'int32').'; % %  Handle dimEUnits[MAXDIMS];   % Used in memory only. Write zero. Ignore on read.
        H.dimLabels = fread(fid, MAXDIMS, 'int32').'; % %  Handle dimLabels[MAXDIMS];   % Used in memory only. Write zero. Ignore on read.
        % %
        H.waveNoteH = fread(fid, 1, 'int32'); % %  Handle waveNoteH;     % Used in memory only. Write zero. Ignore on read.
        % %
        H.platform = fread(fid, 1, 'uint8'); % %  unsigned char platform;    % 0=unspecified, 1=Macintosh, 2=Windows; Added for Igor Pro 5.
        H.skip_junk________ = fread(fid,80,'char').';
        % H. = fread(fid, 1, '');
        % %  unsigned char spare[3];
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  long whUnused[13];     % Reserved. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  long vRefNum, dirID;    % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  % The following stuff is considered private to Igor.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  short aModified;     % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  short wModified;     % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  short swModified;     % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  char useBits;      % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  char kindBits;      % Reserved. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  void **formula;      % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  long depID;       % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  short whpad4;      % Reserved. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  short srcFldr;      % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %  Handle fileName;     % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        % H. = fread(fid, 1, '');
        % %  long **sIndices;     % Used in memory only. Write zero. Ignore on read.
        % H. = fread(fid, 1, '');
        % %
        H.wData = fread(fid, 1, 'single');
        % %  float wData[1];      % The start of the array of data. Must be 64 bit aligned.
        % H. = fread(fid, 1, '');
        % };
end % switch BH.version
H.EOH_pos = ftell(fid);




fclose(fid);

%==FROM IgorBin.h =====================
%  #define MAXDIMS 4

% % #define MAX_WAVE_NAME5 31 // Maximum length of wave name in version 5 files. Does not include the trailing null.
% % #define MAX_UNIT_CHARS 3

% % #define NT_CMPLX 1   % Complex numbers.
% % #define NT_FP32 2   % 32 bit fp numbers.
% % #define NT_FP64 4   % 64 bit fp numbers.
% % #define NT_I8 8    % 8 bit signed integer. Requires Igor Pro 2.0 or later.
% % #define NT_I16  0x10  % 16 bit integer numbers. Requires Igor Pro 2.0 or later.
% % #define NT_I32  0x20  % 32 bit integer numbers. Requires Igor Pro 2.0 or later.
% % #define NT_UNSIGNED 0x40 % Makes above signed integers unsigned. Requires Igor Pro 3.0 or later.
%
% struct WaveHeader5 {
%  struct WaveHeader5 **next;   % link to next wave in linked list.
%
%  unsigned long creationDate;   % DateTime of creation.
%  unsigned long modDate;    % DateTime of last modification.
%
%  long npnts;       % Total number of points (multiply dimensions up to first zero).
%  short type;       % See types (e.g. NT_FP64) above. Zero for text waves.
%  short dLock;      % Reserved. Write zero. Ignore on read.
%
%  char whpad1[6];      % Reserved. Write zero. Ignore on read.
%  short whVersion;     % Write 1. Ignore on read.
%  char bname[MAX_WAVE_NAME5+1];  % Name of wave plus trailing null.
%  long whpad2;      % Reserved. Write zero. Ignore on read.
%  struct DataFolder **dFolder;  % Used in memory only. Write zero. Ignore on read.
%
%  % Dimensioning info. [0] == rows, [1] == cols etc
%  long nDim[MAXDIMS];     % Number of of items in a dimension -- 0 means no data.
%  double sfA[MAXDIMS];    % Index value for element e of dimension d = sfA[d]*e + sfB[d].
%  double sfB[MAXDIMS];
%
%  % SI units
%  char dataUnits[MAX_UNIT_CHARS+1];   % Natural data units go here - null if none.
%  char dimUnits[MAXDIMS][MAX_UNIT_CHARS+1]; % Natural dimension units go here - null if none.
%
%  short fsValid;      % TRUE if full scale values have meaning.
%  short whpad3;      % Reserved. Write zero. Ignore on read.
%  double topFullScale,botFullScale; % The max and max full scale value for wave.
%
%  Handle dataEUnits;     % Used in memory only. Write zero. Ignore on read.
%  Handle dimEUnits[MAXDIMS];   % Used in memory only. Write zero. Ignore on read.
%  Handle dimLabels[MAXDIMS];   % Used in memory only. Write zero. Ignore on read.
%
%  Handle waveNoteH;     % Used in memory only. Write zero. Ignore on read.
%
%  unsigned char platform;    % 0=unspecified, 1=Macintosh, 2=Windows; Added for Igor Pro 5.5.
%  unsigned char spare[3];
%
%  long whUnused[13];     % Reserved. Write zero. Ignore on read.
%
%  long vRefNum, dirID;    % Used in memory only. Write zero. Ignore on read.
%
%  % The following stuff is considered private to Igor.
%
%  short aModified;     % Used in memory only. Write zero. Ignore on read.
%  short wModified;     % Used in memory only. Write zero. Ignore on read.
%  short swModified;     % Used in memory only. Write zero. Ignore on read.
%
%  char useBits;      % Used in memory only. Write zero. Ignore on read.
%  char kindBits;      % Reserved. Write zero. Ignore on read.
%  void **formula;      % Used in memory only. Write zero. Ignore on read.
%  long depID;       % Used in memory only. Write zero. Ignore on read.
%
%  short whpad4;      % Reserved. Write zero. Ignore on read.
%  short srcFldr;      % Used in memory only. Write zero. Ignore on read.
%  Handle fileName;     % Used in memory only. Write zero. Ignore on read.
%
%  long **sIndices;     % Used in memory only. Write zero. Ignore on read.
%
%  float wData[1];      % The start of the array of data. Must be 64 bit aligned.
% };

function s=local_char(S);
% null-terminated string -> char string
S = S(:).';
S = S(S~=0);
s=char(S);









