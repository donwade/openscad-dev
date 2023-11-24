
$fn=100;
CM=25.4;

HEIGHT= 10;
OUTER_DIAMETER=68;

eaves_x   =  3 * CM ;      //81.61 + hans_hak; //13;
eaves_y   =  2 * CM;      //57.24 + hans_hak; //12;16;
eaves_z  =   2.2  * CM;   // length of box

difference()
{
    hull()
    {
        #cylinder(h=HEIGHT, d=OUTER_DIAMETER);

        wall_thickness = (5/8) * CM;
        translate ([0,0, -4* HEIGHT])
        cube ([eaves_x + wall_thickness, eaves_y + wall_thickness, eaves_z], center=true);    

    }

    hull()
    {
        #cylinder(h=HEIGHT, d=OUTER_DIAMETER - 10);

        wall_thickness = (5/8) * CM;
        translate ([0,0, -4* HEIGHT])
        cube ([eaves_x , eaves_y , eaves_z], center=true);    

    }
}

translate([0,0, 10])
difference()
{
   #cylinder(h=HEIGHT * 2, d=OUTER_DIAMETER);
   #cylinder(h=HEIGHT* 4 , d=OUTER_DIAMETER - 10);
}