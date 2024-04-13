use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>

make_postNtray=true;
make_cover = true;

/* [Hidden] */

MM=25.4;

DIA= (1/4) * MM;

// UNC 20
PITCH = MM / 20; //  MM= 1 inch  .... 20 TPI for camera

// ON tripod
THREAD_LEN = 1/4 * MM;
THICK = 3;

WALL=2;

ANT_LENGTH = 120 + 3;
ANT_WIDTH = ANT_LENGTH;
ANT_DEPTH = 5;

difference()
{
    union()
    {
        if (make_postNtray)
        {
            POST_DIA= 20;
            POST_HEIGHT = 120;
            
            //translate([ANT_LENGTH/2, ANT_WIDTH/2, 0])
            RodEnd(diameter = POST_DIA, height = POST_HEIGHT, thread_len= THREAD_LEN, thread_diam= DIA, thread_pitch=PITCH);

            // negative WALL = the [] specifies maximum outside dim of box, wall goes inward
            abox([ ANT_LENGTH, ANT_WIDTH, ANT_DEPTH], -WALL *2 ,bRoundOut=false, bRoundIn=false, centered = true);
        }
        
        if (make_cover)
        {
            translate ([ 0, 0, -20])
            {
                // positive wall. inside dim = [] walls move outward
                color("CYAN")
                abox([ ANT_LENGTH, ANT_WIDTH, ANT_DEPTH], WALL*2, bRoundOut=false, bRoundIn=false, centered = true);
            }
        }
    }
    // punch out SMA connector
    translate([ ANT_LENGTH /2, 0, -50])
    #cylinder(d = 20, h = 100, true);
}               
