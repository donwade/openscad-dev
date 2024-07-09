use <myTools.scad>
/*
module tube (r = 0, d = 0, l = 0, 
            thick = 0, 
            bCentered = true, 
            taper_pct = 0, 
            circlip = false) // r=radius d=dia l=length ;
*/
$fn=100;
DIA=11.50 - .1;
BAT_THICKNESS = 3;
NUM = 11;
            
tube (d = DIA, l = NUM * BAT_THICKNESS, thick = +3, bCentered = false, taper_pct = 0, circlip = true);

