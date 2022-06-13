$fn=100;

fan_outside = 139.75;
fan_wall =    2.14;       // radius to straight wall

fan_inside_diameter=fan_outside - fan_wall * 2;
fan_inside_radius = fan_inside_diameter/2;

fan_thickness = 25.21;
fan_hole2hole = 124.75;
fan_screw_hole_diameter = 4.38;
fan_corner_radius = 6.34;


fan_holes_radius=sqrt( 2 * (fan_hole2hole * fan_hole2hole))/2;
echo (fan_holes_radius);

// make 4 "posts" about 0,0,0 offset by +/-x +/-y 
module posts(x,y,z,h,r)
{
    translate([x,y,z]){         // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([-x,y,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }   
    translate([-x,-y,z]){       // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([x,-y,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }    
}


module makeFanMount(thick = fan_thickness)
{
    difference() 
    {
        // make 2 boxes one inside the other and remove "inside box" from "outside box"
        // use posts to define OUTSIDE of a solid box centered on 0,0
        hull()
        {
            // solid box max fan dimensions
            posts(  
                x=(fan_outside/2  - fan_corner_radius),
                y=(fan_outside/2 - fan_corner_radius),
                z= 0,
                h= thick,
                r = fan_corner_radius);
        }

        // punch out the cylinder for the fan
        #cylinder( h=thick, r= fan_inside_radius, center=false);
        
        // punch out the screw holes
        posts(  
            x=fan_hole2hole/2,
            y=fan_hole2hole/2,
            z= 0,
            h= thick+1,
            r = fan_screw_hole_diameter * 8/10); // wee bit smaller for a screw grab
    }
}


floor_length = 9.75 * 25.4;
floor_width = (3+7/8) * 25.4;
floor_depth = 1.5 * 25.4;
floor_brim = 1 * 25.4;
floor_brim_thickness = .25 * 25.4;

distance_fan_to_floor = floor_depth;

wall_thickness = .128 * 25.4;

module makeFloorMount(depth=floor_depth)
{
    if ( depth != 0)
    {
        difference()
        {
            union()
            {
                echo ("depth =", depth);
                // make part goes into floor
                translate([0,0, -depth/2])
                {
                    color("RED", .9)
                    cube ([floor_length           , floor_width           , depth], center=true);
                    
                    // make the brim 
                    translate([0,0,  -depth/2 + floor_brim_thickness/2])
                    color("CYAN", .9)
                    cube([floor_length+floor_brim*2, floor_width+floor_brim*2, min(floor_brim_thickness, depth)], center=true);
                }
            }

            // hollow out part that goes into floor
            translate([0,0, -depth/2])
            color("BLACK")
            cube ([floor_length - wall_thickness *2 , floor_width - wall_thickness *2 , depth ], center=true);
        }
    }
    else
    {
        // requesting a template for a hull to hang onto, it has no thickness
        translate([0,0, -depth/2])
        cube([floor_length+floor_brim*2, floor_width+floor_brim*2, .1], center=true);
    }
}

// connect bottom of fan to top of register.
difference()
{
    hull()
    {
        color("BLUE")
        makeFanMount(.1);

        color("MAGENTA", .1)
        translate([0,0, distance_fan_to_floor -floor_depth])
        makeFloorMount(0);
    }
    //punch out the cylinder for the fan BIG
    translate([fan_outside/2 +1, 0, -1])
    #cylinder( fan_thickness, r= fan_inside_radius, center=false);

    translate([-fan_outside/2 -1, 0, -1])
    #cylinder( fan_thickness, r= fan_inside_radius, center=false);

}
// plop on fan1
translate([fan_outside/2 +1, 0, -floor_depth/2])
makeFanMount();
// plop on fan2
translate([-fan_outside/2-1, 0, -floor_depth/2])
makeFanMount();


color("GREEN", .3)
translate([0,0, distance_fan_to_floor])
makeFloorMount();
