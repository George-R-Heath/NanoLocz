---
layout: default
title: Localize
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

# Localize 

This section explains how to perform localization AFM of particles in NanoLocz.

Localization AFM is a technique that enhances spatial resolution by localizing z fluctuations over multiple images. For more information see the [Localization AFM publication](https://www.nature.com/articles/s41586-021-03551-x)

The resolution of Localization AFM relies on accurate pre-processing and alignment of detected particles. See steps level, detect and FineAlign before performing Localize. 

### Step 1. Localizing peaks
- Turn on preview peaks
- Adjust the height threshold to exclude background surface peaks 
- select a Gaussian low pass value to reduce the detection of noisy peaks. For data with low pixel sampling use lower Gaussian values (0.2-0.6) for highly sampled data a higher Gauss can be used (0.6-2).
- Turn on boost subpix
- Run Find All Peaks

### Step 2. Render LAFM
- After finding All Peaks select an expand value to determine the pixel grid size for the resulting LAFM image. Low pixel sampling may require larger expansion, 5-7x, whilst high sampling may only require 3-5x. If the LAFM image appears pixelated increase the expansion factor.
- select a image Gaussian value to determine the render size of each localization. If the LAFM image appears noisy increases the image Gauss. If it appears blurry or over filtered decrease the image Gauss

### Step 3. Tune the rendering options 
- Use the LAFM panel to adjust colour map, height colour scaling and image contrast.
- If the LAFM image appears as one colour without any variation, decrease the colour max or increase colour min to select a range that more tightly spans the features of interest. Tuning on the z colour scale bar can help visualise the changes in colour max and min

### Step 4 LAFM refinements 
To increase the resolution it may be possible to further refine the particle alignment using FineAlign but aligning to LAFM as the reference image. To achieve this take the following steps:
- Render a grey LAFM image with low noise using a higher image Gauss and the grey LAFM colour scale. It can also help to decrease the colour max.
- Go to FineAlign and select LAFM ref in the reference tab. This should show the LAFM image in the current AFM colourscale. 
- Turn off *Auto update reference image* and turn off *Threshold with min height*.
- Press Run Align
- Check the image alignment and then return to Localize and repeat from Step 1 (Localize peaks) onwards.




## Intercalating Trace-Retrace + Single particle LAFM
[![YouTube NanoLocz Single particle LAFM](https://img.youtube.com/vi/90s_B0XYHmI/0.jpg)](https://www.youtube.com/watch?v=90s_B0XYHmI)

## Time Resolved LAFM
[![YouTube Time Resolved LAFM](https://img.youtube.com/vi/USl4qk6572U/0.jpg)](https://youtu.be/USl4qk6572U)
