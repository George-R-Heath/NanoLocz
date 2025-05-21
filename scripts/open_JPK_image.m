% Modified version of: open_JPK.m
% 
% Ortuso, Roberto D., Kaori Sugihara.
% "Detailed Study on the Failure of the Wedge Calibration Method at Nanonewton Setpoints for Friction Force Microscopy." The Journal of Physical Chemistry C 122.21 (2018): 11464-11474.
% Author: Dr. Ortuso, R.D.
% Adolph Merkle Institute, Fribourg, CH.
% Contact: roberto.ortuso@unifr.ch 


function [im,multi,offs]= open_JPK_image(afm_file,ch)

i = ch;
%if nargin <3
    file_info=imfinfo(afm_file);
    typpe_of_ch=file_info(i).UnknownTags(find([file_info(i).UnknownTags.ID]==32897)).Value;

    if(strcmp(typpe_of_ch,'nominal')||(strcmp(typpe_of_ch,'voltsamplitude')))
        m_ID=33028;
        off_ID=33029;
    elseif ((strcmp(typpe_of_ch,'force'))||(strcmp(typpe_of_ch,'calibrated'))||(strcmp(typpe_of_ch,'distanceamplitude')))
        m_ID=33076;
        off_ID=33077;
    elseif(strcmp(typpe_of_ch,'volts'))
        typpe_of_ch_det=file_info(i).UnknownTags(find([file_info(i).UnknownTags.ID]==32848)).Value;
        if(strcmp(typpe_of_ch_det,'capacitiveSensorXPosition'))||(strcmp(typpe_of_ch_det,'servoDacY'))||(strcmp(typpe_of_ch_det,'servoDacX'))||(strcmp(typpe_of_ch_det,'capacitiveSensorYPosition'))
            m_ID=33028;
            off_ID=33029;
        else
            m_ID=32980;
            off_ID=32981;
        end
    else
        m_ID=32980;
        off_ID=32981;
    end

    multi = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==m_ID).Value;
    offs = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==off_ID).Value;
%end
%im = (single(imread(afm_file,ch))*multi)+offs;
im = imread(afm_file,ch);
end


        
