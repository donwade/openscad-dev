
//outside dimensions of the box
box_length  = 77;    //x dimension
box_width = 45;    //y dimension
box_height = 25;    //z dimension
$fn=100;

// make 3 "makeScrewHoles" in a circle 
module makeScrewHoles(h, dia,  r)
{
    for (spin = [0: 1: 3])
    {
        echo("spin = ", spin * 120);
        rotate([0,0, spin * 120]) 
        {
            translate([dia/2,0,0])
            // move post to this location
            cylinder(r = r, h = h); // make one post
        }
    }
}

module minion(height, diameter)
{
    union()
    {
        cylinder(h=height, d=diameter);
        sphere(d = diameter);
        translate([0, 0, height])
        sphere(d = diameter);
    }
}
thick = 10;
hole_diameter = 3;      // size of screws for lid (0=no screws)
base_diameter = 40;
post_diameter = 20;
post_height = 25.4;

{
    difference()
    {
        union()
        {
            cylinder(thick, r1=base_diameter, r2=base_diameter * 3/4);

            // post up
            translate([0,0, thick])
            {
                #minion(post_height, post_diameter);
            }
           // post across
            translate([0, -post_diameter/4 +3, thick + post_height])
            {
               rotate([90,45,0])
               minion(post_height, post_diameter);
            }
        }
        difference()
        {
            union()
            {
                makeScrewHoles(thick+1, base_diameter, hole_diameter);  
            }
            
        }  // box is fully formed
    }    
}
