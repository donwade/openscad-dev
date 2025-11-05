use <myTools-extended.scad>
$fn = $preview ? 50 : 120;

//DEBUG= $preview ? 0 : 1;
DEBUG= 1;
//=================================================
//W = 2 * 25.4;
//L = 3 * 25.4;
W1 = 2 * 25.4;//
L1 = 3 * 25.4;

W2 = 2 * 25.4;//
L2 = 3 * 25.4;

THICK=4;
LEN = 6 * 25.4;

A = W1 * L1; //square inches of down pipe

TRUE_DIA = (2 * sqrt( A /PI));
DIA = round( TRUE_DIA + 10);  // round up to nearest 10mm

RING_DIA = DIA + 10;
RING_LEN = 10;

echo ("pipe AREA = ", A, "sq mm");
echo ("pipe DIA = ", DIA,"mm");

//              T       D        H           TRANS     ROTATE   endcap endcap               
cylinder1 = [ THICK,   DIA,      L1 * 3,     [0,0,0], [0,0,0],  DEBUG, DEBUG ]; // dia, len, translate[x,y,z]
cylinder2 = [ THICK*2, RING_DIA, RING_LEN,   [0,0,0], [0,0,0],  DEBUG, DEBUG ]; // dia, len, translate[x,y,z]

//         T        DIM              TRANS                                                     ROTATE      L  R                  
box1 = [THICK, [ W1, L1, LEN] , [  -DIA/4 + THICK*1.5,   L1-THICK/2  -THICK/2 ,    LEN/2 ], [ 90, 0, 90 ], 0, 0];
box2 = [THICK, [ W2, L2, LEN] , [   DIA/4 - THICK*1.5, -(L2-THICK/2) +THICK/2,  LEN/2 ], [ 90, 0, 90 ], 0, 0];

C_LIST = [cylinder1]; //, cylinder3, cylinder4, cylinder5, cylinder6, cylinder7, cylinder8 ]; 
BOX_LIST=[box1, box2]; //[box1, box2];

//------------------------------------------------------------

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
