

$fn=200;

DIA = 70;
WIDE = DIA + 20;
HEIGHT = 20;

difference()
{
    cube([WIDE,WIDE, HEIGHT], true);
    translate([0,0,.1])
    cylinder(h = HEIGHT + .2, d = DIA, center=true);
}