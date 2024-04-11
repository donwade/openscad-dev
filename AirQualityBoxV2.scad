//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>
use <usbA-C.scad>

/* [Hidden] */
TWEAK=.6;

x = 83.64 + TWEAK;
y = 64.83 + TWEAK;
z = 38.0 + 2.25;   
WALL_THICK = 4;

$fn=60;   //circle quantize 360/10=36 degrees per side

// container for the AQ
AQ_outside = [ x, y, z ];


DIA = 5;
BN_DIA = 3;
DIST = DIA + BN_DIA;
LENGTH= x * 1.2;

across = 3;  // must be odd
down = 7;     // must be odd

module oneRowX(ACROSS, DOWN)
{
    centerDot_x = (ACROSS -1) /2;
    //echo("centerDot_x is ", centerDot_x + 1);
    translate([ -(centerDot_x) * DIST, 0, 0 ])
    for ( ac = [ 0: 1: ACROSS -1 ])
        //echo ("ac = ", ac)
        translate([ ac * (DIST), 0, -LENGTH/2 ])
            cylinder( d= DIA, h= LENGTH, center= false);
}


module makeArray(ACROSS, DOWN, ROTATE)
for (dn = [ 0: 1: (DOWN -1)/2])
{
    rotate(ROTATE)
    translate ([(dn % 2)? 0: DIST/2, dn * (DIST), 0]) // make postive row
        oneRowX(ACROSS);

    if ( dn != 0 )
    {
        rotate(ROTATE)
        translate ([ (dn % 2)? 0: DIST/2, -dn * DIST, 0])  // mirror negative row
            oneRowX(ACROSS);
    }
}

difference()
{
    difference()
    {
        abox( AQ_outside, thick = +WALL_THICK, round_out =2, bCentered = true);

        //makeArray(across, down, [0, 90, 0]);
        makeArray(9 , 5, [90, 0, 0]);
    }
  
    // USB PUNCH OUT
    translate ([x/2 - .1 , -y/2 + 23, z/2 - 6]) // x/2 = inside of wall.
    rotate([ -90, -180, -90])
    #make_USBA();
    
}