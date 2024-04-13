//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */


TWEAK=.25;
WALL = 2;

x = 18.28;  // camera mount.
y = 18;     // camera mount
z = 1.9 ;  // camera mount.   
long = 140;  // arbitrary

$fn=120;   //circle quantize 360/10=36 degrees per side

// make sight
Wave_insideDIM = [ x, y, z ];


// make pedestal
rotate([90, 0, 90])
translate([-x/2, 0, -x/2 -4 ])
{
    #cube(Wave_insideDIM, center = false);
}

// make a stump between pedestal and sight
rotate([90, 0, 90])
translate([-6, 0, -x/2 - 2.2 ])
{
    #cube([12,18, 4], center = false);
}


difference()
{
    cylinder(h = long,d = x);
    cylinder(h = long, d = 7);
}
