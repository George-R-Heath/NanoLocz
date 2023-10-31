% Modified version of: open_JPK.m
% 
% Ortuso, Roberto D., Kaori Sugihara.
% "Detailed Study on the Failure of the Wedge Calibration Method at Nanonewton Setpoints for Friction Force Microscopy." The Journal of Physical Chemistry C 122.21 (2018): 11464-11474.
% Author: Dr. Ortuso, R.D.
% Adolph Merkle Institute, Fribourg, CH.
% Contact: roberto.ortuso@unifr.ch 


function im = open_JPK_image(afm_file,ch)
file_info=imfinfo(afm_file);    
m_ID = 32980;       off_ID = 32981;
multi = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==m_ID).Value;
offs = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==off_ID).Value;
im = (single(imread(afm_file,ch))*multi)+offs;
end         


        
