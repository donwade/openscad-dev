use <myTools-extended.scad>
use <doubleTaperBox.scad>

$fn = $preview ? 50 : 120;

//DEBUG= $preview ? 0 : 1;
DEBUG= 1;
//=================================================

TWEAK = 1;
WHITE_W = 80.86 + TWEAK;
WHITE_L = 57.62 + TWEAK;

BLACK_W = 80.92 + TWEAK;
BLACK_L = 57.62 + TWEAK;

THICK=4;
PIPE_LEN = 9 * 25.4;
BOX_LEN = 6 * 25.4;

A = WHITE_W * WHITE_L; //square inches of down pipe

TRUE_DIA = (2 * sqrt( A /PI));
PIPE_iDIA = round( TRUE_DIA + 10);  // round up to nearest 10mm

//ringSupport
RING_HEIGHT=10;
RING_WIDTH=20;

echo ("pipe AREA = ", A, "sq mm");
echo ("pipe PIPE_iDIA = ", PIPE_iDIA,"mm");

SCREW_DIA= 3/16 * 25.4;

function AVG(a,b) = (a+b)/2;

//              T         D           H           TRANS     ROTATE   endcap endcap               
cylinder1 = [ THICK,     PIPE_iDIA,  PIPE_LEN,     [0,0,0], [0,0,0],  DEBUG, DEBUG ]; // dia, len, translate[x,y,z]

screw1 =    [ SCREW_DIA, SCREW_DIA*2, WHITE_W-THICK * 16/4, [115, -(BLACK_W/4 - THICK*3/2), (PIPE_LEN)/2], [90,0,0], 0, 0 ]; // dia, len, translate[x,y,z]
screw2 =    [ SCREW_DIA, SCREW_DIA*2, BLACK_W-THICK * 16/4, [115,  (BLACK_W/4 - THICK*3/2), -(PIPE_LEN)/2], [90,0,0], 0, 0 ]; // dia, len, translate[x,y,z]


//         T        DIM              TRANS                                                     ROTATE      L  R                  
white = [THICK, [ WHITE_W, WHITE_L, BOX_LEN] ,
        [   (BOX_LEN/2 - THICK), 
            (PIPE_iDIA/4 - THICK*2), 
            (-PIPE_LEN/2 + WHITE_L - THICK*3 - THICK * 27/64)
        ], 
        [ 0, 90, 0 ], 0, 0];
        
black = [THICK, [ BLACK_W, BLACK_L, BOX_LEN] , 
        [   (BOX_LEN/2 - THICK),
            -(PIPE_iDIA/4 - THICK*2),
            -(-PIPE_LEN/2 +BLACK_L/2 + THICK*3 +THICK * 59/64)],
        [ 0, 90, 0 ], 0, 0];

// make supports so prusa supports are not needed.
support1 = [-2, [ WHITE_W-.5, WHITE_L-.5, PIPE_LEN] , [ -BLACK_W/2, 0, PIPE_LEN/2],    [ 0, 0, 0 ], 0, 0];
support2 = [-2, [ BLACK_W-.5, BLACK_L-.5, PIPE_LEN] , [  BLACK_W/2+3, 0, PIPE_LEN/2], [ 0, 0, 0 ], 0, 0];


C_LIST = [cylinder1]; //, screw1, screw2]; //, cylinder3, cylinder4, cylinder5, cylinder6, cylinder7, cylinder8 ]; 
BOX_LIST=[white, black]; //[white, black];

SUPPORT_LIST=[support1]; // both are almost the same.
//------------------------------------------------------------
module make_drains()
{
    difference()
    {
        {
            difference()
            {
                union()
                {
                  #make_cylinders(action="BOM", PARTS_LIST=C_LIST)
                    make_cylinders(action="ADD", PARTS_LIST=C_LIST);
                    //
                  make_cubes("BOM", PARTS_LIST=BOX_LIST)
                    make_cubes("ADD", PARTS_LIST=BOX_LIST);
                }

              union()
              {
                  make_cylinders("BOM", PARTS_LIST=C_LIST)
                    make_cylinders("REMOVE", PARTS_LIST=C_LIST);

                  make_cubes("BOM", PARTS_LIST=BOX_LIST)
                    make_cubes("REMOVE", PARTS_LIST=BOX_LIST);
              }
            }
       }
       // trim ends to make flat
       // translate([0, 0,  (PIPE_LEN*2/3+ 20.)]) #cube([400,100,10], center=true);
       // translate([0, 0, -(PIPE_LEN*2/3+ 20)]) #cube([400,100,10], center=true);
    }
}
//-------------------------------------------------------

module make_supports()
{
    difference()
    {
        union()
        {
          make_cubes("BOM", PARTS_LIST=SUPPORT_LIST)
            make_cubes("ADD", PARTS_LIST=SUPPORT_LIST);
        }

      union()
      {
          make_cubes("BOM", PARTS_LIST=SUPPORT_LIST)
            make_cubes("REMOVE", PARTS_LIST=SUPPORT_LIST);
      }
    }
}
// -----------------------------------------------
module make_rings()
{
    //               WALL                 PIPE_iDIA      WIDE
    outside =   [ RING_HEIGHT,  // make bigger by this dia
                  PIPE_iDIA + THICK ,  // sit on outside of pipe
                  RING_WIDTH/2,   // fatness of ring
                  [0,0,0], [0,0,0],  DEBUG, DEBUG ];
                  
