
$fn=100;

// make 3 "makeScrewHoles" in a circle 
module makeScrewHoles(h, rad,  screw_dia)
{
    offset = 90;
    for (spin = [0: 1: 2])
    {
        echo("screw hole at  = ", spin * 120 + offset, " degrees");
        rotate([0,0,  + spin * 120 + offset]) 
        {
            translate([rad,0,0])
            // move post to this location
            cylinder(d = screw_dia, h = h); // make one post
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
hole_diameter = 3/16 * 25.4;      // size of screws for lid (0=no screws)
base_diameter = 50;

bottom_base_radius = base_diameter/2;
top_base_radius = bottom_base_radius * 3 / 4;

post_diameter =  top_base_radius /2 ;

post_up = 25.4;
post_across =  bottom_base_radius;
post_height = 25.4;

{
    difference()
    {
        union()
        {
            cylinder(thick, r1=bottom_base_radius, r2=top_base_radius);

            // post up
            translate([0,0, thick ])
            {
                minion(post_up, post_diameter);
            }
           // post across
            translate([0, -post_diameter/4 +3, thick + post_up])
            {
               rotate([90,0,0])
               #minion(post_across, post_diameter);
            }
        }
        
        //shave bottom of mount
        translate([0,0, -thick]) 
        #cylinder(h=thick, r=bottom_base_radius);
        difference()
        {
            union()
            {
                makeScrewHoles(thick+1, top_base_radius * 3/4 , hole_diameter);  
            }
            
        }  // box is fully formed
    }    
}
