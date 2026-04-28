use <myTools-extended.scad>
$fn = $preview ? 50 : 120;

//DEBUG= $preview ? 0 : 1;
DEBUG= 1;
//=================================================
TWEAK = .5;

DIA=72.13 + TWEAK;
HT = 4;

cylinder(h=HT, d=DIA);
translate([0,0,HT])
cylinder(h=HT*2, d= 28);

OUTSIDE = 64.5;
INSIDE = 52.5;

DRILL_DIA = (OUTSIDE-INSIDE)/2;  // b/n 2 holes
RADIUS= (INSIDE /2 + DRILL_DIA/2);


for ( ROT = [ 0: 360/12: 359 ])
{
    if ( ROT == 0 || ROT == 360/3 || ROT == 360 * 2/3)
    {
        echo ("                   SKIP = ", ROT);
    }
    else
    {
        echo ("DRILL = ", ROT, "RADIUS = ", RADIUS, "DIA = ", DRILL_DIA);
        rotate([ 0, 0, ROT])
        translate([0, RADIUS, 0])
        cylinder(h= HT*3, d=DRILL_DIA - TWEAK);
    }
}   

