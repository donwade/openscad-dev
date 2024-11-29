use <myTools.scad>

INSIDE = [ 29.62, 25-1, 50];
THICK = 3;

/*
module tube (r = 0, d = 0, l = 0, 
            thick = 0, 
            bCentered = true, 
            taper_pct = 0, 
            circlip = false) // r=radius d=dia l=length 
*/
color("GREEN")
for (DIA = [19:1:25])
{
    translate([30 * (DIA-19), 0, 0])
    tube( d = DIA, thick =-2, l = 10); 
}