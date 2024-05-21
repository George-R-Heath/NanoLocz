---
layout: default
title: Particle Detection
---
# Particle Detection

Two methods are implemented for particle detection using either template matching image correlation to a reference image (ROI method) or local maxima (peak method). Once particles have been detected particle tracking can be run on their coordinates.

[1. ROI Method](#1-roi-method)\
[2. Peak Method](#2-peak-method)\
[3. Particle Tracking](#3-particle-tracking)


## 1. ROI Method
The ROI (region of interest) method uses image cross-correlation of a reference image with the full image or video data set to detect particles with high correlation.
-	After levelling your image/movie select the detect tab
-	Select ROI as the detection method
-	Select a reference image using either of the following methods:\
**Manual selection**: Select any of the <a style="color:orange"> Orange Square icons</a> and then manually draw a square around a representative particle in your AFM data. \
**Simulated Selection**: Open Simulation AFM by selecting Tools -> Simulation AFM. Import the pdb of the expected structure. Orientate the molecule and alter the tip radius to match the expected orientation and tip size in the AFM images. Select ‘Export to NanoLocz’.
-	Select <a style="color:red">Find Particles.</a> 

![ROI detect](https://github.com/George-R-Heath/NanoLocz/assets/90329395/ab594b69-2f8e-4e80-886d-1753d8cb570d)

-	Particle detections can be viewed using the *Overlay Plot* options.
-	If too many particles have been picked - use the lower limit slider in the *Filter detections* histogram to selectively exclude particles with lower correlation to the reference image.

### Detection Options:
- **Exclude Edges:** Exclude picking features at the edge of images.\
- **Fast find:** Images are down sampled by x2 to increase picking speed. Not recommended for reference images with low pixel count.\
- **Filter xcor image:** Apply a Gaussian filter to the cross-correlation image to reduce over picking/\
- **Filter image:** Apply a Gaussian filter to the image to reduce over picking (filtered image is only used for detection and does not change the data).

### Reference Tab Options:
- **Allow rotation:** To detect different rotations of a particle the detection can be run with rotation enabled, in this mode the cross-correlation is run with different rotations of the reference image to different angles. Enter the values as (starting angle):(interval):(final angle), for example -20:10:20 will perform detection at -20, -10, 0, 10 and 20 degrees reference rotation. Angles be further refined after defection using FineAlign. 
- **Centre Reference:** Centre the reference image based on symmetry. If symmetry = 1 centring will be performed using the centre of mass.
- **Average Reference:** Take the image average of all included detections. If required this average image can be then used as a new reference image to refine the particle detection. 
- **Rotational Avg:** Take rotational average image based on the user defined symmetry value. 

![reference](https://github.com/George-R-Heath/NanoLocz/assets/90329395/7914b180-9273-4e9c-87eb-625fa8fe271e)


## 2. Peak Method

![peak detect](https://github.com/George-R-Heath/NanoLocz/assets/90329395/f74a874d-15a6-4e2e-8b1a-83c5739c3aa4)

## 3. Particle Tracking
