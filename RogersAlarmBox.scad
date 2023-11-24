//outside dimensions of the box
inside_width  = 107 + 2;    //x dimension
inside_depth =   50 + 2;    //y dimension
height = 10;   //z dimension

//additional parameters
corner_radius = 2;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall

$fn=50;

// make 4 "posts" about 0,0,0 offset by +/-x +/-y 
module posts(x_inside, y,z,h,r)
{
    translate([x_inside,y,z]){      // move post to this location
        cylinder(r = r, h = h);     // make one post
    }
    translate([-x_inside,y,z]){     // move post to this location
        cylinder(r = r, h = h);     // make one post
    }   
    translate([-x_inside,-y,z]){       // move post to this location
        cylinder(r = r, h = h);     // make one post
    }
    translate([x_inside,-y,z]){        // move post to this location
        cylinder(r = r, h = h);     // make one post
    }    
}

difference()
{
    translate( [ -inside_width /2, inside_depth/2 + wall_thickness + corner_radius  , +height])
    {
        rotate( [ 90, 0, 0 ])
        #cube ([ inside_width + wall_thickness, inside_depth/4,  wall_thickness], center=false);
    }

    translate( [ inside_width /4 , inside_depth/2 + wall_thickness*2 , height * 7/4 ])
    rotate( [ 90, 0, 0 ])
    cylinder(height, d = 3/16 * 25.4, center = false);

    translate( [ -inside_width /4 , inside_depth/2 + wall_thickness*2 , height * 7/4 ])
    rotate( [ 90, 0, 0 ])
    cylinder(height, d = 3/16 * 25.4, center = false);
}

difference(){

    difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
        // use posts to define OUTSIDE of a solid box centered on 0,0
        hull(){
            posts(  
                x_inside =(inside_width/2  + wall_thickness),
                y=(inside_depth/2 + wall_thickness ),
                z= 0,
                h= height,
                r = corner_radius);
        }
            
        // use posts to define INSIDE of a solid box centered on 0,0
        hull(){
            posts(
                x_inside =(inside_width/2 - corner_radius),
                y=(inside_depth/2 - corner_radius),
                z= wall_thickness, // move up to create bottom
                h= height - wall_thickness,
                r = corner_radius);
        }

        // now we have a simple hollow box.
    }
}