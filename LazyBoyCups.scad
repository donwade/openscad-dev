//use <myTools.scad>
$fn= $preview ? 50 : 160;

function MM(in)= in * 25.4; 
function IN(mm)= mm/25.4;

TWEAK=.2;

TOP_RING=83.76 + .78 - TWEAK;
MID_RING=80.36 - TWEAK;
BOT_RING=70.77 - TWEAK;

TOP2MID=63.0;
MID2BOT=25.0 - TWEAK;

//the 'cups' are tapered.
TOP2MID_DEGREE= cos((TOP_RING - MID_RING)/TOP2MID);
echo ("TOP2MID_DEGREE = ", TOP2MID_DEGREE);


SHOULDER_HEIGHT=14;
SHOULDER_WIDTH=7;

POPCAN_DIA = 66 + 1 + TWEAK;
POPCAN_HEIGHT = 123;
POPCAN_OFFSET=42 + 4;

AIRGAP_DIA= 2;
COFFEE_DIA = 87;


echo ("canwall = ", (BOT_RING - POPCAN_DIA)/2);

//----------------------------------------------------------
module coke_can(ribs = false)
{
    color("RED") //coke can
    translate([0, 0, -(TOP2MID - POPCAN_OFFSET)])
    {
        cylinder(h=POPCAN_HEIGHT, d= POPCAN_DIA);

        // make suction vent hole for pop can.
        translate([ 0, POPCAN_DIA/2 + AIRGAP_DIA/8, 0])
        cylinder(h=POPCAN_HEIGHT, d= AIRGAP_DIA);

        translate([ POPCAN_DIA/2 + AIRGAP_DIA/8, 0, 0])
        cylinder(h=POPCAN_HEIGHT, d= AIRGAP_DIA);

        translate([ 0, -(POPCAN_DIA/2 + AIRGAP_DIA/8), 0])
        cylinder(h=POPCAN_HEIGHT, d= AIRGAP_DIA);

        translate([ -(POPCAN_DIA/2 + AIRGAP_DIA/8),0, 0])
        cylinder(h=POPCAN_HEIGHT, d= AIRGAP_DIA);
    } 
    
    if (ribs)
    {
        translate([0, 0, -(TOP2MID )])
        for ( X = [ 0: 5: 3*24])
        {
     
            rotate([ 0, 0, X/2])
            translate([ 0, MID_RING/2 + AIRGAP_DIA/2, TOP2MID])
            //#cylinder(h=60 + 4, r1= AIRGAP_DIA*3, r2=AIRGAP_DIA);
            #cylinder(h=60 + 4, d= AIRGAP_DIA*3);
     
        }
    }
}
//----------------------------------------------------------
MAKE_BODY= 0;
MAKE_STAND = 0;
MAKE_COVER = 1;

if (MAKE_BODY)
{
    difference()
    {
        union ()
        {
            // ring on the very top edge 
            translate([ 0, 0, TOP2MID] )
            {
                cylinder(h=SHOULDER_HEIGHT, d =(TOP_RING + SHOULDER_WIDTH * 2));
            }
            
            cylinder(h=TOP2MID, r1 = MID_RING/2, r2=TOP_RING/2);
            
            translate([ 0, 0, -MID2BOT ])
            cylinder(h=MID2BOT, d = BOT_RING);
            
        }

        translate([ 0, 0, TOP2MID + SHOULDER_HEIGHT/2] )
        {
            cylinder(h=SHOULDER_HEIGHT, d = COFFEE_DIA);
        }
        
        coke_can(ribs = true);
        rotate([0, 0, 45]) coke_can();
    }
}

if (MAKE_STAND)
{
    // make adaptor that is hollow that pushes popcan up.
    difference()
    {
        cylinder(h=30, d=POPCAN_DIA - 1);
        cylinder(h=25, d=POPCAN_DIA -6);
    }   
}

if (MAKE_COVER)
{
    difference()
    {
        union ()
        {
            // ring on the very top edge 
            translate([ 0, 0, TOP2MID] )
            {
                cylinder(h=1.5, d =(TOP_RING));
            }
            
            //cylinder(h=TOP2MID, r1 = MID_RING/2, r2=TOP_RING/2);
            
            //translate([ 0, 0, -MID2BOT ])
            //#cylinder(h=MID2BOT, d = BOT_RING);
            
        }

        translate([ 0, 0, TOP2MID + SHOULDER_HEIGHT/2] )
        {
            cylinder(h=SHOULDER_HEIGHT, d = COFFEE_DIA);
        }
        
        coke_can(ribs = true);
        rotate([0, 0, 45]) coke_can();
    }
}
