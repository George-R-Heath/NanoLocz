
[![View NanoLocz on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/154880-nanolocz)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Static Badge](https://img.shields.io/badge/DOI%3A-10.1002%2Fsmtd.202301766-orange?style=flat&cacheSeconds=https%3A%2F%2Fdoi.org%2F10.1002%2Fsmtd.202301766)]( https://doi.org/10.1002/smtd.202301766)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/George-R-Heath/NanoLocz/total)

# NanoLocz <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/ecb7d878-0bfa-4d41-8b0e-16309cd8be42" width="50">
Atomic Force Microscopy Analysis Platform.

**15.05.2024 - NanoLocz Version 1.20 Update:**
* **Processing speed** - Improved app start-up speed + speed increases for Particle Detection, LAFM and Particle Assembly steps
* **AutoSaving** - Choose output folder and preferred file format 1st
* **Improved Saving** - Including batch export
* **Batch levelling** - Set levelling options (auto or manual) in preview mode and then run batch save
* **HDF5 (.h5) export/input** - A more accessible file format (can be opened with Python)
* **Set Preferences** - NanoLocz remembers preferred Output/Input folders and other settings
* **Jpk file opener** - Error fixed
* **asd file opener** - Reading of 'Only Trace Imaging' files enabled 
* **Line Profile snap to angle** - Hold 'shift' when drawing line profiles to snap to the nearest 45 degrees 
* **New pre-set auto levelling options** 
* **Recalculate correlation button** - recalculates the correlation between particles and the selected reference image, useful for excluding poorly matching particles after Fine Align (Fine align tab)

**01.03.2024 - Full Article Released in *Small Methods*:** [https://doi.org/10.1002/smtd.202301766](https://doi.org/10.1002/smtd.202301766) 

**01.03.2024 - NanoLocz Version 1.10 Update:**
* General: bug fixes, more colormaps, stacking of images/video with different pixel dimensions.
* File Openers: .asd file heights corrected. 
* Simulation AFM: Parachuting option added.
* LAFM: Improved localization precision, improved auto centre for symmetrisation, height scale in nm.
* New filter: remove scars/scratches.
  
23.11.2023 - Preprint Released on BioRxiv - [Link](https://www.biorxiv.org/content/10.1101/2023.11.23.568405v1) \
Full Software version 1.0 released - Go to [Releases](https://github.com/George-R-Heath/NanoLocz/releases) to download the latest version \
Includes several updates to file openers, stability, speed and new features.

## About NanoLocz
*NanoLocz* is a free interactive AFM image viewer and analysis platform. It's designed for browsing and analysing
height data from AFM and HS-AFM imaging with the aim of increasing throughput. see [User Guide here!](NanoLocz-User-Guide.md)

**Capabilities:**
* Read AFM file types: .spm,  .asd,  .jpk,  .ibw,  .ARIS,  .tiff, .nhf, .gwy
* Image Levelling 
* Line Profiling  
* Video Alignment
* Simulation AFM
* Mask Analysis
* Particle Detection (height or reference based)
* Single Particle Tracking
* Particle Alignment
* *Localization AFM*
* Export as: .tiff, .gif, .avi, .png, .jpeg, .pdf, .txt, .csv, .xls

**Compatible file types:**  .spm,  .asd,  .jpk,  .ibw,  .ARIS,  .tiff, .nhf, .gwy.... more being added\
please request (to g.r.heath@leeds.ac.uk) if your preferred file format is not here
## [Link to User Guide](NanoLocz-User-Guide.md)

## NanoLocz Install - Go to [Releases](https://github.com/George-R-Heath/NanoLocz/releases):

Note: loading on start-up of the app can take ~1min for Mac/Windows versions\
Options for Install:
1. Install as Mac desktop app download: Mac_AppInstaller_mcr.app.zip
2. Install as Windows desktop app download: Windows_AppInstaller_mcr.exe
3. Install as MATLAB app download: NanoLocz.mlappinstall
Open 'NanoLocz.mlappinstall' file. This will open MATLAB if not already open and ask you to install. 
Once installed the app can be used from the apps tab. For quick access right click the NanoLocz app to add to 
Favourites and/or Quick Access Toolbar.\
**MATLAB app requirements:** MATLAB 2020a (the newer the better), Curve Fitting Toolbox, Image Processing Toolbox, Signal Processing Toolbox, Statistics and Machine Learning Toolbox, Bioinformatics Toolbox, Computer Vision Toolbox.

## Disclaimer:
THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE
USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contributing

Contributions are extremely welcome.

## License

Distributed under the terms of the [GNU GPL v3.0] license,
"NanoLocz" is free and open source software

## Publications
* If using the NanoLocz software please cite:\
[Heath, G.R, Micklethwaite, E. and Storer, T.M.\
NanoLocz: Image analysis platform for AFM, high-speed AFM and localization AFM.\
*Small Methods* 2024, 2301766.](https://doi.org/10.1002/smtd.202301766) 

* If using the Localization Atomic Force Microscopy method please cite:\
[Heath, G.R., Kots, E., Robertson, J.L. et al.\
Localization atomic force microscopy.\
 Nature 594, 385–390 (2021)](https://doi.org/10.1038/s41586-021-03551-x)

[GNU GPL v3.0]: http://www.gnu.org/licenses/gpl-3.0.txt
[Heath, G.R., Kots, E., Robertson, J.L. et al. Localization atomic force microscopy. Nature 594, 385–390 (2021)]: https://doi.org/10.1038/s41586-021-03551-x
