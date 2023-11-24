print_lid = 1;
print_box = 0;

CM=25.4;
inside_width  = (4+1/2) * CM;    //x dimension
inside_length = 6 *CM;    //y dimension
inside_heigth = 1/2 *CM;    //z dimension
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall

//outside dimensions of the box
outside_width  = inside_width + corner_radius + wall_thickness;    //x dimension
outside_length = inside_length + corner_radius + wall_thickness;    //y dimension
outside_heigth = 30;    //z dimension
$fn=50;

//additional parameters

post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= 3;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

fn=50;

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

if (print_box)
{
difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
    // use posts to define OUTSIDE of a solid box centered on 0,0
    hull(){
        posts(  
            x=(outside_width/2  ),
            y=(outside_length/2 ),
            z= 0,
            h= outside_heigth,
            r = corner_radius);
    }
        
    // use posts to define INSIDE of a solid box centered on 0,0
    hull(){
        posts(
            x=(outside_width/2  - corner_radius - wall_thickness/2),
            y=(outside_length/2 - corner_radius - wall_thickness/2),
            z= wall_thickness, // move up to create bottom
            h= outside_heigth,
            r = corner_radius);
    }
/*
    // now we have a simple hollow box.
    // use posts to define a LIP inside the wall 
    hull(){
        posts(
            x=(outside_width/2  - corner_radius - lid_lip),
            y=(outside_length/2 - corner_radius - lid_lip),
            z= outside_heigth - lid_thickness,
            h= lid_thickness + 1,
            r = corner_radius);
    }
*/    
}
}

if (print_lid)
{
// create a lid
translate([15 + outside_width, 0, 0]) 
union()
{
    hull(){
        posts(  
            x=(outside_width/2 ),
            y=(outside_length/2 ),
            z= 0,
            h= lid_thickness,
            r = corner_radius);
    }
    color("RED")
    translate ([0, 0, lid_thickness * 3/4])
    hull()
    {
            posts(
                x=(outside_width/2  - corner_radius - wall_thickness/2 -lid_tolerance/2),
                y=(outside_length/2 - corner_radius - wall_thickness/2 -lid_tolerance/2),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = corner_radius);
            
    }

}
}
