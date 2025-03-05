use <myTools.scad>
// HDMI DISPLAY HOLDER
$fn=100;

MM=25.4;
FUDGE=2;
ENG_VIEW=0 ; // -30

insert= [ 7.5 * MM + FUDGE, 17 + FUDGE, 17.5 + FUDGE ];

BOARDER=10;
stand = [ insert.x + BOARDER, insert.y * 3 + BOARDER, 17.5 + FUDGE ];

difference()
{
    color("GREEN", .4)
    cube(stand, true);
    
    translate([ENG_VIEW, -stand.y/2+ 17, insert.z/2])
    rotate([90 - 10, 0, 0])
    #cube(insert, true);
}


translate([0, 80, 0])
difference()
{
   cube( [6.5 * MM, 6, 5], true);
   translate ([0, 0, 1.1])
   cube( [6.5 * MM+2, 4.5, 4.5], true);
}