use <usbA-C.scad>

FUDGE=.25;
wall_thickness = 2;     // total thickness of any wall

/*
    BOARD="CHARGER";
    charger_board = [99.33, 29.33, 1.58];
    charger_bolt_inside = [ 91.93, 22.01 ];
    charger_bolt_outside= [ 97.63, 27.75 ];
    board = charger_board;
    bolt_inside = charger_bolt_inside;
    bolt_outside= charger_bolt_outside;
    bolt_drill_diameter = 2.5 ; //for M3 appropriate drill for bolt dia

    underside_tallest_component = 6;
    
    mini_trans=[ board.x/2 - 9.55 , board.y/2 - wall_thickness*2 , -board.z];
    mini_rotor=[ -90, 180, 0];

    c_trans = [ board.x/2 - 23.86, -board.y/2 + wall_thickness*2 , -board.z];
    c_rotor = [ 90, 0, 0]);

*/

/*
    BOARD="TTGO";
    ttgo_board = [100, 32.80, 1.58];
    ttgo_bolt_inside = [ 93.40, 26.09 ];
    ttgo_bolt_outside= [ 97.10, 29.66 ];
    board = ttgo_board;
    bolt_inside = ttgo_bolt_inside;
    bolt_outside= ttgo_bolt_outside;
    underside_tallest_component = 21;
    bolt_drill_diameter = 1.6; //M2 appropriate drill for bolt dia
    go_usb = false;
*/

/*
    BOARD="DRIVER";  // waveshare driver board
    driver_board = [48.76, 29.44, 1.61 * 2];
    driver_bolt_inside = [ 0, 0 ];
    driver_bolt_outside= [ 0, 0 ];
    board = driver_board;
    bolt_inside = driver_bolt_inside;
    bolt_outside= driver_bolt_outside;
    underside_tallest_component = 2.50;
    bolt_drill_diameter = 0; //M2 appropriate drill for bolt dia
    go_usb = false;

    mini_trans=[ board.x/2, 0, -board.z];
    mini_rotor=[ -90, 0, -90];

    c_trans = [ 0,0,0];
    c_rotor = [ 90, 0, 0];
    WAVESHARE_RIBBON = [ 16, 10, 2];

*/

    BOARD="BREAKOUT_BOARD";
    charger_board = [87.10, 75.26, 1.67];
    charger_bolt_inside = [ 78.23, 66.10 ];
    charger_bolt_outside= [ 83.73, 71.74 ];
    board = charger_board;
    bolt_inside = charger_bolt_inside;
    bolt_outside= charger_bolt_outside;
    bolt_drill_diameter = 2.5 ; //for M3 appropriate drill for bolt dia
    underside_tallest_component = 3;
    go_usb = false;
    mini_trans=[ 0,0,0];
    mini_rotor=[ -90, 0, -90];

    c_trans = [ 0,0,0];
    c_rotor = [ 90, 0, 0];
    WAVESHARE_RIBBON = [ 0,0,0];

cross_section = false;

//-------------------------------------------------------------
//-------------------------------------------------------------

/* [Hidden] */

bolt_diameter_x = (bolt_outside.x - bolt_inside.x)/2; 
bolt_diameter_y = (bolt_outside.y - bolt_inside.y)/2;

//above 2 should be identical, but average them out 
bolt_diameter = (bolt_diameter_x + bolt_diameter_y)/2;

echo ("bolt diameter x = ",bolt_diameter);
echo ("bolt drill diameter x = ",bolt_drill_diameter);

post_diameter = bolt_diameter * 1.25;  // internal post for screws



bolt_center_x  = (bolt_inside.x + bolt_outside.x)/2;   //x dimension                                                     
bolt_center_y  = (bolt_inside.y + bolt_outside.y)/2;   //y dimension

//outside dimensions of the box
box_outside_x = board.x+ wall_thickness * 2  + FUDGE;   //x dimension
box_outside_y = board.y + wall_thickness * 2  + FUDGE;    //y dimension
box_outside_z = max(wall_thickness * 2, underside_tallest_component + wall_thickness + board.z + 1);   //z dimension

$fn=50;

//additional parameters
lid_thickness= 2;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

fn=50;

//-------------------------------------------------------------------------

module miniUSB(trans, rotor)
{
    if (trans != [ 0,0,0])
    {
        translate(trans)
        rotate(rotor)
        make_USBA(location = "BELOW");
    }
}

//-------------------------------------------------------------------------

module USB_C(trans, rotor){    
    if (trans != [ 0,0,0])
    {
        translate(trans)
        rotate(rotor)
        make_USBC(location = "BELOW");
    }
}

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
    if(bolt_center_x) // no bolt spec, no posts then.
    {
        // add screw in posts and drill out the center for screws
        color("CYAN")
         difference () {
            quad_cylinders( 
                x= bolt_center_x/2,
                y= bolt_center_y/2,
                z= -(box_outside_z- wall_thickness + board.z),
                h= box_outside_z- wall_thickness,
                r = post_diameter  // no div/2 beef up bolt support
            );
        
             // ADD the holes for the screws.
            quad_cylinders( 
                x= bolt_center_x/2,
                y= bolt_center_y/2,
                z= -(box_outside_z- wall_thickness + board.z),
                h= box_outside_z- wall_thickness,
                r = bolt_drill_diameter/2
            );
        }
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

            r2 = bolt_diameter ? (board.x- (bolt_inside.x + bolt_diameter))/2  : 1;
            
            #hull(){
                prep_roundbox(
                    x=(board.x/2 - 1 ),
                    y=(board.y/2 - 1),
                    z= -(box_outside_z- wall_thickness), 
                    h= box_outside_z, // -board.z ,
                    r = r2 );
            }
            
            // the board will sit on a ledge. Cut out a board on the
            // TOP face of the box that the board will sit IN.
            
            hull(){
                prep_roundbox(
                    x=(board.x/2 +.1 ),
                    y=(board.y/2 + .1),
                    z= -board.z, 
                    h= board.z + .2,
                    r = 1); //dont bother figuring out board radius.
            }

        
            miniUSB( trans= mini_trans,
                     rotor= mini_rotor);

            USB_C( trans= c_trans,
                   rotor= c_rotor);
        }
        add_screws();
    }  // box is complete
    
    translate([0, 0, -box_outside_z])
    #cylinder(h = box_outside_z, d = 10);

    translate([0, -box_outside_y/2 + wall_thickness, -box_outside_z+wall_thickness*2])
    rotate([180, 0, 0])
    #cube ([5,wall_thickness+12, 3], true);

    // WAVESHARE_RIBBON ------------------------
    if (WAVESHARE_RIBBON.x != 0)
    {
        translate([box_outside_x/2 - WAVESHARE_RIBBON.x/2 - 5.3 , -box_outside_y/2 +wall_thickness, -box_outside_z/2+wall_thickness*2])
        rotate([0, 0, 90])
        #cube ([5,wall_thickness+12, 3], true);
    }
    // -----------------------------------------

    
    // make a cross section.
    translate([cross_section? 0:99999, 
               cross_section? 0:9999999,
               -box_outside_z])
    cube ([ box_outside_x/2, box_outside_y/2, box_outside_z + 3]);
}


/*    miniUSB( trans=[ board.x/2 - 9.55 , board.y/2 - wall_thickness*2 , -board.z],
             rotor [ -90, 180, 0]);
    
    USB-C( trans=[ board.x/2 - 23.86, -board.y/2 + wall_thickness*2 , -board.z],
            rotor= [ 90, 0, 0])
             


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
