---
layout: default
title: Image Levelling
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

## [NanoLocz User Guide 1.3-1.4](https://george-r-heath.github.io/NanoLocz/docs/) <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/36d664a6-38e2-4405-b5cc-a962093cf13b" width="30">

<a href="installation1_3.html">Installation</a> - - <a href="getting_started1_3.html">Getting Started</a> - - <a href="saving_data1_3.html">Saving Data</a> \
<a href="image_levelling1_3.html" style="color: red;">Level</a> - - 
<a href="particle_detection1_3.html" style="color: lightblue;">Detect</a> - - 
<a href="fine_align1_3.html" style="color: orange;">FineAlign</a> - - 
<a href="localize1_3.html" style="color: pink;">Localize</a>\
<a href="area_analysis1_3.html" style="color: limegreen;">Area Analysis</a> - - <a href="keyboard_shortcuts1_3.html">Keyboard Shortcuts</a>\
<a href="simulation_afm1_3.html" style="color: orange;">Simulation AFM</a> - - <a href="general_use1_3.html">YouTube Video Tutorials</a> 

# Image Levelling
![image](https://github.com/user-attachments/assets/10695695-7bf1-4a14-8aab-99722f52b676)

### Manual Leveling
**Plane Leveling:**\
To remove tilt or bow in images:
* Set the x and y <a style="color:orange"> Plane</a> values to perform polynomial fitting to all the x and/or y values in each image.
* Plane fitting is previewed in real-time.
* Press the 'Accept' button to apply.
* Tip: X and Y values of 1 will remove linear tilt, values of 2 or more can remove image bow.
  
**Line Leveling:**\
To remove height variations between scan lines:
* Set the x and y <a style="color:limegreen"> Line</a> values to perform polynomial fitting to each image line in x and/or y.
* Line fitting is previewed in real-time.
* Press the 'Accept' button to apply.
* Tip: use '-Med' to remove the median of each line in x.
  
**Line or Plane Leveling with a Mask:**\
To level images and movies that contain a variety of height levels requires certain regions (referred to as masked regions) to be excluded from the polynomial fits. Typically the included region should be a surface which is expected to be level and has a high coverage (>50%).
The options to generate a mask are:
1) Using the upper and lower threshold values on the height histogram
2) Manually drawing using the **Draw Mask** button
3) Using the 'Mask with z-scale' to mask values outside of the colormap scale
4) Automatically using the Otsu method
5) Automatically using the **Fit** button (fits a Gaussian to all the values in the movie and using 1.5σ (standard deviation) as the threshold values.)
* To level with a mask, line leveling or plane leveling is then performed as before but fitting is performed using only the non-masked values.
* Press the 'Accept' button to apply.
---
### 🛠 Automatic Leveling Routines
NanoLocz provides several pre-configured **automatic leveling routines** to standardize and correct height data across AFM image stacks. These routines are tailored for different sample features.

#### `plane-line`
- **Steps**:
  - Subtracts a best-fit plane (x and y directions).
  - Applies a median line subtraction in x.
#### `multi-plane-edges`
- **Purpose**: Edge-based masking for step detection -> useful if there are multiple flat surfaces
- **Steps**:
  - Plane subtraction.
  - Median line if vertical variation dominates.
  - Edge detection masking → used to apply weighted plane and line leveling multiple times.
  - Final mean-plane subtraction.

#### `multi-plane-otsu`
- **Purpose**: Uses Otsu method to generate edge masks for multi plane fitting -> useful if there are multiple flat surfaces
- **Steps**:
  - Plane subtraction.
  - Median line subtraction if vertical variance exceeds threshold.
  - Otsu edge masks applied iteratively for plane/line subtraction.
  - Final mean-plane subtraction.

#### `iterative 1nm high`, `iterative -1nm low`, `iterative high low`
- **Purpose**: Removes features above/below a fixed height.
- **Steps**:
  1. Plane subtraction.
  2. Line subtraction if vertical variance dominates.
  3. Iteratively thresholds using fixed z-limits and reapplies plane and median line subtraction with masking.

#### `Line1 + Otsu Line2`
- **Steps**:
  - Subtracts a linear line fit (first pass).
  - Applies Otsu thresholding to mask and subtracts a stronger 2nd order line fit.

####  `high-low x2 (fit)`
- **Purpose**: Uses Gaussian fitting on the histogram to determine leveling thresholds.
- **Steps**:
  - Initial plane + median line subtraction.
  - Histogram of z-values fitted with Gaussian.
  - Mask generated for values within ±1.5σ.
  - Leveling reapplied with mask.

#### `iterative fit holes`, `iterative fit peaks`
- **Purpose**:
  - *Holes*: For images with lower-intensity defects.
  - *Peaks*: For images with higher protrusions.
- **Steps**:
  1. 2nd-order plane fit + median line subtraction.
  2. Gaussian fit on z-values → ±1.5σ mask (shifted for holes or peaks).
  3. Repeat leveling with mask.
  4. Generate new mask and repeat.
  5. Final 1st-order line subtraction with mask.
---

### Choosing the Right Routine

- **Flat surfaces with sparse particles** → `iterative 1nm high` or `high-low x2 (fit)`
- **Surfaces with pits/defects** → `iterative fit holes`
- **Surfaces with sharp peaks** → `iterative fit peaks`
- **Samples with more than 1 plane** → `multi-plane-edges` or `multi-plane-otsu`
- **General leveling** → `plane-line` or `Line1 + Otsu Line2`


## YouTube video on Leveling + Area Analysis
[![YouTube NanoLocz Leveling + Area Analysis](https://img.youtube.com/vi/R5D6T04M7Rc/0.jpg)](https://www.youtube.com/watch?v=R5D6T04M7Rc)
