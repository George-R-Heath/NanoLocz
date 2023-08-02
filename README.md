<meta name="google-site-verification" content="IWX1VPcWKI5YV0hYlbNPSuaXoQ5yva_cm-kQpu8gc5I" />

# NanoLocz <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/ecb7d878-0bfa-4d41-8b0e-16309cd8be42" width="50">
Atomic Force Microscopy Analysis Platform.

Currently at pre-release stage so expect some errors and bugs

* 21.07.2023 - NanoLocz v1.02 has increased compatibility to MATLAB 2020a onwards. Issues with using pre MATLAB 2023a when running the app in MATLAB
* 25.07.2023 - Update to Windows Desktop version to fix error message: 'Undefined function 'thresholder' for input...'
* 02.08.2023 - Update to MATLAB app to fix bug when opening app processed images
## About NanoLocz
*NanoLocz* is a free interactive AFM image viewer and analysis platform. It's designed for browsing and analysing
height data from AFM and HS-AFM imaging with the aim of increasing throughput.

**Capabilities:**
* Read AFM file types: .spm,  .asd,  .jpk,  .ibw,  .ARIS,  .tiff
* Image Levelling 
* Line Profiling  
* Video Alignment 
* Particle Detection (height or reference based)
* Single Particle Tracking
* Particle Alignment
* *Localization AFM*
* Export as: .tiff, .gif, .avi, .png, .jpeg, .pdf, .txt, .csv, .xls

**Compatible file types:**  .spm,  .asd,  .jpk,  .ibw,  .ARIS,  .tiff.... more being added\
please request (to g.r.heath@leeds.ac.uk) if your preferred file format is not here

## NanoLocz Pre-Release Install:
Options for Install:
1. NanoLocz as MATLAB app - Requires MATLAB 2020a or newer + Toolboxes
2. NanoLocz for Mac
3. NanoLocz for Windows

Option 1. NanoLocz as MATLAB app:
Open 'Install_NanoLocz_v1_02.mlappinstall' file. This will open MATLAB if not already open and ask you to install. 
Once installed the app can be used from the apps tab. For quick access right click the NanoLocz app to add to 
Favourites and/or Quick Access Toolbar.\
**MATLAB app requirements:** MATLAB 2020a (the newer the better), Curve Fitting Toolbox, Image Processing Toolbox, Signal Processing Toolbox, Statistics and Machine Learning Toolbox.

Option 2. NanoLocz for Mac:
Open 'Install file' folder and open 'MyAppInstaller_web' -> follow the install instructions in popup.

Option 3. NanoLocz for Windows:
Open 'Install file' folder and open 'MyAppInstaller_mcr.exe' -> follow the install instructions in popup.

Note: loading on start-up of the app can take ~1min for Mac/Windows versions

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
   * If using the Localization Atomic Force Microscopy method please cite:\
[Heath, G.R., Kots, E., Robertson, J.L. et al. Localization atomic force microscopy. Nature 594, 385–390 (2021)]

A preprint describing the *NanoLocz* workflow will be uploaded soon... 

[GNU GPL v3.0]: http://www.gnu.org/licenses/gpl-3.0.txt
[Heath, G.R., Kots, E., Robertson, J.L. et al. Localization atomic force microscopy. Nature 594, 385–390 (2021)]: https://doi.org/10.1038/s41586-021-03551-x
