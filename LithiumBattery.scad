//outside dimensions of the box
use <usbA-C.scad>

wall_thickness = 4;     // total thickness of any wall

inside_dims= 1;
FUDGE = .5;

board_width  = 99.33;        //x dimension
board_length = 29.33;        //y dimension
board_height = 6.31;         //z MAX COMPONENT HEIGHT
board_thick = 1.58;

make_bottom = false;
make_top = true;

box_width  = board_width + (inside_dims ? wall_thickness : 0) + FUDGE;        //x dimension
box_length = board_length + (inside_dims ? wall_thickness : 0) + FUDGE;        //y dimension
box_height = board_height  + (inside_dims ? wall_thickness : 0) + 3;            //z dimension


$fn=50;
echo ("box_width= ", box_width, "box_length = ", box_length, "box_height =", box_height);

//additional parameters
corner_radius = 1;      // radius of box corners

post_diameter = 3.5;         // internal post for screws
hole_diameter = 2;           // size of screws for lid (0=no screws)
lid_thickness= 2;            // comment out if no lid required
lid_lip = 2; // 1.57 exact   // 0 makes lid flush to top
lid_tolerance = .5;          // shrink lid so not squeaky fit

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


x_inside = (box_width/2  - corner_radius - wall_thickness); 
y_inside = (box_length/2 - corner_radius - wall_thickness);
z_inside_top = (box_height - wall_thickness);

if (make_bottom)
{
    translate([ 0, 0, -box_height +.1])
    {
        difference () 
        {
            union()
            {
                difference() // make 2 boxes one inside the other and remove "inside box" from "outside box"
                {
                 
                    // use posts to define OUTSIDE of a solid box centered on 0,0
                    hull(){
                        // outside of box. This sits on 0,0,0 center
                        posts(  
                            x=(box_width/2  - corner_radius),
                            y=(box_length/2 - corner_radius),
                            z= 0,
                            h= box_height,
                            r = corner_radius);
                    }
                        
                    // use posts to define INSIDE of a solid box centered on 0,0
                    
                    hull(){
                        posts(
                            x= x_inside,
                            y= y_inside,
                            z= wall_thickness, // move up from 0,0,0 to create bottom
                            h= box_height,
                            r = corner_radius);
                    }

                    // now we have a simple hollow box.
                    
                    
                    // notch out the lip on the top/open face
                    // it cuts out enough to expose the top of the screw posts created later on 
                    
                    hull(){
                        posts(
                            x=(box_width/2  - corner_radius - lid_lip),
                            y=(box_length/2 - corner_radius - lid_lip),
                            z= box_height - lid_thickness,
                            h= lid_thickness + 1,
                            r = corner_radius);
                    }
                    //20.71
                    translate([x_inside - 28.11 - 1.6 + 9.09, -y_inside   , z_inside_top + lid_thickness])
                    rotate([90, 0, 0])
                    make_USBC( location = "BELOW");
                    
                    //7.11
                    translate([x_inside - 14.66 + 7.55, y_inside   , z_inside_top + lid_thickness])
                    rotate([-90, 0, 0])
                    make_USBA( location = "ABOVE"); // negative rotation cause below to be "above"
                    
                 }
                 if ($preview)
                 {
                     // make a virtual board.
                     color("BLUE", .2)
                     translate([-board_width/2, -board_length/2, z_inside_top + lid_thickness ]) 
                     cube ([ board_width, board_length, board_thick], center = false);
                }
             }     


             // generate a cross section viewer
              if (0) 
              {
                translate([ 0, 0, -25])
                cube ([ 100,100,100], center=false);
              }
          }
          #postNscrews();

     }
        
}

top_height = 18.45;

if (make_top)
{
    translate([ 0, 0, top_height+.1])
    rotate([0, -180, 0])

    difference () 
    {
        union()
        {
            difference() // make 2 boxes one inside the other and remove "inside box" from "outside box"
            {
             
                // use posts to define OUTSIDE of a solid box centered on 0,0
                hull(){
                    // outside of box. This sits on 0,0,0 center
                    posts(  
                        x=(box_width/2  - corner_radius),
                        y=(box_length/2 - corner_radius),
                        z= 0,
                        h= top_height,
                        r = corner_radius);
                }
                    
                
                //punch out.
                hull(){
                    posts(
                        x=(box_width/2  - corner_radius - lid_lip),
                        y=(box_length/2 - corner_radius - lid_lip),
                        z= lid_thickness,
                        h= top_height,
                        r = corner_radius);
                }
                // punch out switch 1
                translate([box_width/2 - 12.6, box_length/2, top_height ])
                rotate([90, 0, 0])
                #cylinder(d=8, h = 10);
                
                // punch out switch 2
                translate([box_width/2 - 13.78, -box_length/2 + 5, top_height ])
                rotate([90, 0, 0])
                #cylinder(d=8, h = 10);

                // punch out USB-a
                translate([box_width/2 -5 , -box_length/2 + 10.12 , top_height - 6.5 ])
                #cube([ 10, 13.4, 30]);
                        
            }
             
             
             if ($preview)
             {
                 // make a virtual board.
                 color("BLUE", .2)
                 translate([-board_width/2, -board_length/2, z_inside_top + lid_thickness ]) 
                 cube ([ board_width, board_length, board_thick], center = false);
            }
         }     
         // generate a cross section viewer
          if (0) 
          {
            translate([ 0, 0, -25])
            cube ([ 100,100,100], center=false);
          }
    }
}


module postNscrews()
{
    // add screw in posts and drill out the center for screws
    difference () {
        posts( 
            x=(box_width/2  - wall_thickness/2 - post_diameter/2),
            y=(box_length/2 - wall_thickness/2 - post_diameter/2),
            z= wall_thickness - .5,
            h= box_height - wall_thickness - lid_thickness +.5,
            r = post_diameter/2);

         // ADD the holes for the screws.
        posts( 
            x=(box_width/2  - wall_thickness/2 - post_diameter/2),
            y=(box_length/2 - wall_thickness/2 - post_diameter/2),
            z= wall_thickness - .5,
            h= box_height - wall_thickness - lid_thickness + 5,
            r = hole_diameter/2);
    }
}

/*
// create a lid
translate([10 + box_width, 0, 0]) 
difference()
{
    hull()
    {
            // make undrilled lid
            posts(
                x=(box_width/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                y=(box_length/2 - corner_radius - wall_thickness/2 - lid_tolerance),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = corner_radius);
            
            // drill outholes for the screws via difference
            // ADD the holes for the screws.
    }
    color("red")
    // drill the holes in the lid
    posts( 
    x=(box_width/2  - wall_thickness/2 - post_diameter/2),
    y=(box_length/2 - wall_thickness/2 - post_diameter/2),
    z= 0,
    h= lid_thickness,
    r = hole_diameter/2 +.5);

}

*/
