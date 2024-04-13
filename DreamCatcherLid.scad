//outside dimensions of the box
CM=25.4;


//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= 2;       // comment out if no lid required
lid_lip = 5;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

width  = (4 + 3/8) * CM + 2 * wall_thickness;    //x dimension
length = 6 * CM;    //y dimension
height = .5 * CM;    //z dimension
$fn=50;

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

/*
difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
    // use posts to define OUTSIDE of a solid box centered on 0,0
    hull(){
        posts(  
            x=(width/2  - corner_radius),
            y=(length/2 - corner_radius),
            z= 0,
            h= height,
            r = corner_radius);
    }
        
    // use posts to define INSIDE of a solid box centered on 0,0
    hull(){
        posts(
            x=(width/2  - corner_radius - wall_thickness),
            y=(length/2 - corner_radius - wall_thickness),
            z= wall_thickness, // move up to create bottom
            h= height,
            r = corner_radius);
    }

    // now we have a simple hollow box.
    // use posts to define a LIP inside the wall 
    hull(){
        posts(
            x=(width/2  - corner_radius - lid_lip),
            y=(length/2 - corner_radius - lid_lip),
            z= height - lid_thickness,
            h= lid_thickness + 1,
            r = corner_radius);
    }
}
*/


// create a lid
translate([10 + width, 0, 0]) 
union() { 

    // make 2 boxes one inside the other and remove "inside box" from "outside box"
    // use posts to define OUTSIDE of a solid box centered on 0,0
    hull(){
        posts(  
            x=(width/2  - corner_radius),
            y=(length/2 - corner_radius),
            z= 0,
            h= lid_thickness *2,
            r = corner_radius);
    }

    // now we have a simple hollow box.
    // use posts to define a LIP inside the wall
    color("RED", 1)
    translate( [ 0, 0, -lid_thickness  ]) 
    hull(){
        posts(
            x=(width/2  - corner_radius - lid_lip),
            y=(length/2 - corner_radius - lid_lip),
            z= lid_thickness + 3,
            h= lid_thickness + 1,
            r = corner_radius);
    }

}



/*
difference()
{
    hull()
    {
            // make undrilled lid
            posts(
                x=(width/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                y=(length/2 - corner_radius - wall_thickness/2 - lid_tolerance),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = corner_radius);
            
            // drill outholes for the screws via difference
            // ADD the holes for the screws.
    }

}
*/
