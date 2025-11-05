use <myTools-extended.scad>
$fn = $preview ? 50 : 120;

//DEBUG= $preview ? 0 : 1;
DEBUG= 1;
//=================================================

TWEAK = 1;
W1 = 80.86 + TWEAK;
L1 = 57.62 + TWEAK;

W2 = 80.92 + TWEAK;
L2 = 57.62 + TWEAK;

THICK=4;
LEN = 6 * 25.4;

A = W1 * L1; //square inches of down pipe

TRUE_DIA = (2 * sqrt( A /PI));
DIA = round( TRUE_DIA + 10);  // round up to nearest 10mm

RING_DIA = DIA + 10;
RING_LEN = 10;

echo ("pipe AREA = ", A, "sq mm");
echo ("pipe DIA = ", DIA,"mm");

SCREW_DIA= 3/16 * 25.4;


//              T         D           H           TRANS     ROTATE   endcap endcap               
cylinder1 = [ THICK,     DIA,         L1 * 4,     [0,0,0], [0,0,0],  DEBUG, DEBUG ]; // dia, len, translate[x,y,z]
screw1 =    [ SCREW_DIA, SCREW_DIA*2, W1-THICK * 16/4, [115, -(W2/4 - THICK*3/2), (LEN)/2], [90,0,0], 0, 0 ]; // dia, len, translate[x,y,z]
screw2 =    [ SCREW_DIA, SCREW_DIA*2, W2-THICK * 16/4, [115,  (W2/4 - THICK*3/2), -(LEN)/2], [90,0,0], 0, 0 ]; // dia, len, translate[x,y,z]


//         T        DIM              TRANS                                                     ROTATE      L  R                  
box1 = [THICK, [ W1, L1, LEN] , [ (LEN/2 - THICK), (DIA/4 - THICK*2),   -(DIA-THICK*4)], [ 0, 90, 0 ], 0, 0];
box2 = [THICK, [ W2, L2, LEN] , [ (LEN/2 - THICK),-(DIA/4 - THICK*2),  (DIA-THICK*4)], [ 0, 90, 0 ], 0, 0];

C_LIST = [cylinder1]; //, screw1, screw2]; //, cylinder3, cylinder4, cylinder5, cylinder6, cylinder7, cylinder8 ]; 
BOX_LIST=[box1, box2]; //[box1, box2];

//------------------------------------------------------------

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
    translate([0, 0,  (LEN*2/3+ 20.)]) #cube([400,100,10], center=true);
    translate([0, 0, -(LEN*2/3+ 20)]) #cube([400,100,10], center=true);
}

