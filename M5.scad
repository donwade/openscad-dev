//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>
punch = $preview ? 2: 0;

x = 54.1;
y = x;
z = 8;

wall = +2;


/* [Hidden] */
$fn=60;   //circle quantize 360/10=36 degrees per side
M5_outside = [ x, y, 8];
M5_middle = [ x/2, y/2, z/2];

module hi_level()
{
    abox( M5_outside, thick = +2, bRoundOut=true, bRoundIn=true, centered = false);
    HOOK_THICK = 3;
    HOOK_OPEN = 8.22 + .5;
    HOOK_outside = [ x, y, HOOK_OPEN *2 + HOOK_THICK];

    rotate([0, 179, 0]) // 179 tilt 1 degree in 
    translate([-(x + wall*2), 0, 0])
    difference()
    {
        color("GREEN")
        abox( HOOK_outside + [ wall *2, wall*2, 0] , thick= -12, bRoundOut=true, bRoundIn=true, centered = false);  // 50x25x10 box inside dim origin has 0,0

        translate([-5.,-.5 , HOOK_outside.z/4])
        color("RED")
        scale([1,1,.5])
        #cube(HOOK_outside + [wall *2  , wall *2 + 1 , -2], center = false);
        
        
    }
 }
 
 difference()
 {
    hi_level();
    translate(M5_middle + [ 0, 0, -25])
    #cylinder(h = 40, d= 20);
 }