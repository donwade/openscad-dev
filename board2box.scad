use <usbA-C.scad>

FUDGE=.25;
wall_thickness = 2;     // total thickness of any wall



board_x  = 99.33;   //x dimension                                                     
board_y = 29.33;    //y dimension
board_z = 1.58;     // board thickness

bolt_inside_x = 91.93;
bolt_outside_x = 97.63;

bolt_inside_y = 22.01;
bolt_outside_y = 27.75;


bolt_diameter_x = (bolt_outside_x - bolt_inside_x)/2; // (0=no screws)
bolt_diameter_y = (bolt_outside_x - bolt_inside_x)/2; // (0=no screws)

bolt_diameter = (bolt_diameter_x + bolt_diameter_y)/2;
echo ("bolt_diameter x = ",bolt_diameter);

bolt_drill_diameter = 2.5;  // appropriate drill for bolt dia

//post_diameter = bolt_diameter + .68;  // internal post for screws
post_diameter = bolt_diameter * 1.25;  // internal post for screws

underside_tallest_component = 6;

cross_section = false;

//-------------------------------------------------------------
//-------------------------------------------------------------

/* [Hidden] */


bolt_center_x  = (bolt_inside_x + bolt_outside_x)/2;   //x dimension                                                     
bolt_center_y  = (bolt_inside_y + bolt_outside_y)/2;   //y dimension

//outside dimensions of the box
box_outside_x = board_x + wall_thickness * 2  + FUDGE;   //x dimension
box_outside_y = board_y + wall_thickness * 2  + FUDGE;    //y dimension
box_outside_z = max(wall_thickness * 2, underside_tallest_component + wall_thickness + board_z + 1);   //z dimension

$fn=50;

//additional parameters
lid_thickness= 2;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

fn=50;
//-------------------------------------------------------------------------
// make 4 cylinders EXACTLY on all 4 xy permutations
module quad_cylinders(x,y,z,h,r)
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
//-------------------------------------------------------------------------
module add_screws()
{
    // add screw in posts and drill out the center for screws
    color("CYAN")
     difference () {
        quad_cylinders( 
            x= bolt_center_x/2,
            y= bolt_center_y/2,
            z= -(box_outside_z- wall_thickness + board_z),
            h= box_outside_z- wall_thickness,
            r = post_diameter  // no div/2 beef up bolt support
        );
    
         // ADD the holes for the screws.
        quad_cylinders( 
            x= bolt_center_x/2,
            y= bolt_center_y/2,
            z= -(box_outside_z- wall_thickness + board_z),
            h= box_outside_z- wall_thickness,
            r = bolt_drill_diameter/2
        );
    }
} 

//-------------------------------------------------------------------------

// make 4 cylinders to set boundaries for a hull
// all cylinders must be COMPLETELY INSIDE the x,y specs

module prep_roundbox(x,y,z,h,r)
{
    translate([x-r,y-r,z]){         // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([-x+r,y-r,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }   
    translate([-x+r,-y+r,z]){       // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([x-r,-y+r,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }    
}
//-------------------------------------------------------------------------
difference()
{
    // build the box
    union()
    {
        difference() {
           // make 2 boxes one inside the other and remove "inside box" from "outside box"
            // use prep_roundbox to define OUTSIDE of a solid box centered on 0,0
            hull(){
                prep_roundbox(  
                    x=(box_outside_x/2),
                    y=(box_outside_y/2),
                    z= -box_outside_z,
                    h= box_outside_z,
                    r = wall_thickness/2);
            }

            
            // as board will not be below the prep_roundbox and
            // the prep_roundbox aren't too beefy
            // Hollow out a 1mm ledge that the BOTTOM 
            //       of the board can sit on. 
            //aka 1mm support perimeter
            
            hull(){
                prep_roundbox(
                    x=(board_x/2 - 1 ),
                    y=(board_y/2 - 1),
                    z= -(box_outside_z- wall_thickness), 
                    h= box_outside_z, // -board_z ,
                    r = (board_x - (bolt_inside_x + bolt_diameter))/2 );
            }
            
            // the board will sit on a ledge. Cut out a board on the
            // TOP face of the box that the board will sit IN.
            
            hull(){
                prep_roundbox(
                    x=(board_x/2 +.1 ),
                    y=(board_y/2 + .1),
                    z= -board_z, 
                    h= board_z + .2,
                    r = 1); //dont bother figuring out board radius.
            }
            
            translate([ board_x/2 - 9.55 - 1.5, board_y/2 - wall_thickness*2 , -board_z])
            rotate([ -90, 180, 0])
            make_USBA(location = "BELOW");
            
            translate([ board_x/2 - 23.86, -board_y/2 + wall_thickness*2 , -board_z])
            rotate([ 90, 0, 0])
            make_USBC(location = "BELOW");

        }
        add_screws();
    }  // box is complete
    
    translate([cross_section? 0:99999, 
               cross_section? 0:9999999,
               -box_outside_z])
    #cube ([ box_outside_x/2, box_outside_y/2, box_outside_z + 3]);
}


/*

// create a lid

translate([10 + box_outside_x, 0, 0]) 
difference()
{
    hull()
    {
            // make undrilled lid
            prep_roundbox(
                x=(box_outside_x/2  - post_diameter - wall_thickness/2 - lid_tolerance),
                y=(box_outside_y/2 - post_diameter - wall_thickness/2 - lid_tolerance),
                z= 0, // move up to create bottom
                h= lid_thickness,
                r = post_diameter);
            
            // drill outholes for the screws via difference
            // ADD the holes for the screws.
    }
    
    color("red")
    // drill the holes in the lid
    prep_roundbox( 
    x=(box_outside_x/2  - wall_thickness/2 - post_diameter/2),
    y=(box_outside_y/2 - wall_thickness/2 - post_diameter/2),
    z= 0,
    h= lid_thickness,
    r = bolt_drill_diameter/2 +.5);

}
*/
