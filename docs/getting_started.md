---
layout: default
title: Getting Started 
---

# Getting Started with NanoLocz (v1.2)

![startup](https://github.com/George-R-Heath/NanoLocz/assets/90329395/fdc193f1-b746-474a-8b3c-4d792244e074)

## Set your preferences
Let’s set up your NanoLocz settings such that the next time you open the app your preferred input/output folder and other settings will be preloaded.
* Step 1: Select a data folder, to save time later this might be your main raw data folder that might have subfolders containing data from different imaging days - press the Folder icon <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/9ed0f385-3cf8-415e-a539-d2e45b511eab" width="30"> or go to ‘File’ -> ‘Open’ -> ‘Folder’

* Step 2: Go to _Preferences_ and select *cd* for both *Start Folder* and *Output Folder* to set these to the same as the current Open Folder or select different locations. You can also select the default Colour map and export settings here.

![pref](https://github.com/George-R-Heath/NanoLocz/assets/90329395/e888bcc0-7718-41e0-b49f-5d6b96c2337e)

## Opening Files
### General image opening
* Select a data folder - either by double clicking a folder in the current folder list or press the Folder icon <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/9ed0f385-3cf8-415e-a539-d2e45b511eab" width="30"> or go to ‘File’ -> ‘Open’ -> ‘Folder’ or use arrows to quickly move up <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/6a58b06a-3ccb-449b-8e7a-cb16b4d160ba" width="15"> or down  <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/9f6e637a-e883-4fe0-9c12-1a9f6e1f8c77" width="15"> folder levels.
* To open a file choose from the filenames in the selected working folder ‘File List Box’ displayed in green text.
* If there are multiple channels available to open (eg. Height, Phase ect) these will be displayed as options in the channels dropdown box above the File List Box panel.

### Opening Videos
* Depending on the file structure, videos can be opened by selecting a single file (for .aris and .asd file types) otherwise a video can be assembled by selecting a folder containing the single image files to be assembled into a movie.
![folder](https://github.com/George-R-Heath/NanoLocz/assets/90329395/77a43b94-c40f-4263-990d-e50897948a86)

* The software can only assemble images into a movie if the images have the same pixel numbers in x and y (eg. a stack of 512 x 512 pixel images), non-conforming images are excluded.   

### Supported File Types
Files which are noted as 'Folder' in the Video Format column can be opened as a video by selecting the folder of files from the green/black File List.

|AFM Manufacturer|Format Used|Read Height|Read All Channels|Video Support|Video Format|Author/Source|
|:---:|:---:|:---:|:---:|:---:|:---:|:---:| 
|Bruker™|.spm|✓|✓|✓|Folder|[J. D. Groot](https://uk.mathworks.com/matlabcentral/fileexchange/11515-open-nanoscope-6-afm-images?tab=discussions)|
| |.jpk|✓|✓|✓|Folder|[R. D. Ortuso](https://uk.mathworks.com/matlabcentral/fileexchange/68760-open_jpk)|
|RIBM™|.asd|✓|x|✓|Single file|G. Tagiltsev & S. Scheuring|
|Oxford Instruments™|.aris|✓|✓|✓|Single file| NanoLocz |
| |.ibw|✓|x|✓|Folder|[J. Bialek](https://uk.mathworks.com/matlabcentral/fileexchange/42679-igor-pro-file-format-ibw-to-matlab-variable)|
|Nanosurf™|.nhf|✓|✓|✓|Folder| NanoLocz |
| |.gyw|✓|✓|✓|Folder|[E. L. Fricke](https://uk.mathworks.com/matlabcentral/fileexchange/32893-gwyddion-file-importer)|
|Park Systems™|.tiff|✓|x|✓|Single file|NanoLocz|

### Stacking images/videos
* Different images and movies can be stacked or intercalated if the images have the same pixel numbers in x and y using the dropdown box above the parameter table.
* Stack: Adds the next file or channel selected in series with the current image/video
* Intercalate: Alternates current frames will new frames, useful for assembling trace-retrace into a single movie. 

### YouTube video on Getting Started 
[![YouTube NanoLocz Getting Started](https://img.youtube.com/vi/dX4VoURMAcQ/0.jpg)](https://www.youtube.com/watch?v=dX4VoURMAcQ)
