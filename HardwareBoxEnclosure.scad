//outside dimensions of the box
use <usbA-C.scad>

make_bottom = true;
make_top = false;

board_x  = 99.33;   //x dimension
board_y = 29.33;    //y dimension
board_z = 1.58;     // board thickness

tallest_top_component = 6.31;           //z MAX COMPONENT HEIGHT
tallest_bottom_component = 10;          //

LEDGE=2.5;
wall_thickness = 4;    // total thickness of any wall

/* [Hidden] */

FUDGE = .5;

BOARD = [ board_x, board_y, board_z ];

box_x = board_x + wall_thickness * 2 + FUDGE;   //x dimension
box_y = board_y + wall_thickness * 2 + FUDGE;   //y dimension
box_bottom_z = tallest_bottom_component  + wall_thickness;  //z dimension

BOX_OUTSIDE = [ box_x, box_y, box_bottom_z ];

$fn=50;
echo ("box_x= ", box_x, "box_y = ", box_y, "box_bottom_z =", box_bottom_z);

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


x_inside = (board_x  + LEDGE) /2; 
y_inside = (board_y + LEDGE) /2;
z_inside_top = (box_bottom_z - wall_thickness - LEDGE/2);

x_ledge = (board_x  - LEDGE * 2); 
y_ledge = (board_y - LEDGE * 2);
z_ledge = (box_bottom_z - wall_thickness - LEDGE);

if (make_bottom)
{
    /*
    if ($preview)
    {
        // board top face sits on [0, 0 ];
        // make a virtual board.
        color("BLUE", .2)

        translate([-board_x/2, -board_y/2, -board_z]) 
        cube ([ board_x, board_y, board_z], center = false);
    }
    */

    translate([ 0, 0, -box_bottom_z ])
    {
        difference () 
        {
            union()
            {
                difference() // make 2 boxes one inside the other and remove "inside box" from "outside box"
                {
                 
                    // use posts to define BOX_OUTSIDE of a solid box centered on 0,0
                    hull()
                    {
                        posts(  
                            x=(box_x/2  - corner_radius),
                            y=(box_y/2 - corner_radius),
                            z= 0,
                            h= box_bottom_z,
                            r = corner_radius);
                    }
                        
                    //translate([0, 0, -z_ledge])
                    //    #cube([ x_ledge, y_ledge, wall_thickness ], true);

                    // now we have a simple hollow box.
                    
                    
                    // notch out the lip on the top/open face
                    // it cuts out enough to expose the top of the screw posts created later on 
                    
                    hull(){
                        #posts(
                            x=(board_x/2 ),
                            y=(board_y/2 ),
                            z= box_bottom_z - lid_thickness,
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

top_height = 18.45 + 3;

if (make_top)
{

             if ($preview)
             {
                 // make a virtual board.
                 color("BLUE", .1)
                 translate([-board_x/1, -board_y/2, z_inside_top + lid_thickness ]) 
                 cube ([ board_x, board_y, board_z], center = false);
            }

    translate([ 0, 0, top_height+.1])
    rotate([0, -180, 0])

    difference () 
    {
        union()
        {
            difference() // make 2 boxes one inside the other and remove "inside box" from "outside box"
            {
                union()
                {
                    // use posts to define BOX_OUTSIDE of a solid box centered on 0,0
                    hull(){
                        // outside of box. This sits on 0,0,0 center
                        posts(  
                            x=(box_x/2  - corner_radius),
                            y=(box_y/2 - corner_radius),
                            z= 0,
                            h= top_height,
                            r = corner_radius);
                    }
                    brim();
                }
                
                //punch out.
                hull(){
                    posts(
                        x=(box_x/2  - corner_radius - lid_lip),
                        y=(box_y/2 - corner_radius - lid_lip),
                        z= lid_thickness,
                        h= top_height,
                        r = corner_radius);
                }
                // punch out switch 1
                translate([box_x/2 - 12.6, box_y/2 + 5, top_height ])
                rotate([90, 0, 0])
                #cylinder(d=8, h = 10);
                
                // punch out switch 2
                translate([box_x/2 - 13.78 - 1, -box_y/2 + 5, top_height ])
                rotate([90, 0, 0])
                #cylinder(d=8, h = 10);

                // punch out USB-a
                translate([box_x/2 -5 , -box_y/2 + 10.12 +2 , top_height - 6.5 ])
                #cube([ 10, 13.4, 30]);
                        
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
    
module brim()
{
    translate([0, 0, 5])
    color("BLUE")
    difference()
    {
        // outide of box
        hull(){
            posts(
                x= box_x/2 ,
                y= box_y/2,
                z= wall_thickness*2, // move up from 0,0,0 to create bottom
                h= 10,
                r = corner_radius);
        }
        
        //punch out
        hull(){
            // original outside of box. This sits on 0,0,0 center
            #posts(  
                x=(box_x/2 - corner_radius ),
                y=(box_y/2 - corner_radius),
                z= -3 + wall_thickness *2,
                h= 15,
                r = corner_radius);
        }
    }
}


module postNscrews()
{
    // add screw in posts and drill out the center for screws
    difference () {
        posts( 
            x=(box_x/2  - wall_thickness/2 - post_diameter/2),
            y=(box_y/2 - wall_thickness/2 - post_diameter/2),
            z= wall_thickness - .5,
            h= box_bottom_z - wall_thickness - lid_thickness +.5,
            r = post_diameter/2);

         // ADD the holes for the screws.
        posts( 
            x=(box_x/2  - wall_thickness/2 - post_diameter/2),
            y=(box_y/2 - wall_thickness/2 - post_diameter/2),
            z= wall_thickness - .5,
            h= box_bottom_z - wall_thickness - lid_thickness + 5,
            r = hole_diameter/2);
    }
}

/*
// create a lid
translate([10 + box_x, 0, 0]) 
difference()
{
    hull()
    {
            // make undrilled lid
            posts(
                x=(box_x/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                y=(box_y/2 - corner_radius - wall_thickness/2 - lid_tolerance),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = corner_radius);
            
            // drill outholes for the screws via difference
            // ADD the holes for the screws.
    }
    color("red")
    // drill the holes in the lid
    posts( 
    x=(box_x/2  - wall_thickness/2 - post_diameter/2),
    y=(box_y/2 - wall_thickness/2 - post_diameter/2),
    z= 0,
    h= lid_thickness,
    r = hole_diameter/2 +.5);

}

*/
