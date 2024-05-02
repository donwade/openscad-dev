//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

/* [Hidden] */
TWEAK=.25;

x = 48.09 + 4;  // so we can pop it out if we have to.
y = 25.37;  // tight
z = 9 + TWEAK ;  // it will sit on its pins.   

$fn=60;   //circle quantize 360/10=36 degrees per side


//--------------------------------------------------------------------------------

PIN_WIDTH = .64;
PIN_HEIGTH = 20;
RUN = 46.12 - PIN_WIDTH;
NUM_PINS = 19;
PIN_DIST = .1 * 25.4;
echo ("PIN_DIST= ", PIN_DIST, "   PIN_DIST_IN =", PIN_DIST/25.4);

//--------------------------------------------------
module column_of_pins()
{
    
    for (drill = [0: 1: (NUM_PINS -1)/2]) 
    {
        echo ("drill at ", drill * PIN_DIST);
        translate([ drill * PIN_DIST, 0, 0])
        cube([PIN_WIDTH, PIN_WIDTH, PIN_HEIGTH], center=true);

        translate([ drill * -PIN_DIST, 0, 0])
        cube([PIN_WIDTH, PIN_WIDTH, PIN_HEIGTH], center=true);
    }
}
//--------------------------------------------------
POST_WIDTH=2.55;

module column_of_posts()
{
    
    for (drill = [0: 1: (NUM_PINS -1)/2]) 
    {
        echo ("drill at ", drill * PIN_DIST);
        translate([ drill * PIN_DIST, 0, z/2 + POST_WIDTH/2])
        cube([POST_WIDTH, POST_WIDTH, POST_WIDTH], center=true);

        translate([ -drill * PIN_DIST, 0, z/2 + POST_WIDTH/2])
        cube([POST_WIDTH, POST_WIDTH, POST_WIDTH], center=true);
    }
}
//--------------------------------------------------

module make_dip()
{
    WIDE= 23.67 - PIN_WIDTH;
    
    translate([ 0, +WIDE/2, 0])
    {
        column_of_pins();
        column_of_posts();
    }
    
    translate([ 0, -WIDE/2, 0])
    {
        column_of_pins();
        column_of_posts();
    }
}

//--------------------------------------------------------------------------------

// container for the AQ
Wave_insideDIM = [ x, y, z ];


DIA = 4;
BN_DIA = 2;
DIST = DIA + BN_DIA;
LENGTH= x * 1.2;
WALL = 3;

across =5;  // must be odd
down = 11;     // must be odd

difference()
{
    abox( Wave_insideDIM, thick = +WALL, round_out =2, bCentered = true, bSolid=true);
    make_dip();
}

/*
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
    translate ([0, dn * (DIST), 0]) // make postive row
        oneRowX(ACROSS);

    rotate(ROTATE)
    translate ([0, -dn * DIST, 0])  // mirror negative row
        oneRowX(ACROSS);
}

difference()
{
    abox( Wave_insideDIM, thick = +4, round_out =2, bCentered = true);
 
//    makeArray(across, down, [0, 90, 0]);
//    makeArray(13 , 5, [90, 0, 0]);
}
*/
