use <myTools.scad>
$fn=100;

MM_PER_IN=25.4;

OUTER_DIA= 46.44; 
INNER_DIA= 42.32;
HI=5.32;


difference()
{
    sphere(d=OUTER_DIA);
    
    //sphere(d=INNER_DIA);
    
    // cut in half
    translate([0, 0, -(OUTER_DIA+ 10)/2])
    cube([OUTER_DIA + 10,OUTER_DIA + 10, OUTER_DIA + 10], true);
}

translate([ 0, 0, -HI])
difference()
{
    cylinder(h=HI, d = OUTER_DIA);
    cylinder(h=HI, d = INNER_DIA);
}


