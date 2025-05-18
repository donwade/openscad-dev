use <myTools.scad>
$fn=100;

WALL_THICK=4;

INTERIOR=[79.11 , 45, 26.96 + 10 + 20];


module mainBOX()
{
        abox_punch(INTERIOR, +WALL_THICK, round_out=2, true);
}

PLUG = [ 23, 10, 40];

MAKE_BOTTOM=false;

difference()
{
    union()
    {
        color("GREEN", .9)
        translate([ 0,0, INTERIOR.z/2]) //sit on 9.0 plane
        mainBOX();

    }

    translate( [-(25.11 + PLUG.x/2) + INTERIOR.x/2 , -10, 26.96 + PLUG.y/2 - 2.88])
    rotate([90, 0, 0])
    #cube(PLUG, true);
}