use <otherPeoplesWork/threads-scad/threads.scad>

make_postNtray=false;

/* [Hidden] */

MM=25.4;

DIA= (1/4) * MM;

// UNC 20
PITCH = MM / 20; //  MM= 1 inch  .... 20 TPI for camera

// ON tripod
THREAD_LEN = 1/4 * MM;

//RodStart(diameter = POST_DIA, height = POST_HEIGHT, thread_len=0, thread_diam= DIA, thread_pitch=PITCH);


THICK=5;
BOARDER=4;
translate([10,0,0]);

difference()
{
    if (make_postNtray)
    {
        POST_DIA= 20;
        POST_HEIGHT = 120;

        RodEnd(diameter = POST_DIA, height = POST_HEIGHT, thread_len= THREAD_LEN, thread_diam= DIA, thread_pitch=PITCH);

        // square
        translate ([0,0, -THICK/2 ])
        cube([120 + BOARDER,120 + BOARDER, THICK], true);
                
    }
    else
    {
        ANNTENA_BOARD_THICK = 1;
        translate ([0,0, -THICK])
        difference()
        {
            color("RED")
            translate ([0,0, -THICK])
            cube([120 + BOARDER*2, 120 + BOARDER*2, THICK], true);


            color("BLUE")
            translate ([0,0, -THICK *2/3])
            cube([120 + BOARDER, 120 + BOARDER, THICK], true);
        
            color("GREEN")
            translate([0,0, -THICK * 2/3 - ANNTENA_BOARD_THICK])
            cube([120 , 120 , THICK], true);
        }
    }
    
    translate([ 120 /2, 0, -THICK *3])
    #cylinder(d = 20, h = THICK *4);
}               
