use <myTools.scad>
$fn=100;

HI=50;
SHOE_LACE=4;

difference()
{
    cylinder(HI, d1= 30, d2= 20);
    translate([0, 0, -.2])
    cylinder(d=SHOE_LACE, h= HI + 1);
    cylinder(d1=SHOE_LACE*3, d2=SHOE_LACE, h= HI/4);

        
    translate([ 0, 0, HI + 5])
    sphere(d=15);
    
}