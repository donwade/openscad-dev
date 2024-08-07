use <myTools.scad>
$fn=100;

MM = 25.4;
DOWN = 9.5 * MM;
ACROSS = 3.5 * MM;

LEN=180;
DIA=3.5;
WALL_THICK=1.5;
OUT_THICK = WALL_THICK *2 + DIA;
//----------------------------------------------------------------

// ********************
// EVERYTHING MUST BE 2D and also in POSTIVE X /Y co-ordinates
// ********************

module make_2dTemplate()
{
    translate([ OUT_THICK/2, OUT_THICK/2, 0])
    rotate([ 0, 0, 90])
    difference()
    {
        union()
        {
            circle(d= OUT_THICK);
            translate([-WALL_THICK ,0, 0 ])
            square([ OUT_THICK/2, OUT_THICK], true);
        }
        
        circle(d= DIA);
        
        translate([-WALL_THICK +2 ,0, 0 ])
        circle(d= DIA);
        
        translate([-WALL_THICK*2 + .4 ,0, 0 ])
        circle(d= DIA );
    }
}

module make_pipeV2(LONG = 10)
{
    if (LONG > 0)
    {
        linear_extrude(height = LONG)
        make_2dTemplate();
    }
    else
    {
        translate([ 0, 0, LONG])
        linear_extrude(height = -LONG)
        make_2dTemplate();
    }
}

//minkowski()
{
    color("CYAN")
    rotate([ 90, 0, 0])
    make_pipeV2(-DOWN);

    color("PINK")
    rotate([ 90, 0, -90])
    make_pipeV2(ACROSS);

    // MAKE ELBOW FROM 2D TEMPLATE
    color("GREEN")
    rotate([ 0,0, -90])       // face elbow towards what quadrant
    rotate_extrude(angle= 90) // 90 is for elbow degrees 
    make_2dTemplate();
    
}
