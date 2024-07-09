use <ThreadMaker.scad>

/* [Hidden] */

//ABS PIPE
$fn= $preview ? 50 : 100;

FUDGE=.5; 
MM=25.4;

// 3" pipe

THICK= 3;
LENGTH = 30;

OD_ABS= 88.9 + FUDGE;  // and a 3" pipe isn't exactly a 3" pipe. Geeez.
OD_FITTING= OD_ABS + THICK * 2;
GRATE_DEPTH =10;

module cut_grille()
{
    GRID = 3;
    DIA = 10;
    difference()
    {
        cylinder(h = GRATE_DEPTH, d= (OD_ABS + 1 ));
        
        SPACE_PCT = 1.6;
        ADJ_DIA = DIA * SPACE_PCT;
        
        translate([0, 0, -.1])
        {
        
            for (across = [ -GRID: GRID]) 
            {
                for( down = [ -GRID: GRID])
                {
                    translate( [ across * ADJ_DIA, 
                                 down   * ADJ_DIA,
                                 0 ])
                    color ( (across % 2 == 0) ? "RED" : "GREEN")
                    cylinder(h = GRATE_DEPTH + 2, d= DIA);
                }
            }

            translate([ ADJ_DIA/2, ADJ_DIA/2, 0])
            for (across = [ -GRID: GRID]) 
            {
                for( down = [ -GRID: GRID])
                {
                    translate( [ across * ADJ_DIA, 
                                 down   * ADJ_DIA,
                                 0 ])
                    color ( (across % 2 == 0) ? "BLUE" : "CYAN")
                    cylinder(h = GRATE_DEPTH + 2, d= DIA);
                }
            }
            translate([OD_FITTING * 1/4 + 6, -OD_ABS * 1/2, -1 ])
            cube ([ OD_ABS, OD_ABS, GRATE_DEPTH +2], center = false);
        }
    }
}

if (0)
    cut_grille($fn=50);
else
{
    difference()
    {
        cylinder(h = LENGTH *2 , d= (OD_FITTING));
        cylinder(h = LENGTH *2 + .1 , d= OD_ABS);

    }
    //translate([ 0, 0, -1])
    #cut_grille($fn=50);
}