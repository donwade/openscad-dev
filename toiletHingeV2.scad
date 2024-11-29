//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */

x = 41.2; // TOILET 
y = 60.0 - 16; // TOILET
z = 7.5; 

$fn=60;   //circle quantize 360/10=36 degrees per side

// container for the TOILET
TOILET_outside = [ x, y, z];

BOLT_DIA=9.5;


module build_TOILET(POST_DIA = 20)
{
    difference()
    {
        union()
        {
            // container for the TOILET
            abox( TOILET_outside, thick = -2, 
                    round_out=4, 
                    bSolid = true, 
                    bCentered = false);
                    
            translate ([x/2  , 11.48 + BOLT_DIA/2, TOILET_outside.z])
            cylinder(d = POST_DIA, h = 13 - 2, center = false);
        
                    
        }
        
        translate ([x/2  , 11.48 + BOLT_DIA/2, -.1])
        cylinder(d = BOLT_DIA, h = 50, center = false);
        
    }
 }

build_TOILET(POST_DIA = 13.90);
translate([ 50, 0, 0])
build_TOILET(POST_DIA = 13.18);
