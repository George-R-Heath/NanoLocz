---
layout: default
title: Getting Started 
---

<style>

  body {
    background-color: black;
    color: white;
  }

  a {
    color: white;
  }

  h1, h2, h3, h4, h5, h6 {
    color: #FFA500;
  border-bottom: 2px solid #FFA500; /* Bright orange border */
  padding-bottom: 5px; /* Adds space between the text and the border */
  }

#afm-table {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#afm-table th, #afm-table td {
  border: 1px solid #ddd;
  padding: 8px;
}

#afm-table tr:nth-child(even) {
  background-color: #222222;
}
  #afm-table tr:nth-child(odd) {
  background-color: #3b3b3b;
}

#afm-table tr:hover {
  background-color: #000000;
}

#afm-table th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}

.author-link {
  color: #0645AD; /* Blue color for author/source links */
}

</style>

## [NanoLocz User Guide 1.3](https://george-r-heath.github.io/NanoLocz/docs/) <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/36d664a6-38e2-4405-b5cc-a962093cf13b" width="30">

<a href="installation1_3.html">Installation</a> - - <a href="getting_started1_3.html">Getting Started</a> - - <a href="saving_data1_3.html">Saving Data</a> \
<a href="image_levelling1_3.html" style="color: red;">Level</a> - - 
<a href="particle_detection1_3.html" style="color: lightblue;">Detect</a> - - 
<a href="fine_align1_3.html" style="color: orange;">FineAlign</a> - - 
<a href="localize1_3.html" style="color: pink;">Localize</a>\
<a href="area_analysis1_3.html" style="color: limegreen;">Area Analysis</a> - - <a href="keyboard_shortcuts1_3.html">Keyboard Shortcuts</a>\
<a href="simulation_afm1_3.html" style="color: orange;">Simulation AFM</a> - - <a href="general_use1_3.html">YouTube Video Tutorials</a> 

# Getting Started with NanoLocz
[1. User Interface](#1-user-interface)\
[2. Set Your Preferences](#2-set-your-preferences)\
[3. Opening Files](#3-opening-files)\
[4. YouTube video on Getting Started](#4-youtube-video-on-getting-started)

## 1. User Interface
See individual help pages for help on:
<a href="image_levelling1_3.html" style="color: red;">Level</a> - - 
   <a href="particle_detection1_3.html" style="color: lightblue;">Detect</a> - - 
   <a href="fine_align1_3.html" style="color: orange;">FineAlign</a> - - 
    <a href="localize1_3.html" style="color: pink;">Localize</a>

    
![Leftpanel](https://github.com/user-attachments/assets/9970f593-296c-4d7a-bc0c-858f521ed6c2)

![image](https://github.com/user-attachments/assets/22e21bd0-2fbf-4f17-ad30-5e2ddd7b1c3b)

## 2. Set Your Preferences
Let’s set up your NanoLocz settings such that the next time you open the app your preferred input/output folder and other settings will be preloaded.
* Step 1: Select a data folder, to save time later this might be your main raw data folder that might have subfolders containing data from different imaging days - press the Folder icon <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/9ed0f385-3cf8-415e-a539-d2e45b511eab" width="30"> or go to ‘File’ -> ‘Open’ -> ‘Folder’

* Step 2: Go to _Preferences_ and select *cd* for both *Start Folder* and *Output Folder* to set these to the same as the current Open Folder or select different locations. You can also select the default Colour map and export settings here.

![pref](https://github.com/George-R-Heath/NanoLocz/assets/90329395/e888bcc0-7718-41e0-b49f-5d6b96c2337e)

## 3. Opening Files
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


<table id="afm-table">
  <tr>
    <th>AFM Manufacturer</th>
    <th>Format Used</th>
    <th>Read Height</th>
    <th>Read All Channels</th>
    <th>Video Support</th>
    <th>Video Format</th>
    <th>Author/Source</th>
  </tr>
  <tr>
    <td class="bruker">Bruker™</td>
    <td>.spm</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Folder</td>
    <td><a href="https://uk.mathworks.com/matlabcentral/fileexchange/11515-open-nanoscope-6-afm-images?tab=discussions" class="author-link">J. D. Groot</a></td>
  </tr>
  <tr>
    <td class="bruker"></td>
    <td>.jpk</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Folder</td>
    <td><a href="https://uk.mathworks.com/matlabcentral/fileexchange/68760-open_jpk" class="author-link">R. D. Ortuso</a></td>
  </tr>
   <tr>
    <td class="bruker"></td>
    <td>.h5-jpk</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Single File</td>
   <td>NanoLocz</td>
  </tr>
  <tr>
    <td>RIBM™</td>
    <td>.asd</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Single file</td>
    <td>G. Tagiltsev & S. Scheuring</td>
  </tr>
  <tr>
    <td>Oxford Instruments™</td>
    <td>.aris</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Single file</td>
    <td>NanoLocz</td>
  </tr>
  <tr>
    <td>Oxford Instruments™</td>
    <td>.ibw</td>
    <td>✓</td>
    <td>x</td>
    <td>✓</td>
    <td>Folder</td>
    <td><a href="https://uk.mathworks.com/matlabcentral/fileexchange/42679-igor-pro-file-format-ibw-to-matlab-variable" class="author-link">J. Bialek</a></td>
  </tr>
  <tr>
    <td>Nanosurf™</td>
    <td>.nhf</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Folder</td>
    <td>NanoLocz</td>
  </tr>
  <tr>
    <td>Nanosurf™</td>
    <td>.gyw</td>
    <td>✓</td>
    <td>✓</td>
    <td>✓</td>
    <td>Folder</td>
    <td><a href="https://uk.mathworks.com/matlabcentral/fileexchange/32893-gwyddion-file-importer" class="author-link">E. L. Fricke</a></td>
  </tr>
  <tr>
    <td>Park Systems™</td>
    <td>.tiff</td>
    <td>✓</td>
    <td>x</td>
    <td>✓</td>
    <td>Single file</td>
    <td>NanoLocz</td>
  </tr>
</table>


### Stacking images/videos
* Different images and movies can be stacked or intercalated if the images have the same pixel numbers in x and y using the dropdown box above the parameter table.
* Stack: Adds the next file or channel selected in series with the current image/video
* Intercalate: Alternates current frames will new frames, useful for assembling trace-retrace into a single movie. 

## 4. YouTube video on Getting Started 
[![YouTube NanoLocz Getting Started](https://img.youtube.com/vi/dX4VoURMAcQ/0.jpg)](https://www.youtube.com/watch?v=dX4VoURMAcQ)
