//outside dimensions of the box
bottom_width  = 126 + 4+2+2;    //x dimension
top_width = 100+2+2;

depth = 80;    //y dimension
height = 45;   //z dimension
$fn=50;

//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= 2;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

fn=50;

// make 4 "posts" about 0,0,0 offset by +/-x +/-y 
module posts(x_bottom, x_top, y,z,h,r)
{
    translate([x_bottom,y,z]){      // move post to this location
        cylinder(r = r, h = h);     // make one post
    }
    translate([-x_bottom,y,z]){     // move post to this location
        cylinder(r = r, h = h);     // make one post
    }   
    translate([-x_top,-y,z]){       // move post to this location
        cylinder(r = r, h = h);     // make one post
    }
    translate([x_top,-y,z]){        // move post to this location
        cylinder(r = r, h = h);     // make one post
    }    
}

difference(){

    difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
        // use posts to define OUTSIDE of a solid box centered on 0,0
        hull(){
            #posts(  
                x_bottom =(bottom_width/2  + wall_thickness),
                x_top = (top_width/2 + wall_thickness),
                y=(depth/2 + wall_thickness ),
                z= 0,
                h= height,
                r = corner_radius);
        }
            
        // use posts to define INSIDE of a solid box centered on 0,0
        hull(){
            #posts(
                x_bottom =(bottom_width/2 - corner_radius),
                x_top =(top_width/2 - corner_radius),
                y=(depth/2 - corner_radius),
                z= wall_thickness, // move up to create bottom
                h= height,
                r = corner_radius);
        }

        // now we have a simple hollow box.
    }
    
    union()
    {
        GRAB_WIDTH = 25;
        translate ([-bottom_width/2 + GRAB_WIDTH, -depth/2 - wall_thickness*3, 25])
        {
            #cube( [bottom_width - GRAB_WIDTH*2, wall_thickness *4 , height]); 
        }

        HOLE_DIA=4.88;
        
        translate ([-bottom_width/5 , +depth/2 - wall_thickness , height * 3/4])
        rotate([-90, 0, 0]) #cylinder(h = wall_thickness * 5, d= HOLE_DIA);

        translate ([+bottom_width/5 , +depth/2 - wall_thickness , height * 3/4])
        rotate([-90, 0, 0]) #cylinder(h = wall_thickness * 5, d= HOLE_DIA);

    }
}