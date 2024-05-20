---
layout: default
title: Saving Data
---

# Saving Data
This section explains how to save data in NanoLocz. Data can either be saved/processed in bulk and for later use or by exporting the current views in the plots for figures/presentations.\
[Save or Batch Process Data](#1-save-or-batch-process-data)\
[Export Images, Videos and Data](#2-exporting-images-videos-and-data) 

## 1. Save or Batch Process Data
The following describes saving and batch processing options so that data can be quickly reopened in NanoLocz or other software.

### Format Options 
* Combined format: Saving of image/video and analysis saved as a single file. Both formats can be reopened by NanoLocz\
**.h5** HDF5 (Hierarchical Data Format version 5) saves all data in a structured format (images, tables, metadata), enabling easy access and analysis with tools like Python.\
**.mat** Saves all data in a structured format as MATLAB variables, allowing direct opening with MATLAB for data analysis and processing.
* Image/Video format: Saving of image/video data as a single file.
* Analysis tables format: Saving of Particle detection, Area analysis, Localizations

### AutoSave
By turning on AutoSave - files will automatically be saved to the output folder according to the settings in Preferences. To change these setting - open the preferences window using the Cog icon or Settings option. 
![pref](https://github.com/George-R-Heath/NanoLocz/assets/90329395/ee3f646d-4075-405f-afeb-ada44420036f)

### Batch Save 
To save one or multiple files open the Save Options using save <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/6e6c149b-85c8-46d2-9d31-4152f5415854" width="25"> 
![save](https://github.com/George-R-Heath/NanoLocz/assets/90329395/c2e197c7-def9-4347-ba4b-89874aa0edaa)

## 2. Exporting Images, Videos and Data
### 2.1 Image and Video export
**Option 1:**
* Select ‘Plot 1’ (left image panel) or ‘Plot 2’ (right Image panel) from the dropdown box
![export](https://github.com/George-R-Heath/NanoLocz/assets/90329395/b5143548-f448-4614-9816-6bf05a907b9a)
* Select the desired format from the dropdown box (.tiff, .csv, .txt, .xls, gif, .avi, .png, .jpeg or .pdf)
* Press the Export button, then select file name and save location.
* Don’t close the image window that pops up until after the file has saved

Note: Exporting as .tiff, .csv, .txt, or .xls enables export without loss of image information whereas export as .gif, .avi, .png, .jpeg or .pdf gives movies/images at presentation or publication quality with automatic scale bars and timestamps. 

**Option 2** (good for creating publication quality figures or grabbing images quickly):
* Press the Pop Out button <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/c1e4a884-38cd-49f9-b71a-1d7925d73cc3" width="20">
* Resize the image 
* Go to the top right hand side of the image and select the far left button from the toolbar
* For making figures choose ‘Copy as vector graphic’ Or for quickly copying an image choose ‘Copy as image’, the image can then be pasted into another program.
* Once pasted vector files can be ungrouped to enable movement and formatting of any labels (eg. scale bars, timestamps…) 
* Only works for single images\
   ![snip](https://github.com/George-R-Heath/NanoLocz/assets/90329395/bf909586-d6b3-4c50-82ae-9ce813b126c6)

### 2.2 Analysis data export
* Open the data Viewer 
* With Plot type table selected, choose the table of data required for export 
* Select format (.txt, .csv, .xls) and press export
* Alternatively, manually select entries from the table and copy (ctrl+c)

### 2.3 MATLAB data export (MATLAB app only)
* From the ‘Plot 1’ dropdown select ‘data’ 
* From the desired format dropdown box select ‘MATLAB Workspace’
* Press the Export button
* Data will appear in the MATLAB workspace
