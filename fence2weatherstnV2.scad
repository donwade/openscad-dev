
$fn=100;

// make 3 "makeScrewHoles" in a circle 
module makeScrewHoles(h, dia,  screw_dia)
{
    offset = 90;
    for (spin = [0: 1: 2])
    {
        echo("screw hole at  = ", spin * 120 + offset, " degrees");
        rotate([0,0,  + spin * 120 + offset]) 
        {
            translate([dia/2,0,0])
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
hole_diameter = 5/32 * 25.4;      // size of screws for lid (0=no screws)
base_diameter = 50;
post_diameter =  (1 ) * 25.4 ; // 1 3/8 other
post_up = 2 * 25.4;
post_across = 7 * 25.4;
post_height = 25.4;

{
    difference()
    {
        union()
        {
            cylinder(thick, r1=base_diameter, r2=base_diameter * 3/4);

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
        #cylinder(h=thick, r=base_diameter);
        difference()
        {
            union()
            {
                makeScrewHoles(thick+1, base_diameter * 1.2, hole_diameter);  
            }
            
        }  // box is fully formed
    }    
}
