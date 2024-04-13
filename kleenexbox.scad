//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */
MM=25.43;

x = (8 + 15/16) * MM; 
y = (4 + 3/4) * MM - 2;
z = (3 + 0 ) * MM;     

$fn=60;   //circle quantize 360/10=36 degrees per side

// container for the KLEENEX
KLEENEX_outside = [ x, y, z * 3/4];

module build_KLEENEX()
{
    difference()
    {
        // container for the KLEENEX
        abox( KLEENEX_outside, thick = +2.2, round_out =2, round_in = 2, bCentered = true);
        translate([0,0, z/7])
        {
            #cube ([ x /2 , y * 2, z/2], true);
            #cube ([ x *2 , y / 2, z/2], true);
        }
        //#cylinder(h = z+1, d = 20);
    }
 }

build_KLEENEX();
 
// make 'stand'
 j = 25.4;
 
translate([0, 0, y/2])
{
    difference()
    {
        cube([ j, j, x]);

        translate( [0, 0, 0])
        rotate([ 0, 26, 0])
        #cube([ j, j, y]);
    }
} 
