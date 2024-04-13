//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */
$fn=10;   //circle quantize 360/10=36 degrees per side
 tube  (d = 44.7,       // tight diameter of tube
        l = 20,         // length 20mm
        thick = +3,     // minimum wall thickness
        centered = false, // keep logic in postive z 
        taper_pct = 30, // fatten base by 30%
        circlip = true  // cut a thin line for expansion);
        );
        