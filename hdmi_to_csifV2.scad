use <usbA-C.scad>

FUDGE=.25;
wall_thickness = 3;     // total thickness of any wall


BOARD = [30.15, 45.09 + 2.50, 1.61];
BOTTOM_OF_BOARD = [ 0, 0, BOARD.z * 6];   
TOP_OF_BOARD = [ 0, 0, BOARD.z * 5];   

// WAVESHARE RIBBON ------------------------
X1 = (4.65 - 4.86)/2;
RIBBON = [ 21, 10, 1.5];         // physical connector
RIBBON_TWEAK = [ X1, 0, .46];     // it sits ON the board

// HDMI ------------------------
X2 = 0;//-2.3;
HDMI = [ 15.20, 11, 5.6];  // true dimensions
HDMI_TWEAK = [ X2, 0, +.8]; // above the board the connector starts 

cross_section = false;

LEDGE_SIZE = 1.5;
ledge = [ 0, 0, BOARD.z-.1]; //location where the board sits.
//-------------------------------------------------------------
//-------------------------------------------------------------

/* [Hidden] */

//outside dimensions of the box
box_outside_x = BOARD.x+ wall_thickness * 2;    //x dimension
box_outside_y = BOARD.y + wall_thickness * 2;   //y dimension
box_outside_z = 18;

$fn=50;

//additional parameters
lid_thickness= 2;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

fn=50;

//------------------------------------------------------------------
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
//---------------------------------------------------------------

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

            // solid box, classical outside dimenesion.
            hull(){
                prep_roundbox(  
                    x=(box_outside_x/2),
                    y=(box_outside_y/2),
                    z= -box_outside_z,
                    h= box_outside_z,
                    r = wall_thickness/2);
            }

            // hollow out solid box from above. 
            // BUT it will NOT be the dimensions of the board.
            // We need to make a ledge LATER, so this punch out will
            // be a bit smaller than the board so the board can
            // sit on something.
            
            // Go all the way down to BOTTOM less wall thickness like
            // a classic box hollow out job.
            
            
            hull(){
                prep_roundbox(
                    x=(BOARD.x/2 - LEDGE_SIZE ),
                    y=(BOARD.y/2 - LEDGE_SIZE ),
                    z= -(box_outside_z- wall_thickness), 
                    h= box_outside_z, // -BOARD.z ,
                    r = 2);
            }

            
            // the board will sit on a ledge. Cut out a board on the
            // TOP face of the box that the board will sit IN.
            
            hull(){
                prep_roundbox(
                    x=(BOARD.x/2 +.2 ),
                    y=(BOARD.y/2 + .2),
                    z= -BOTTOM_OF_BOARD.z, 
                    h=  BOTTOM_OF_BOARD.z + .01,
                    r = 1); //dont bother figuring out board radius.
            }

        }
    }  // box is complete

    translate([0, 0, -box_outside_z])
    cylinder(h = box_outside_z, d = 10);

    
    // WAVESHARE RIBBON ------------------------
    
    translate([0 , 
              -box_outside_y/2 + wall_thickness, 
              +RIBBON.z/2 ] + RIBBON_TWEAK - TOP_OF_BOARD)
    //rotate([0, 0, 90])
    #cube ([RIBBON.x, RIBBON.y, RIBBON.z], true);
    // -----------------------------------------

    // HDMI ------------------------
    translate([ 0, 
              box_outside_y/2  - HDMI.y/2 + wall_thickness, 
              +HDMI.z/2 ] + HDMI_TWEAK - TOP_OF_BOARD)
    //rotate([0, 0, 90])
    #cube ([HDMI.x,HDMI.y, HDMI.z], true);
    // -----------------------------------------
    
    if ($preview)
    {
        color("BLUE", .2)
        translate(-BOTTOM_OF_BOARD + [ 0, 0, -BOARD.z]/2)
            cube(BOARD, true);
    }
    
    INFINITY = 999999;
    // make a cross section.
    translate([cross_section? 0 : INFINITY, 
               cross_section? -box_outside_y/2 :  INFINITY,
               -box_outside_z - 5])
    cube ([ box_outside_x+1, box_outside_y+1, box_outside_z * 2]);
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
