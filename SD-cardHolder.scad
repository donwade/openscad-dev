//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>


/* [Hidden] */

x = 25;   // SDCARD 
y = 2.07 * 7 + 1;      // SDCARD
z = 20;

$fn=60;   //circle quantize 360/10=36 degrees per side

wall = +2;

// container for the SDCARD
SDCARD_outside = [ x, y, z];

module build_SDCARD()
{
    // container for the SDCARD
    abox( SDCARD_outside, thick = +2, round_out=1, round_in=1, bCentered = false);

 }

build_SDCARD();
 