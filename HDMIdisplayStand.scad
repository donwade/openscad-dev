use <myTools.scad>
// HDMI DISPLAY HOLDER
$fn=100;

MM=25.4;
FUDGE=1;
ENG_VIEW= 0; // -30;

insert= [ 7.5 * MM + FUDGE, 17 + FUDGE, 9 ];

BOARDER=10;
stand = [ insert.x + BOARDER, insert.y * 3 + BOARDER, insert.z * 2 ];

difference()
{
    color("GREEN", .4)
    cube(stand, true);
    
    translate([ENG_VIEW, -stand.y/2+ 12, insert.z/2])
    rotate([90 - 10, 0, 0])
    #cube(insert, true);
}