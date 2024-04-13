$fn=20;

MAIN_BODY_DIA=24;

THREADED_DIA=8.6;
CLEAR_DIA = THREADED_DIA + 1;

POINTY_LEN=30;

BODY_LEN= .5 * 25.4;

THREADED_LENGTH= 4;

module remove()
{
    translate([ 0, 0, -POINTY_LEN ])
    color("RED") cylinder(d= THREADED_DIA, h=THREADED_LENGTH, true);

    // don't run the fat hole all the way to the bottom.
    color("BLUE") translate([ 0, 0, -POINTY_LEN + THREADED_LENGTH])
    cylinder(d= CLEAR_DIA, h=BODY_LEN + POINTY_LEN *2 - THREADED_LENGTH , true); 
    
 }
 
 module add()
 {
        color("CYAN", .3) cylinder(d=MAIN_BODY_DIA, h=BODY_LEN, true);

        translate([0, 0, -POINTY_LEN/2])
        color("GREEN", .3)
        cylinder(r2=MAIN_BODY_DIA/2, r1= THREADED_DIA/2 + 2, h=POINTY_LEN, true);

        translate([0, 0, BODY_LEN + POINTY_LEN/2])
        rotate([180,0,0])
        color("YELLOW", .3)
        cylinder(r2=MAIN_BODY_DIA/2, r1=CLEAR_DIA/2 +2, h=POINTY_LEN, true);

}


//add();
//remove();

difference()
{
        add();
        remove();
}


