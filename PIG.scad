use <myTools.scad>
/*
module tube (r = 0, d = 0, l = 0, 
            thick = 0, 
            bCentered = true, 
            taper_pct = 0, 
            circlip = false) // r=radius d=dia l=length ;
*/
$fn=80;
DIA=42.3 + .2;
THICK = 4;
UP=4 + 1.4;
SHOULDER_HEIGHT = 2 * 4 + UP;
NUM = 11;
            
OUTSIDE_DIA = DIA + THICK *2;
//---------------------------------------------------------------------

module make_nub()
{
    NUB_HEIGHT = 10;
    NUB_DIA = 20;
    
    translate([ 0, 0, OUTSIDE_DIA/2-1])
    {
        cylinder(d=10, h=NUB_HEIGHT);

        translate([ 0, 0, NUB_DIA -1])
        sphere(d = NUB_DIA);
    }
}

module make_female()
{
    make_nub();
    difference()
    {
        difference()
        {
            sphere( d = DIA + THICK * 2);
            sphere( d = DIA + .1);
        }


        // open up one quadrant 
        translate([ -OUTSIDE_DIA, 0,  -OUTSIDE_DIA/2])
        union()
        {
            cube([OUTSIDE_DIA, OUTSIDE_DIA, OUTSIDE_DIA]);
        }
        
        // shave off anything below the x,y plane
        translate([ -OUTSIDE_DIA/2, -OUTSIDE_DIA/2,  -OUTSIDE_DIA])
        union()
        {
            cube([OUTSIDE_DIA, OUTSIDE_DIA, OUTSIDE_DIA]);
        }

        // small view hole on top
        translate([ 0, 0,  -OUTSIDE_DIA/2])
        cylinder(d=3, h = OUTSIDE_DIA);

    }
}
//---------------------------------------------------------------------
module make_keyway()
{
    KEY_WIDTH=10;
    KEY_HEIGHT=1.05;

    translate([ 0, 0, -UP])
    {
        difference()
        {
            union()
            {
                tube (d = DIA, l = SHOULDER_HEIGHT, thick = +THICK, bCentered = false, taper_pct = 0, circlip = false);
                translate([ -KEY_WIDTH/2, -DIA/2, 0])
                cube ([KEY_WIDTH, DIA+2, KEY_HEIGHT]);
            }
            #cylinder( d= (DIA - 1.57 *2), h = KEY_HEIGHT);
        }
    }
}
//---------------------------------------------------------------------
make_female();
make_keyway();
