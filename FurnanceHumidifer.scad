use <myTools.scad>
$fn=100;

OUTER_DIA =150;
THICK = 10;

BOX= OUTER_DIA + 40;
PIPE_HEIGHT = 40;

SLIDE_THICK = 10;
BOX_THICK = THICK *3 + SLIDE_THICK;

SCREW_DIA = 1/4 * 25.4;

module scew_quad ()
{
    for ( x = [ -1: 1 ])
    {
        for ( y = [ -1: 1 ])
        {
            //if ( x && y )
            {
                xx = x * (BOX /2 - THICK);
                yy = y * (BOX/2 -THICK);
                echo ("xx ", xx, "yy =", yy);
                
                translate([ -xx, -yy,  -50 ]) 
                cylinder( d=SCREW_DIA, h = 100);
            }
        }
    }
}

difference()
{
    color("RED", .4)
    union()
    {
        cube ([ BOX, BOX, BOX_THICK], center=true);

        color("GREEN", .5)
        translate([ 0, 0, -THICK * 4 ])
        cylinder( h = PIPE_HEIGHT*2, d=OUTER_DIA, center = true);
    }
 
    color("GREEN", .5)
    translate([ -THICK, 0, -THICK/4])
    cube ([ BOX , OUTER_DIA - THICK, SLIDE_THICK], center=true );

    color("BLACK", .3)
    translate([ 0, 0, -PIPE_HEIGHT +1]) // +1 punch
    cylinder( h = PIPE_HEIGHT*3, d=OUTER_DIA - THICK*2, center = true);
    
    color("CYAN")
    scew_quad();
}
