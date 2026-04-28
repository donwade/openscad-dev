use <myTools.scad>
$fn=100;

SQ=25.4 *2;
TH=3;
DRILL= 12.67;  //.5 * 25.4;

difference()
{
    union()
    {
        cube([SQ,SQ,TH], true);
        cylinder(h = 10+TH/2-.2, d=DRILL+10);
    }
    translate( [ 0, 0, -TH/2-.1])
    {
        #cylinder(h=10 + TH, d1 = DRILL, d2 = DRILL+ .6);
    }
}
 
translate([0,0, -TH/2 + .3/2])
{
    cube([.5, SQ, .3], true);
    rotate([ 0, 0, 90])
    cube([.5, SQ, .3], true);
}