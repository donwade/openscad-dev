use <myTools.scad>
$fn=100;

OUTER_DIA =150;
THICK = 7;

BOX= OUTER_DIA + 40;
PIPE_HEIGHT = 40;

BOX_THICK = THICK *3;

SCREW_DIA = 3/16 * 25.4;

module scew_quad ()
{
    for ( x = [ -1: 1 ])
    {
        for ( y = [ -1: 1 ])
        {
            //if ( x && y )
            {
                xx = x * (BOX /2 - THICK *2);
                yy = y * (BOX/2 -THICK *2);
                echo ("xx ", xx, "yy =", yy);
                
                translate([ -xx, -yy,  -50 ]) 
                cylinder( d=SCREW_DIA, h = 100);
            }
        }
    }
}
bMakeBase=1;

if ( bMakeBase)
{
    difference()
    {
        color("RED", .7)
        union()
        {
            cube ([ BOX, BOX, BOX_THICK], center=true);

            color("GREEN", .5)
            translate([ 0, 0, (THICK + THICK/2)] )
            #cylinder( h = PIPE_HEIGHT, d=OUTER_DIA, center = false);
        }
     
        color("GREEN", .5)
        translate([ -THICK, 0, -THICK/4])
        cube ([ BOX , OUTER_DIA - THICK, THICK], center=true );

        color("BLACK", .3)
        translate([ 0, 0,  -THICK - THICK/2 -.1]) // +1 punch
        cylinder( h = PIPE_HEIGHT + 4 * THICK, d=OUTER_DIA - THICK*2, center = false);
        
        color("CYAN")
        scew_quad();
    }
}
else
{
    color("GREEN", .5)
    //translate([ -THICK, 0, -THICK/4])
    difference()
    {
        cube ([ 235 , OUTER_DIA - THICK - 1.5, THICK-1], center=true );
        translate([-250/2 + 25/2 + 10, 0, 0])
        #cylinder(h=20, d=20, center=true);
    }
}