use <ThreadMaker.scad>

/* [Hidden] */

//ABS PIPE
$fn=100;
FUDGE=.7; 

// 3" pipe

OD= 88.9 + FUDGE;  // and a 3" pipe isn't exactly a 3" pipe. Geeez.
ID= 78.5 + FUDGE;

THICK= 4;
LENGTH = 30;

difference()
{
    union()
    {
        difference()
        {
            cylinder(h = LENGTH, d= (OD + THICK*2));

            translate([0, 0, +THICK])
            cylinder(h = LENGTH, d= (OD + FUDGE));
        }

        rotate([180, 0, 0 ])
        make_garden_male(25.4);
    }

    rotate([180, 0, 0 ])
    translate([0,0, -10])
    #cylinder(h=100, d= 25.4 * 3/4);
}