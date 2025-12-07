use <myTools.scad>
$fn=100;

FUDGE = [ 1, 1, 10 ]; // really thick pcb to punch thru the top

WALL=5;

xPCB= [26, 30.1, 1.1]; //real dims
PCB = xPCB + FUDGE;

GROVE_X= (9 - 5.70)/2; // GROVE conn not on center :P


BLOCK = [ 13, 3, 9];


HEIGHT = 25.4;
NOTCH_IN=2;

// the inside of the box is tighter than the PCB
// to make the PCB click inot postion.

INSIDE= PCB - [ NOTCH_IN, NOTCH_IN, -HEIGHT];
//----------------------------------------------------

module make_box()
{
 
    color("PINK", .9)//

    difference()
    {
        abox_punch(INSIDE, WALL, round_out=1, true);
        
        translate([ 0, 0, HEIGHT/2 + 9])
        {
            cube(PCB, true);
        
            translate([ GROVE_X, xPCB.y/2 + BLOCK.y/4 , -8])
            #cube(BLOCK, true);
        }
    }
}

//-----------------------------------------------------

module make_lid(LID_THICK=2, bHasCable = false)
{
    LID= [INSIDE.x + WALL*2 -2, INSIDE.y + WALL*2 -2, LID_THICK];

    difference()
    {
        union()
        {
            abox(LID, 1, bSolid = true, round_out=1, true);
            translate([ 0, 0, LID_THICK -.1])
            cube([INSIDE.x-.1, INSIDE.y-.1, LID_THICK], true);
            #cube([xPCB.x + .25, xPCB.y + .25, LID_THICK], true);
        }
        if (bHasCable)
        {
            WIRE= [ 7+3, 5.5, 20 ];
            translate([INSIDE.x/2 + 3,0, 0])
            #cube( WIRE, true);
        }
    }
}
//-----------------------------------------------------
make_box();
//make_lid(LID_THICK=2, bHasCable=false);
//translate([ 0, 50, 0 ])
//make_lid(LID_THICK=3, bHasCable=true);
