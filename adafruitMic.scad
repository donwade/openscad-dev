FUDGE=.25;
wall_thickness = 2;     // total thickness of any wall

board_x  = 38.71;   //x dimension                                                     
board_y = 38.86;    //y dimension
board_z = 1.58;     // board thickness

bolt_inside_x = 26.7;
bolt_outside_x = 34.43;

bolt_inside_y = 27.01;
bolt_outside_y = 35.0;

mic_dia = 9.66 + .5;

bolt_diameter_x = (bolt_outside_x - bolt_inside_x)/2; // (0=no screws)
bolt_diameter_y = (bolt_outside_x - bolt_inside_x)/2; // (0=no screws)

bolt_diameter = (bolt_diameter_x + bolt_diameter_y)/2;
echo ("bolt_diameter x = ",bolt_diameter);

bolt_drill_diameter = 2.5;  // appropriate drill for bolt dia

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
lid_lip = 3;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

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
module add_screws( z, h)
{
    // add screw in posts and drill out the center for screws
    color("CYAN")
     difference () {
        quad_cylinders( 
            x= bolt_center_x/2,
            y= bolt_center_y/2,
            z,
            h,
            r = post_diameter  // no div/2 beef up bolt support
        );

         // ADD the holes for the screws.
        quad_cylinders( 
            x= bolt_center_x/2,
            y= bolt_center_y/2,
            z,
            h,
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
            //aka LANDING_MM support perimeter
            LANDING_MM = 2; 
            hull(){
                prep_roundbox(
                    x=(board_x/2 - LANDING_MM ),
                    y=(board_y/2 - LANDING_MM),
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
            
            // wire exit hole
            translate([-board_x/2, 0, -box_outside_z])
            cylinder(h= wall_thickness, d = 12);
        }
        add_screws( z= -(box_outside_z- wall_thickness + board_z),
            h= box_outside_z- wall_thickness);
        
    }  // box is complete
    
    translate([cross_section? 0:99999, 
               cross_section? 0:9999999,
               -box_outside_z])
    #cube ([ box_outside_x/2, box_outside_y/2, box_outside_z + 3]);
}
//=======================================================
module create_lid()
{
    difference()
    {
        union()
        {
               // make 2 boxes one on TOP the other and remove "inside box" from "outside box"
                // use prep_roundbox to define OUTSIDE of a solid box centered on 0,0
                hull(){
                    prep_roundbox(  
                        x=(box_outside_x/2),
                        y=(box_outside_y/2),
                        z= -lid_thickness,//box_outside_z,
                        h= lid_thickness,//box_outside_z,
                        r = wall_thickness/2);
                }

                // the board will sit on a ledge. Cut out a board on the
                // TOP face of the box that the board will sit IN.
                
                hull(){
                    prep_roundbox(
                        x=(board_x/2 +.1 ),
                        y=(board_y/2 + .1),
                        z= 0, //-board_z + 3, 
                        h= board_z -1,
                        r = 1); //dont bother figuring out board radius.
                }
        }
            
        // drill the holes for the screws (no posts)
        #quad_cylinders( 
            x= bolt_center_x/2,
            y= bolt_center_y/2,
            z= -lid_thickness,
            h=lid_thickness * 2,
            r = bolt_drill_diameter/2
        );

        //translate([-mic_dia + board_x, 0, -lid_thickness])
        translate([board_x/2 - mic_dia/2, 0, -lid_thickness])
            #cylinder(h=lid_thickness * 2, r = mic_dia/2 );
        
    }  // box is complete
}
    
// create a lid
// build the box
if ($preview)
{
    translate([-board_x -10, 0, 0])
    create_lid();
}
else
{
    translate([0, 0, -20])
    create_lid();
}  

