use <myTools.scad>

$fn=100;
MM=25.4;
//MM=10;
FUDGE=2;

// 2-3/8 x 3-2/16

insidePipe = [ 80.34 + FUDGE, 59.89 + FUDGE, 2 * MM];
WALL_THICK = 4;

PIPE_OD_MAX = 53.56;
PIPE_THICK = 3;
PIPE_ID_MAX = PIPE_OD_MAX-PIPE_THICK *2;

PIPE_LENGTH = 25.6 * 1.5;

difference()
{
    union()
    {
        hull()
        {
            translate([0,0, insidePipe.z] * 1.1)
            cube (insidePipe + [WALL_THICK * 2, WALL_THICK * 2, 0], center = true);
            cylinder(d=PIPE_OD_MAX, h=PIPE_LENGTH);
        }
        translate([0, 0, - PIPE_LENGTH])
        cylinder(d=PIPE_OD_MAX, h=PIPE_LENGTH);
    }

    union()
    {
        hull()
        {
            translate([0,0, insidePipe.z] * 1.1)
            cube (insidePipe , center = true);
            cylinder(d=PIPE_ID_MAX, h=PIPE_LENGTH);
        }
        
        translate([0, 0, - PIPE_LENGTH])
        cylinder(d=PIPE_ID_MAX, h=PIPE_LENGTH);

        // screwholes Y dir
        translate([0, insidePipe.y, insidePipe.z * 1.2 ])
        rotate([90, 0, 0])
        #cylinder(d= 3/16 *MM, h=insidePipe.x *2);
        
        // screwholes X dir
        translate([-insidePipe.x, 0 , insidePipe.z * 1.2 ])
        rotate([0, 90, 0])
        #cylinder(d= 3/16 *MM, h=insidePipe.x *2);

    
    }
}

DRILL = 09;
DIST= DRILL * 1.2;
$fn = 30;
W= 2;
H= 3;

translate([0, 0, 150])
difference()
{
    cube (insidePipe - [ 4, 4, 40] , center = true);

    for (across = [ -W:  1 : W])
    {
        for (row = [ -H: 1 : H])
        {
            echo ("row = ", row, " across = ", across);
            translate ([ row * DIST, across * DIST, -15])
            #cylinder(d = DRILL, h = 30);
        }
    }
}

