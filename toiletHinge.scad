//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */

x = 41.2; // TOILET 
y = 60.0 - 16; // TOILET
z = 7.5; 

$fn=60;   //circle quantize 360/10=36 degrees per side

// container for the TOILET
TOILET_outside = [ x, y, z];

module build_TOILET()
{
    difference()
    {
        // container for the TOILET
        abox( TOILET_outside, thick = -2, bRoundOut=4, bSolid = true, centered = false);

        DIA=9.5;
        
        hull()
        {
            color("RED")
            translate ([x/2  , 11.48 + DIA/2, -.1])
            {
                cylinder(d = DIA, h = 10, center = false);
                
                color("GREEN")
                translate ([0 , 16.46 - DIA, 0])
                cylinder(d = DIA, h = 10, center = false);
            }
        }
    }
 }

build_TOILET();
