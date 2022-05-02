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
            h= fan_thickness,
            r = fan_corner_radius);
    }

    cylinder( h=fan_thickness+1, r= fan_inside_radius, center=false);
    
    // punch out the screw holes
    posts(  
        x=fan_hole2hole/2,
        y=fan_hole2hole/2,
        z= 0,
        h= fan_thickness+1,
        r = fan_screw_hole_diameter);
}
