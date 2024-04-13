//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */

x = 150 + 33.75; // BEAGLE 
y = 113; // BEAGLE
z = 9; 

$fn=60;   //circle quantize 360/10=36 degrees per side

// container for the BEAGLE
BEAGLE_outside = [ x, y, z];

module build_BEAGLE()
{
        // container for the BEAGLE
        abox( BEAGLE_outside, thick = +2.2, bRoundOut=2, bSolid = false, centered = false);
 }

build_BEAGLE();
