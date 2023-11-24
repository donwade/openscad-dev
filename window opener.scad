$fn=100;

tweek = 2;
function bigger(x) = (x + tweek);
function smaller(x) = (x - tweek);

length = 58.0;
depth = smaller(37.0);
height = 40;

latch_thick = bigger(3);
latch_length = bigger(35);
latch_depth = smaller(6);

latch_height1 = 31.0 - latch_thick;  // from 0 to bottom of latch 
latch_height2 = 35.0 - latch_thick;  // from 0 to bottom of latch

latch_height_fromTop = height - latch_height1;

difference() {
    cube([length, depth, height]);
    union()
    {
        translate ([0, 0, latch_height1])
        #cube([length, latch_depth, latch_height1]);
        
        translate ([0, depth - latch_depth, 0])
        cube ([length, latch_depth, height -latch_height2]);
    }
}