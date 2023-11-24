$fn=25;

DEPTH = 130.;
//DEPTH = 20.;
WIDTH = 101;
HEIGHT = 25.4  ;
MAX_BOX_WIDTH = 87;

//outside dimensions of the box

lip = 8.0 ; 
lip_thick = 6;
                // tray hangs on a lip
width  = WIDTH - lip * 2;    //x dimension
depth = DEPTH;               //y dimension
height = HEIGHT;             //z dimension

if ( width > MAX_BOX_WIDTH)
{
    echo ("outside box width = ", width, "remove = ", width - MAX_BOX_WIDTH, " mm");
    assert(width < MAX_BOX_WIDTH);
}

//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall

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


difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
    // use posts to define OUTSIDE of a solid box centered on 0,0
    hull(){
        posts(  
            x=(width/2  - corner_radius),
            y=(depth/2 - corner_radius),
            z= 0,
            h= height,
            r = corner_radius);
    }
        
    // use posts to define INSIDE of a solid box centered on 0,0
    hull(){
        posts(
            x=(width/2  - corner_radius - wall_thickness),
            y=(depth/2 - corner_radius - wall_thickness),
            z= wall_thickness, // move up to create bottom
            h= height,
            r = corner_radius);
    }

}

translate ( [ width/2, -depth/2 + 5,  height - lip_thick ])
cube ( [ lip, depth - 10, lip_thick ] );

translate ( [ -width/2 -lip , -depth/2 + 5,  height - lip_thick ])
#cube ( [ lip, depth - 10, lip_thick ] );

