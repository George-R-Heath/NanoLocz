---
layout: default
title: Keyboard Shortcuts
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
  
#shortcut-table {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#shortcut-table th, #shortcut-table td {
  border: 1px solid #888; /* lighter border for visibility */
  padding: 8px;
  color: white; /* ensures text is visible */
  vertical-align: middle;
}


#shortcut-table tr:nth-child(even) {
  background-color: #2a2a2a;
}

#shortcut-table tr:nth-child(odd) {
  background-color: #1c1c1c;
}

#shortcut-table tr:hover {
  background-color: #000000;
}
</style>

## [NanoLocz User Guide 1.3-1.4](https://george-r-heath.github.io/NanoLocz/docs/) <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/36d664a6-38e2-4405-b5cc-a962093cf13b" width="30">

<a href="installation1_3.html">Installation</a> - - <a href="getting_started1_3.html">Getting Started</a> - - <a href="saving_data1_3.html">Saving Data</a> \
<a href="image_levelling1_3.html" style="color: red;">Level</a> - - 
<a href="particle_detection1_3.html" style="color: lightblue;">Detect</a> - - 
<a href="fine_align1_3.html" style="color: orange;">FineAlign</a> - - 
<a href="localize1_3.html" style="color: pink;">Localize</a>\
<a href="area_analysis1_3.html" style="color: limegreen;">Area Analysis</a> - - <a href="keyboard_shortcuts1_3.html">Keyboard Shortcuts</a>\
<a href="simulation_afm1_3.html" style="color: orange;">Simulation AFM</a> - - <a href="general_use1_3.html">YouTube Video Tutorials</a> 

# Keyboard Shortcuts

This section lists the keyboard shortcuts available in NanoLocz.

You may need to click the grey or white background of NanoLocz GUI for key shortcuts to register 
(Keyboard shortcuts may only work when a button/dropdown or panel are not selected).

<table id="shortcut-table">
  <tr>
    <th>Key</th>
    <th>Modifier</th>
    <th>Action</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Return</td>
    <td></td>
    <td>Accept</td>
    <td>Triggers the "Accept" button</td>
  </tr>
  <tr>
    <td>Delete / Backspace</td>
    <td></td>
    <td>Delete</td>
    <td>Triggers the "Bin" button</td>
  </tr>
  <tr>
    <td>→</td>
    <td></td>
    <td>Next Frame</td>
    <td>Advance one video frame</td>
  </tr>
  <tr>
    <td>←</td>
    <td></td>
    <td>Previous Frame</td>
    <td>Go back one video frame</td>
  </tr>
  <tr>
    <td>↓</td>
    <td></td>
    <td>Lower Contrast</td>
    <td>Shift both contrast bounds down</td>
  </tr>
  <tr>
    <td>↓</td>
    <td>Shift</td>
    <td>Expand Contrast</td>
    <td>Decrease min, increase max contrast</td>
  </tr>
  <tr>
    <td>↑</td>
    <td></td>
    <td>Raise Contrast</td>
    <td>Shift both contrast bounds up</td>
  </tr>
  <tr>
    <td>↑</td>
    <td>Shift</td>
    <td>Contract Contrast</td>
    <td>Increase min, decrease max contrast</td>
  </tr>
  <tr>
    <td>X</td>
    <td>Shift</td>
    <td>Crop</td>
    <td>Triggers the "Crop" tool</td>
  </tr>
  <tr>
    <td>K</td>
    <td></td>
    <td>Profile Tool</td>
    <td>Selects the "Profile" drawing tool</td>
  </tr>
  <tr>
    <td>R</td>
    <td></td>
    <td>ROI Tool</td>
    <td>Selects the "ROI" drawing tool</td>
  </tr>
  <tr>
    <td>A</td>
    <td></td>
    <td>Average Tool</td>
    <td>Selects the "Average" drawing tool</td>
  </tr>
  <tr>
    <td>+</td>
    <td></td>
    <td>+ Mask</td>
    <td>Add to mask drawing tool</td>
  </tr>
  <tr>
    <td>-</td>
    <td></td>
    <td>- Mask</td>
    <td>Subtract from mask drawing tool</td>
  </tr>
  <tr>
    <td>L</td>
    <td></td>
    <td>Line Tool</td>
    <td>Selects "Line" shape for drawing</td>
  </tr>
    <tr>
    <td>Draw Line</td>
    <td>Shift</td>
    <td>Snap to nearest 45</td>
    <td>For drawing straight profiles</td>
  </tr>
  <tr>
    <td>S</td>
    <td></td>
    <td>Square Tool</td>
    <td>Selects "Square" shape for drawing</td>
  </tr>
  <tr>
    <td>C</td>
    <td></td>
    <td>Circle Tool</td>
    <td>Selects "Circle" shape for drawing</td>
  </tr>
  <tr>
    <td>F</td>
    <td></td>
    <td>Freehand Tool</td>
    <td>Selects "Freehand" shape for drawing</td>
  </tr>
</table>


Feel free to suggest new shortcuts for future versions of NanoLocz.
