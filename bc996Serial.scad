//outside dimensions of the box
width  = 57;    //x dimension
depth = 33;    //y dimension
height = 30;    //z dimension
$fn=50;

//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 2.70;      // size of screws for lid (0=no screws)
lid_thickness= 2;       // comment out if no lid required
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


color("YELLOW")
difference(){
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

        // now we have a simple hollow box.
        // use posts to define a LIP inside the wall 
        hull(){
            posts(
                x=(width/2  - corner_radius - lid_lip),
                y=(depth/2 - corner_radius - lid_lip),
                z= height - lid_thickness,
                h= lid_thickness + 1,
                r = corner_radius);
        }
        
        color("green")
        translate([width/4 , 0, height-lid_lip])
        rotate([0,90,0])
        #cylinder(h= 20, d=5);

    }
    
    // punch out the rs323 hole
    rs232_depth = (1 + 1/8) * 25.4;
    rs232_width = ( 1 + 1/4) * 25.4;
    rs232_height = ( 9/16 ) * 25.4;
    rs232_elevate = (1/16) * 25.4;  //solder joints not flush with board
    
    color("blue")
    translate([0,width/2 - rs232_depth + wall_thickness -1.5, rs232_height + rs232_elevate])
    #cube([rs232_width, rs232_depth, rs232_height], true );
}

// add screw in posts and drill out the center for screws
difference () {
    color("blue", .3)
    posts( 
        x=(width/2  - wall_thickness/2 - post_diameter/2),
        y=(depth/2 - wall_thickness/2 - post_diameter/2),
        z= wall_thickness - .5,
        h= height - wall_thickness - lid_thickness +.5,
        r = post_diameter/2);
    
     // ADD the holes for the screws.
    posts( 
        x=(width/2  - wall_thickness/2 - post_diameter/2),
        y=(depth/2 - wall_thickness/2 - post_diameter/2),
        z= wall_thickness - .5,
        h= height - wall_thickness - lid_thickness + 5,
        r = hole_diameter/2);
}


// create a lid
translate([10 + width, 0, 0]) 
difference()
{
    hull()
    {
            // make undrilled lid
            posts(
                x=(width/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                y=(depth/2 - corner_radius - wall_thickness/2 - lid_tolerance),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = corner_radius);
            
            // drill outholes for the screws via difference
            // ADD the holes for the screws.
    }
    color("red")
    // drill the holes in the lid
    posts( 
    x=(width/2  - wall_thickness/2 - post_diameter/2),
    y=(depth/2 - wall_thickness/2 - post_diameter/2),
    z= 0,
    h= lid_thickness,
    r = hole_diameter/2 +.2);


}
