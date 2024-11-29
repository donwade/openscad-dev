use <myTools.scad>

INSIDE = [ 29.62, 25-1, 50];
THICK = 3;

difference()
{
    color("PINK", .9)//
    abox_punch(INSIDE, +THICK, round_out=3, true);

    translate([INSIDE.x/2 + THICK/2, 0, 0 ])
    cube ([ THICK+1, THICK/3, INSIDE.z +3],true);
}