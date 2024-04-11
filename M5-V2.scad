//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

M5_is_leftsided  = true;
laptop_frame_horiz = 13;
laptop_frame_depth = 5.67;
laptop_frame_vert = 45.1;

/* [Hidden] */

punch = $preview ? 2: 0;

x = 54.1;   // M5 
y = x;      // M5
z = 8;      // covers some connectors.

$fn=60;   //circle quantize 360/10=36 degrees per side

wall = +2;

// container for the M5
M5_outside = [ x, y, z];
M5_middle = [ x/2, y/2, z/2];

// part that chomps the laptop
pacman = [ x/2, y, 16];
pacman_mouth = [ laptop_frame_horiz, laptop_frame_vert, laptop_frame_depth];

module build_M5()
{
    // container for the M5
    abox( M5_outside, thick = +2, bRoundOut=true, bRoundIn=true, centered = false);

    // make the pacman
    translate([-laptop_frame_horiz, 0, -pacman.z])
    difference()
    {
        abox( pacman, thick = +2, bRoundOut=true, bSolid=true, centered = false);
        translate([pacman_mouth.x/2 + wall , pacman_mouth.y/2 + wall, pacman.z/2])
        #abox( pacman_mouth, thick = +2, bSolid = true, bRoundOut = false, centered = true);
    }    
 }

if (M5_is_leftsided)
{
    mirror([ 0, 0, 1])
    build_M5();
}    
else
    build_M5();
