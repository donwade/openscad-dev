
$fn=50;

HEIGHT= 10;
OUTER_DIAMETER=68;

//hull()
{
    difference()
    {
        cylinder(h=HEIGHT, d=OUTER_DIAMETER);
        cylinder(h=HEIGHT, d=OUTER_DIAMETER-10);
    }

    CM=25.4;

    x   =  3 * CM ;      //81.61 + hans_hak; //13;
    y   =  2 * CM;      //57.24 + hans_hak; //12;16;
    z  =   2.2  * CM;   // length of box

    wall_thickness = (5/8) * CM;
    translate ([0,0, -4* HEIGHT])
    difference()
    {
        difference()
        {
            cube ([x + wall_thickness, y + wall_thickness, z], center=true);    
            cube ([x, y, z ], center=true);
              
        }
    }
}