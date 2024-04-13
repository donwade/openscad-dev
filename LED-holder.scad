$fn=100;

CENTERED=true;

FRONT2BACK=27.14;
FRONT2PLATE=23.91;
FRONT_WIDE= 90.1;

HEIGHT_HOLDER = 20;

BACKPLATE_THICK= FRONT2BACK - FRONT2PLATE;  // thicknesss of back plate
BACKPLATE_WIDE = 94;

module make_ledbox()
{
    linear_extrude(height = HEIGHT_HOLDER)
    {
        square([FRONT_WIDE, FRONT2PLATE], CENTERED);
        translate([0, FRONT2BACK /2  , 0])
        #square([BACKPLATE_WIDE, BACKPLATE_THICK], CENTERED);
}
}

//make_ledbox();

difference()
{
    cube([FRONT2BACK * 4, FRONT_WIDE + 10, HEIGHT_HOLDER * 2/3], true);
    make_ledbox();
}
