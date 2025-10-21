use <myTools.scad>
$fn=50;

THICK = 9;
RADIUS=10;
DRILL = 3;

REAL = [61, 81, 20]; //real dims
TWEAK = [ 3,3,0 ];
BACKER = REAL + TWEAK;

EARS = [200, 81, THICK];
HOLES = [ 41.6, 22, 0];


OFFSET= (4.25 * 25.4)/2 - HOLES.y - 6 -6;

INSIDE = BACKER - [ RADIUS, RADIUS, 0 ];

module make_backplate()
{
    difference()
    {
        hull()
        {
            translate ([+BACKER.x/2 - RADIUS, +BACKER.y/2 - RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([+BACKER.x/2 - RADIUS, -BACKER.y/2 + RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([-BACKER.x/2 + RADIUS, +BACKER.y/2 - RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([-BACKER.x/2 + RADIUS, -BACKER.y/2 + RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
        }

        #translate([ 0, -OFFSET, -THICK/2])
        {
            translate ([+HOLES.x/2, +HOLES.y/2, 0]) cylinder(d=DRILL, h = THICK*2);
            translate ([+HOLES.x/2, -HOLES.y/2, 0]) cylinder(d=DRILL, h = THICK*2);
            translate ([-HOLES.x/2, +HOLES.y/2, 0]) cylinder(d=DRILL, h = THICK*2);
            translate ([-HOLES.x/2, -HOLES.y/2, 0]) cylinder(d=DRILL, h = THICK*2);
        }
    }
}

module make_post()
{
    translate([0, BACKER.y/2, 0])
    rotate( [90, 0, 0 ])
    cylinder(d=THICK, BACKER.y);
}


LEN1= (2.125 * 22.5);

module make_ear(dist = LEN1, mirror = 1)
{
    hull()
    {
        make_post();
        translate([-(dist - THICK) * mirror, 0, -dist + THICK ])
        make_post();
    }
}

make_backplate();
translate([0, 0, THICK/2])
{
    make_ear(LEN1, -1);
    make_ear(LEN1*2, +1);
}

translate([THICK*1.5, 0, 0]) make_post();
translate([-THICK*1.5, 0, 0]) make_post();

