
$fn=100;
PART_THICK = 6.21 + 3.46; // 3.46 wire connector is fat.

WIDTH_Y = 31.50;   // 31.50
LENGTH_X = 39.43;  // 39
HEIGTH_Z = PART_THICK;

CORNER_RADIUS = 2.50;//5.5; // 

POST_OFFSET_XY = 3.6;
WALL_THICK = 3;

BOLT_DIA = 2.1;   // true is 2
BOLT_HEAD = 3.9;  // true is 3.8
BOLT_COUNTERSINK = 2;

module insides()
{
    linear_extrude(height = HEIGTH_Z)
    offset(r = CORNER_RADIUS)
    // there are 2 radius's in the X and Y direction
    square([WIDTH_Y - CORNER_RADIUS*2, 
            LENGTH_X - CORNER_RADIUS*2],
            center = true);
    
}

module outsides()
{
    linear_extrude(height = HEIGTH_Z)
    offset(r = CORNER_RADIUS)
    // there are 2 radius's and 2 wall in the X and Y direction
    square([WIDTH_Y + WALL_THICK*2 - CORNER_RADIUS*2,
            LENGTH_X + WALL_THICK*2 - CORNER_RADIUS*2], 
            center = true);
}

difference()
{
    color("YELLOW") outsides();
    translate([0,0, WALL_THICK])
    color("GREEN") insides();
    
        // drill out bolt holes.
    translate([WIDTH_Y/2 - POST_OFFSET_XY, 
               LENGTH_X/2 - POST_OFFSET_XY]) cylinder(d = BOLT_DIA, h = 10);
    translate([-WIDTH_Y/2 + POST_OFFSET_XY, 
               -LENGTH_X/2 + POST_OFFSET_XY]) cylinder(d = BOLT_DIA, h = 10);
      
    translate([WIDTH_Y/2 - POST_OFFSET_XY, 
               -LENGTH_X/2 + POST_OFFSET_XY]) cylinder(d = BOLT_DIA, h = 10);
    translate([-WIDTH_Y/2 + POST_OFFSET_XY, 
               LENGTH_X/2 - POST_OFFSET_XY]) cylinder(d = BOLT_DIA, h = 10);
      
    // counter sink bolt heads
    translate([WIDTH_Y/2 - POST_OFFSET_XY, 
               LENGTH_X/2 - POST_OFFSET_XY]) cylinder(d = BOLT_HEAD, h = BOLT_COUNTERSINK);
    translate([-WIDTH_Y/2 + POST_OFFSET_XY, 
               -LENGTH_X/2 + POST_OFFSET_XY]) cylinder(d = BOLT_HEAD, h = BOLT_COUNTERSINK);
      
    translate([WIDTH_Y/2 - POST_OFFSET_XY, 
               -LENGTH_X/2 + POST_OFFSET_XY]) cylinder(d = BOLT_HEAD, h = BOLT_COUNTERSINK);
    translate([-WIDTH_Y/2 + POST_OFFSET_XY, 
               LENGTH_X/2 - POST_OFFSET_XY]) cylinder(d = BOLT_HEAD, h = BOLT_COUNTERSINK);

    // wire exit
    translate([0, LENGTH_X/2, -.1]) #cylinder(d=8, h =WALL_THICK+1);

}