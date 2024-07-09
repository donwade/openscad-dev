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

XOD = 38.90;
XID = XOD - THICK *2;


difference()
{
    union()
    {
        difference()
        {
            union()
            {
                hull()
                {
                    color("GREEN", .8)
                    cylinder(h = LENGTH, d= (OD + THICK*2));
                    
                    color("BLUE", .8)
                    translate([ 0,0, -LENGTH/2 + THICK])
                    cylinder(h = LENGTH/2 , d= XOD);
                }
                color("BLUE", .8)
                translate([ 0,0, -LENGTH*2 + THICK])
                cylinder(h = LENGTH*2 , d= XOD);
            }
            union()
            {
                translate([0, 0, +THICK])
                cylinder(h = LENGTH, d= (OD + FUDGE));

                translate([ 0,0, -LENGTH*2 + THICK ])
                cylinder(h = LENGTH*2, d = XID);
            }
        }

        //rotate([180, 0, 0 ])
        //make_garden_male(25.4);
    }
}