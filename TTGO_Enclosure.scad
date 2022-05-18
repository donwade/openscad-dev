use</home/dwade/openscad-dev/TTGO_V3_16.scad>;

bHasLid = 1;
bHasPosts = 0;
bHasBody = 1;
bHasSideCrossSection = 0;
bHasCrossSectionFront = 1;  //1=show usb side 0= show SD card side

bHasTopCrop = 0;

//outside dimensions of the box
box_length  = 77;    //x dimension
box_width = 45;    //y dimension
box_height = 25;    //z dimension
$fn=100;

//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 5;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= wall_thickness;  // comment out if no lid required
lid_lip = 3;            // 0 makes lid flush to top
lid_tolerance = .6;     // shrink lid so not squeaky fit

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

if (bHasBody)
{
    difference()
    {
        difference()
        {
            union()
            {
                difference() { // make 2 boxes one inside the other and remove "inside box" from "outside box"
                    // use posts to define OUTSIDE of a solid box centered on 0,0
                    hull(){
                        posts(  
                            x=(box_length/2  - corner_radius),
                            y=(box_width/2 - corner_radius),
                            z= 0,
                            h= box_height,
                            r = corner_radius);
                    }
                        
                    // use posts to define INSIDE of a solid box centered on 0,0
                    hull(){
                        posts(
                            x=(box_length/2  - corner_radius - wall_thickness),
                            y=(box_width/2 - corner_radius - wall_thickness),
                            z= wall_thickness, // move up to create bottom
                            h= box_height,
                            r = corner_radius);
                    }

                    // now we have a simple hollow box.
                    // use posts to define a LIP inside the wall 
                    hull(){
                        posts(
                            x=(box_length/2  - corner_radius - lid_lip),
                            y=(box_width/2 - corner_radius - lid_lip),
                            z= box_height - lid_thickness,
                            h= lid_thickness + 1,
                            r = corner_radius);
                    }
                }
            }
            
            //makeTTGO(-box_length/2, 0,0, -180, 0, 0);
            #makeTTGO(-box_length + 43, -box_width/3 +3,  0 - 7.0, -180, 0, 0);
        }  // box is fully formed
        
        if (bHasSideCrossSection)
        {
            //cross section
            color("BLACK", alpha=.3)
            translate([0, bHasSideCrossSection ? ((box_width/2) +5 )  : (-box_width/2) - 5, 0])
            cube([box_length+20, box_width, 100], center = true);
            
            //cross section
            color("ORANGE", alpha=.1)
            translate([0, -box_width  * .8, 0])
            cube([box_length+20, box_width, 100], center = true);

        }

        if (bHasTopCrop)
        {
            //cross section
            color("BLUE", alpha=.1)
            translate([0, bHasTopCrop ? box_width/2 : -box_width/2, 0])
            cube([box_length+20, box_width, 100], center = true);
        }
    }
}

if (bHasPosts)
{
    // add screw in posts and drill out the center for screws
    difference () {
        posts( 
            x=(box_length/2  - wall_thickness/2 - post_diameter/2),
            y=(box_width/2 - wall_thickness/2 - post_diameter/2),
            z= box_height/2 + wall_thickness - .5, // post goes half way from the top
            h= box_height * 1/2- wall_thickness - lid_thickness +.5,
            r = post_diameter/2);

         // ADD the holes for the screws.
        posts( 
            x=(box_length/2  - wall_thickness/2 - post_diameter/2),
            y=(box_width/2 - wall_thickness/2 - post_diameter/2),
            z= box_height/2 + wall_thickness - .5,  // hole goes halfway down from the top
            h= box_height/2 - wall_thickness - lid_thickness + 5,
            r = hole_diameter/2);
    }
}

// hold down starts on the xy plane so make it thickness independent.
hold_down_height = 8 + wall_thickness;
hold_down_dia = 10;

slide_view =  10 + box_length;

if (bHasLid)
{
    // create a lid
    translate([slide_view, 0, 0]) 
    {
        difference()
        {
            hull()
            {
                    // make undrilled lid
                    posts(
                        x=(box_length/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                        y=(box_width/2 - corner_radius - wall_thickness/2 - lid_tolerance),
                        z= 0, // move up to create bottom
                        h= lid_thickness,
                        r = corner_radius);
                    
                    // drill outholes for the screws via difference
                    // ADD the holes for the screws.
            }

            if (bHasPosts)
            {
                color("red")
                // drill the holes in the lid
                posts( 
                x=(box_length/2  - wall_thickness/2 - post_diameter/2),
                y=(box_width/2 - wall_thickness/2 - post_diameter/2),
                z= 0,
                h= lid_thickness,
                r = hole_diameter/2 +.5);
            }
            
           
        }
    }

    // add post on lid to hold down card.
    translate([slide_view  , 0, 0])
    #cylinder(h=hold_down_height, d1=hold_down_dia, d2=hold_down_dia/2, center=false);
    //#cylinder(h=hold_down_height, d=hold_down_dia, center = false);   
}


