use <myTools.scad>
$fn=100;

INSIDE=[130,140,28];
OUTSIDE=INSIDE + [ 1,1,1];


// resize the sphere to extend 30 in x, 60 in y, and 10 in the z directions.

difference()
{
    //resize(newsize=OUTSIDE) sphere(r=10);
    translate([OUTSIDE.x/4, 0, OUTSIDE.z/4])
    #cube( [OUTSIDE.x/2, OUTSIDE.y, OUTSIDE.z], true);
    
    resize(newsize=INSIDE) sphere(r=10);
    
    // slice in half along z plane
    translate([0,0,-OUTSIDE.z/2])
    cube( OUTSIDE, true);
}

/*difference()
{
    cylinder(d=DIA, h=THICK);
    translate([ 30, 0, SP_DIA/2 + THICK/4 - 2])
    #sphere(d=SP_DIA);
}
*/