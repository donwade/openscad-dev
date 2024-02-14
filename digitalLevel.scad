// for lee valley digital level
$fn=100;

CENTERED=false;

FRONT_WIDE= 57.5;
FRONT_DEEP= 57.5;

HEIGHT_HOLDER = 30.45;


module make_ledbox(extra = 0)
{
    linear_extrude(height = HEIGHT_HOLDER + extra *2)
    {
        square([FRONT_WIDE + extra, FRONT_DEEP + extra], CENTERED);
    }
}

//make_ledbox();
THICK = 5;

// don't press the keys down when put in box
KEY_THICK = 2;
KEY_WIDE = 35;
KEY_DEEP = 20;

difference()
{
    difference()
    {
        difference()
        {
            make_ledbox(THICK);
            translate([-THICK/4, THICK/2, THICK])
            make_ledbox();
        }

        translate([ 0, (FRONT_WIDE + THICK - KEY_WIDE)/2, THICK - KEY_THICK])
        {
            #cube ([ KEY_DEEP, KEY_WIDE, KEY_THICK]);

            translate([ 0, 0, HEIGHT_HOLDER + KEY_THICK])
            #cube ([ KEY_DEEP, KEY_WIDE, KEY_THICK]);
        }
    }
    translate ([0, (FRONT_WIDE + THICK)/2, HEIGHT_HOLDER /2 + THICK])
    rotate([0, 90, 0])
    cylinder(h = FRONT_DEEP *2, d= 20);
}