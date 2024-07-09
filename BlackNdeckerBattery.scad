
//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= 0;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

FUDGE=2;

//INSIDE dimensions of the box
width  = 78 + wall_thickness * 2 + FUDGE;    //x dimension
length = 52 + wall_thickness * 2 + FUDGE;    //y dimension
height = 75;    //z dimension

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

module make_box()
{
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

    }
}

difference()
{
    make_box();
    translate([-50, 50, 50])
    rotate([70,0,0])
    cube([100,100,100]);
    
    translate([0, 50, 67])
    rotate([90,0,0])
    #cylinder(h =100, d= 4);
}