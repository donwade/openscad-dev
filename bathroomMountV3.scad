use <myTools-extended.scad>
$fn = $preview ? 50 : 120;

//DEBUG= $preview ? 0 : 1;
DEBUG= 1;
//=================================================
TWEAK = .5;

DIA=72.13 + TWEAK;
HT = 4;

OUTSIDE = 64.5;
INSIDE = 52.5;

BIG_HOLE_DIA = (OUTSIDE-INSIDE)/2;  // b/n 2 holes
RADIUS= (INSIDE /2 + BIG_HOLE_DIA/2);


MAKE_PART1 = true;
MAKE_PART2 = false;

module body()
{
    cylinder(h=HT, d=DIA);
    translate([0,0,HT])
    cylinder(h=HT + 3, d= 28);

    for ( ROT = [ 0: 360/12: 359 ])
    {
        if ( ROT == 0 || ROT == 360/3 || ROT == 360 * 2/3)
        {
            echo ("                   SKIP = ", ROT);
        }
        else
        {
            echo ("POST = ", ROT, "RADIUS = ", RADIUS, "DIA = ", BIG_HOLE_DIA);
            rotate([ 0, 0, ROT])
            translate([0, RADIUS, 0])
            cylinder(h= HT + 2, d=BIG_HOLE_DIA -.2);
        }
    }   
}

DRILL_BIT = 4.1;  // for markup pen 5 or more for drill

if (MAKE_PART1)
{
    difference()
    {
        body();
        translate([0, 0, -.1])
        for ( ROT = [ 0: 360/12: 359 ])
        {
            if ( ROT == 0 || ROT == 360/3 || ROT == 360 * 2/3)
            {
                // generate marker perimeter reference
                echo ("                   SKIP = ", ROT);
                rotate([ 0, 0, ROT])
                translate([0, RADIUS + 7, 0])
                cylinder(h= HT*10, d=DRILL_BIT+4);
            }
            else
            {
                // one of many true drill holes
                echo ("DRILL = ", ROT, "RADIUS = ", RADIUS, "DIA = ", BIG_HOLE_DIA);
                rotate([ 0, 0, ROT])
                translate([0, RADIUS, 0])
                cylinder(h= HT*10, d=DRILL_BIT);
            }
        }   
    }
}


module testPin()
{
    MM=25.4;

    translate([ 0, 50, 0 ])
    {
        cylinder( d= 1/2 * MM, h= HT);
        translate([0,0,HT])
        cylinder(h= HT, d=BIG_HOLE_DIA -.2);
    }    
}

if (MAKE_PART2)
{
    testPin();
}