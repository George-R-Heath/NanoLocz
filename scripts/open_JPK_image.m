%  DESCRIPTION:   Function written for NanoLocz: Localization Atomic Force Microscopy Analysis Platform
%  AUTHOR:        George Heath, University of Leeds,   g.r.heath@leeds.ac.uk,   30.06.2023         


function im = open_JPK_image(afm_file,ch)
file_info=imfinfo(afm_file);    
m_ID = 32980;       off_ID = 32981;
multi = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==m_ID).Value;
offs = file_info(ch).UnknownTags([file_info(ch).UnknownTags.ID]==off_ID).Value;
im = (single(imread(afm_file,ch))*multi)+offs;
end         


        