    seat =      [   THICK+.5,
                    PIPE_iDIA,   // start halfway on pipe dia
                    RING_WIDTH,
                    [0,0,RING_WIDTH/2],
                    [0,0,0],  DEBUG, DEBUG ];
     
    OUTER = [ outside];
    SEAT =  [ seat];
        translate([0, 0, RING_HEIGHT/2])
        difference()
        {
            union()
            {
              make_cylinders(action="BOM", PARTS_LIST=OUTER)
                make_cylinders(action="ADD", PARTS_LIST=OUTER);
/*
                make_cylinders("BOM", PARTS_LIST=SEAT);
                make_cylinders("ADD", PARTS_LIST=SEAT);
*/
            }

          union()
          {
              make_cylinders("BOM", PARTS_LIST=OUTER)
                make_cylinders("REMOVE", PARTS_LIST=OUTER);

if(1)
{                
              make_cylinders("BOM", PARTS_LIST=SEAT);
                make_cylinders("ADD", PARTS_LIST=SEAT);
}

             #cylinder(h=150, d= PIPE_iDIA, center = true);

          }
     }
    
}

// -----------------------------------------------
module make_shroud(FAT=.5)
{
    PIPE_OD=PIPE_iDIA + 2 * THICK;
    
    //               WALL                 PIPE_iDIA      WIDE
    outside =   [ RING_HEIGHT,   
                  PIPE_OD + RING_HEIGHT + FAT, // sit on outside of pipe
                  RING_WIDTH*2,                // fatness of ring
                  [0,0,0], [0,0,0],  DEBUG, DEBUG ];

    // yes thick/2 is a unknnown tweak.
    seat =   [    RING_HEIGHT + FAT - THICK/2, // make bigger by this dia
                  PIPE_OD + FAT,               // sit on outside of pipe
                  RING_WIDTH + FAT*2,          // punch depth
                  [0,0,0], [0,0,0],  DEBUG, DEBUG ];
                  
    EAR_SIZE = 20;                
    //       thick     dims           trans       rotate    left, right
    box1 = [  0,    //solid, zero walls 
            [   PIPE_iDIA + THICK*2 + 2*RING_HEIGHT + EAR_SIZE*2.5,
                20,
                RING_WIDTH *2], 
            [  0, 0, 0 ], 
            [ 0, 0, 0 ],
            0, 0];
            
    EARS = [ box1];
     
    OUTER = [ outside];
    INNER =  [ seat];
    
        difference()
        {
            union()
            {
                make_cylinders(action="BOM", PARTS_LIST=OUTER)
                    make_cylinders(action="ADD", PARTS_LIST=OUTER);
                make_cubes("BOM", PARTS_LIST=EARS);
                    make_cubes("ADD", PARTS_LIST=EARS);
            }

          union()
          {
              make_cylinders("BOM", PARTS_LIST=OUTER)
                make_cylinders("REMOVE", PARTS_LIST=OUTER);

              make_cylinders("BOM", PARTS_LIST=INNER);
                make_cylinders("ADD", PARTS_LIST=INNER);

            // crazy glue drip stop
            {
                translate([ PIPE_iDIA/2 + THICK*5  , 0, 0])
                rotate([ 0, 0, 90])
                #cylinder(h=170, d= 3, center = true);

                translate([ -(PIPE_iDIA/2 + THICK*5 ), 0, 0])
                rotate([ 0, 0, 90])
                #cylinder(h=150, d= 3, center = true);
            }

            // backup bolt holes
            {
                BOLT = 3/16 * 25.4 + FAT;
                translate([ PIPE_iDIA/2 + THICK*7.5  , 0, 0])
                rotate([ 0, 90, 90])
                #cylinder(h=170, d= BOLT, center = true);

                translate([ -(PIPE_iDIA/2 + THICK*7.5 ), 0, 0])
                rotate([ 0, 90, 90])
                #cylinder(h=150, d= BOLT, center = true);
            }


            // basic pipe OUTER dia cutout
             cylinder(h=150, d= PIPE_OD+FAT , center = true);
            
            if (0) // transparent view
            {
                 translate([0,0,25])
                 cube([200, 200, 50], center=true);
            }
          }
     }
    
}

/*
WHITE_W = 80.86 + TWEAK;
WHITE_L = 57.62 + TWEAK;

BLACK_W = 80.92 + TWEAK;
BLACK_L = 57.62 + TWEAK;

*/

L_WHITE = 83.84 - 4.11;
W_WHITE = 59.87 - 4.17;
echo ("L_WHITE = ", L_WHITE);
echo ("W_WHITE = ", W_WHITE);
echo ("");

L_BLACK = 83.20 - 3.98;
W_BLACK = 60.61 - 4.35;
echo ("L_BLACK = ", L_BLACK);
echo ("W_BLACK = ", W_BLACK);
echo ("");

T=.3;

module make_buttplugs()
{
    taper_cube(  big =  [W_WHITE -T , L_WHITE - T], 
                 small= [W_WHITE * .7, L_WHITE *.7], 
                 height=20, 
                 indent_pct=50);
                 
    translate([0, L_WHITE + 5, 0])
    taper_cube(  big =  [W_BLACK -T, L_BLACK -T], 
                 small= [W_BLACK * .7, L_BLACK *.7], 
                 height=20, 
                 indent_pct=50);

 }
//make_drains();
//make_supports();
//make_rings();
//make_shroud(.5);
make_buttplugs();