---
layout: default
title: Area Analysis
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

</style>

## [NanoLocz User Guide 1.3](https://george-r-heath.github.io/NanoLocz/docs/) <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/36d664a6-38e2-4405-b5cc-a962093cf13b" width="30">

<a href="installation1_3.html">Installation</a> - - <a href="getting_started1_3.html">Getting Started</a> - - <a href="saving_data1_3.html">Saving Data</a> \
<a href="image_levelling1_3.html" style="color: red;">Level</a> - - 
<a href="particle_detection1_3.html" style="color: lightblue;">Detect</a> - - 
<a href="fine_align1_3.html" style="color: orange;">FineAlign</a> - - 
<a href="localize1_3.html" style="color: pink;">Localize</a>\
<a href="area_analysis1_3.html" style="color: limegreen;">Area Analysis</a> - - <a href="keyboard_shortcuts1_3.html">Keyboard Shortcuts</a>\
<a href="simulation_afm1_3.html" style="color: orange;">Simulation AFM</a> - - <a href="general_use1_3.html">YouTube Video Tutorials</a> 

# Area Analysis 
This section explains how to perform area analysis in NanoLocz using threshold masking.

## Creating a Mask
The area analysis method in NanoLocz is based on calculating information within a Mask (area you want to analyse). For accurate analysis ensure that the images are <a href="image_levelling.html" style="color: red;"> levelled </a> correctly before proceeding. 
- To generate a Mask select the ‘Level Tab’ and set the (Mask – Z-Scale) option to Mask.
- Select the 'Method' you want to use to create the Mask. The default is ‘Histogram’ which is manual thresholding method. Thresholding can also be done automatically using the Otsu method.
- If using the ‘Histogram’ method, move the upper limit and lower limit sliders to select the area to be analysed.
- If there are multiple frames the Mask histogram will use all the heights from all frames in a movie.
- The example below shows masking of the lower regions using the histogram sliders. 
  
![hist area](https://github.com/George-R-Heath/NanoLocz/assets/90329395/69d9f331-0d03-4617-ae07-77e7a103b6f3) ![area analysis eg](https://github.com/George-R-Heath/NanoLocz/assets/90329395/14a6de4b-7294-4849-b8de-e7811ad76572)

## Creating a Mask
- Once the Mask has been selected -> press the '<span style="color: red;">Analyze Mask</span>' button.
- This will bring up the following window with options to edit the Mask:\
**Minimum Size:** removes Mask regions with a pixel area below the value\
**Erode:** Reduces the size of objects by removing pixels on object boundaries.\
**Dilate:** Increases the size of objects by adding pixels to object boundaries.\
**Open:** Removes small objects by eroding and then dilating the mask.\
**Close:** Fills small holes by dilating and then eroding the mask.\
**Fill holes:** Fills in small holes within objects in the mask.\
- To edit the Mask select the values in each option and run **Update Mask**
- Once the Mask is ready select the parameters you want to include in the analysis and run '<span style="color: red;">Analyze Mask</span>'.

![area analysis](https://github.com/George-R-Heath/NanoLocz/assets/90329395/d4e472c4-8dff-43ac-ac53-575e519ca425)

- This will open the plotter window where you can access the data tables and plot data either as frame averages/totals or individual particles per frame.
  
![plotter](https://github.com/George-R-Heath/NanoLocz/assets/90329395/95f08392-cd0c-4625-84b4-a384b41f7935)

## YouTube video on Leveling + Area Analysis
[![YouTube NanoLocz Leveling + Area Analysis](https://img.youtube.com/vi/R5D6T04M7Rc/0.jpg)](https://www.youtube.com/watch?v=R5D6T04M7Rc)
