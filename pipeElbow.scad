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
module punch_2D_template(wall = 0)
{
    echo($children, " children seen");
    
    assert( wall, "wall size must be non zero");

    if (wall > 0)
    {
        translate([wall, wall]) // y = wall... for wall is on outside
        color("GREEN")

        for ( achild = [0:1:$children-1])
        difference()
        {
            union()
            {
                // ensure object will not be crossing -x or -y
                 offset(r = wall) 
                  children(achild);
            }
            union() children(achild);
        }
    }
    else
    {
        translate([wall, 0]) // yes y = 0 ... for wall is on inside.
        color("RED")

        for ( achild = [0:1:$children-1])
        difference()
        {
            union() children(achild);
            // ensure object will not be crossing -x or -y
            union()
            {
                offset(r = wall) 
                children(achild);
            }
        }
    }
}
//==============================================================
module make_elbow(bender = 0)
{
    assert(bender != 0, "need elbow bend degree specifed > 0");

    echo ("");
    for ( achild = [0:1:$children-1])

    color("GREEN")

    // first child is the outside body description 
    rotate_extrude(angle= bender)
                { children(0);}

}
//==============================================================
module make_pipe(len = 0)
{
    assert(len != 0, "need pipe length specifed > 0");

    echo ("");
    for ( achild = [0:1:$children-1])

    color("GREEN")

    // make it "stand up" in the Z plane
    rotate([90, 0, 0])

    // first child is the outside body description 
    linear_extrude(height = len)
                { children(0);}

}
//==============================================================
make_elbow(bender = 60) 
{
    punch_2D_template(+2) translate([16,0,0])
        {
            recipe_raceway2D(INSIDE_DIM = 10);
            //square(5);
            //circle(d=10);
        };
}

//==============================================================
make_pipe(len = 22) 
{
    punch_2D_template(+2) translate([16,0,0])
        {
            recipe_raceway2D(INSIDE_DIM = 10);
        };
}

//==============================================================
make_pipe(len = 32) 
{

    punch_2D_template(-2) translate([36,0,0])
        {
            rotate([20, 0, 0])
            recipe_raceway2D(INSIDE_DIM = 10);
        };
}


//==============================================================
module recipe_raceway2D(INSIDE_DIM= 0)
{
    assert(INSIDE_DIM," CableRaceway needs dimemsion");
    translate([ INSIDE_DIM/2, INSIDE_DIM, 0])
    circle(d= INSIDE_DIM);

    translate([ INSIDE_DIM/2, INSIDE_DIM/2, 0])
    circle(d= INSIDE_DIM);

    square([ INSIDE_DIM, INSIDE_DIM/2], false);
}
