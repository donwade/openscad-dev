use <myTools.scad>
$fn=100;

MM_PER_IN=25.4;

OUTER_DIA= (2 + 1/8) * MM_PER_IN;
THICK = (1 + 3/4) * MM_PER_IN;
HOLE= 1/4 * MM_PER_IN;

difference()
{
    cylinder(h=THICK,  d=OUTER_DIA);
    cylinder(h=THICK,  d=HOLE);
    
    translate([ 0,0, 5])
    cylinder(h=THICK,  d=OUTER_DIA - 3);
}

