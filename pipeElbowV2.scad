//outside dimensions of the box

// eavestrough mouth dimensions.
width_in  = 2.125;    //x dimension
length_in = 3.125;    //y dimension

straight_run = 2.5;  // make it a few feet ha ha

/* [Hidden] */
$fn= $preview ? 50 : 75;

MM = 25.43;

width_mm = width_in * MM;
length_mm = length_in * MM;
straight_run_mm = straight_run * MM;

tilt = 6.15; //below 90 degrees

//additional parameters
wall_thickness = 4;

module mark() 
{
    if ($preview)  cylinder(h=10, r1 =2, r2=1);
}
//==============================================================
module my_iterator(angle = 0, length = 0)
{
    echo ("my_iterator has ", $children, "children" );
    
    if (angle != 0)
    {
        echo ("elbow requested has ", $children, "children" );
        for ( i = [0, $children - 1])
            rotate_extrude( angle= 90 - tilt)
            {
                children(i);
            }
            mark();
     }
     else if ( length != 0)
     {
        echo ("tube requested has ", $children, "children" );
        for ( i = [0, $children - 1])
            linear_extrude(height= length)
            //linear_extrude()
            {
                children(i);
            }
            mark();
     }
     else 
     {
        assert(1, "need angle or length");
     }
     echo ("angle =", angle, "length = ", length);
     echo (" ");
}


module make_2D_template() 
{
    x= width_mm / 2 + wall_thickness;
    y= length_mm /2 + wall_thickness;
    h= straight_run_mm;
    r = wall_thickness;
    z = 0;
    translate([ x + r , y  +r , 0])

    union()
    {
        translate([x,y,z]){         // move post to this location
            circle(r); // make one post
            translate([-x *2, -r, 0 ])
            color("RED")
            square([ x * 2 , r * 2]);
        }
        translate([-x,y,z]){        // move post to this location
            circle(r); // make one post
            rotate([0, 0, -90])
            translate([0, -r, 0 ])
            color("BLUE")
            square([ y * 2 , r * 2]);
        }   
        translate([-x,-y,z]){       // move post to this location
            circle(r); // make one post
            translate([0, -r, 0 ])
            color("CYAN")
            square([ x * 2 , r * 2]);
        }
        translate([x,-y,z]){        // move post to this location
            circle(r); // make one post
            rotate([0, 0, 90])
            translate([0, -r, 0 ])
            color("ORANGE")
            square([ y * 2 , r * 2]);
        }
   }
        
}

//========= main ==========================================================

{

    color("CYAN")
    rotate([-90, 0, 90 - tilt])
    my_iterator(length = straight_run_mm)
       make_2D_template();

    
    color("GREEN")
    translate([ 0, 0, -straight_run_mm * 3/2]) // move from center to axis. move from axis entirely to negative axis
    rotate([90, 0, 0])
    my_iterator(length = straight_run_mm)
       make_2D_template();

    color("RED")
    translate([0, 0, -straight_run_mm * 3/2]) // move from center to axis. move from axis entirely to negative axis
    my_iterator(angle = tilt)
        make_2D_template();
}    
    

