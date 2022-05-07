use</home/dwade/openscad-dev/TTGO_V3_16.scad>;

bHasLid = 0;
bHasPosts = 0;
bHasSideCrossSection = 1;
bHasCrossSectionFront = 1;  //1=show usb side 0= show SD card side

bHasTopCrop = 0;

//outside dimensions of the box
width  = 75;    //x dimension
length = 50;    //y dimension
height = 25;    //z dimension
$fn=50;

//additional parameters
corner_radius = 5;      // radius of box corners
wall_thickness = 4;     // total thickness of any wall
post_diameter = 10;     // internal post for screws
hole_diameter = 3;      // size of screws for lid (0=no screws)
lid_thickness= 2;       // comment out if no lid required
lid_lip = 2;            // 0 makes lid flush to top
lid_tolerance = .5;     // shrink lid so not squeaky fit

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
                        x=(width/2  - corner_radius),
                        y=(length/2 - corner_radius),
                        z= 0,
                        h= height,
                        r = corner_radius);
                }
                    
                // use posts to define INSIDE of a solid box centered on 0,0
                hull(){
                    posts(
                        x=(width/2  - corner_radius - wall_thickness),
                        y=(length/2 - corner_radius - wall_thickness),
                        z= wall_thickness, // move up to create bottom
                        h= height,
                        r = corner_radius);
                }

                // now we have a simple hollow box.
                // use posts to define a LIP inside the wall 
                hull(){
                    posts(
                        x=(width/2  - corner_radius - lid_lip),
                        y=(length/2 - corner_radius - lid_lip),
                        z= height - lid_thickness,
                        h= lid_thickness + 1,
                        r = corner_radius);
                }
            }
        }
        
        //makeTTGO(-width/2, 0,0, -180, 0, 0);
        #makeTTGO(-width + 43, -length/3 +3,  0 - 7.8, -180, 0, 0);
    }  // box is fully formed
    
    if (bHasSideCrossSection)
    {
        //cross section
        color("BLACK", alpha=.3)
        translate([0, bHasSideCrossSection ? ((length/2) +5 )  : (-length/2) - 5, 0])
        cube([width+20, length, 100], center = true);
        
        //cross section
        color("ORANGE", alpha=.1)
        translate([0, -length  * .8, 0])
        cube([width+20, length, 100], center = true);

    }

    if (bHasTopCrop)
    {
        //cross section
        color("BLUE", alpha=.1)
        translate([0, bHasTopCrop ? length/2 : -length/2, 0])
        cube([width+20, length, 100], center = true);
    }
}

if (bHasPosts)
{
    // add screw in posts and drill out the center for screws
    difference () {
        posts( 
            x=(width/2  - wall_thickness/2 - post_diameter/2),
            y=(length/2 - wall_thickness/2 - post_diameter/2),
            z= height/2 + wall_thickness - .5, // post goes half way from the top
            h= height * 1/2- wall_thickness - lid_thickness +.5,
            r = post_diameter/2);

         // ADD the holes for the screws.
        posts( 
            x=(width/2  - wall_thickness/2 - post_diameter/2),
            y=(length/2 - wall_thickness/2 - post_diameter/2),
            z= height/2 + wall_thickness - .5,  // hole goes halfway down from the top
            h= height/2 - wall_thickness - lid_thickness + 5,
            r = hole_diameter/2);
    }
}

hold_down_height = 14;
hold_down_dia = 10;

if (bHasLid)
{
    // create a lid
    translate([10 + width, 0, 0]) 
    {
        difference()
        {
            hull()
            {
                    // make undrilled lid
                    posts(
                        x=(width/2  - corner_radius - wall_thickness/2 - lid_tolerance),
                        y=(length/2 - corner_radius - wall_thickness/2 - lid_tolerance),
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
                x=(width/2  - wall_thickness/2 - post_diameter/2),
                y=(length/2 - wall_thickness/2 - post_diameter/2),
                z= 0,
                h= lid_thickness,
                r = hole_diameter/2 +.5);
            }
            
           
        }
        // add post on lid to hold down card.
        translate([10 , 0, lid_thickness])
        #cylinder(h=hold_down_height, d=hold_down_dia, center = false);  
    }
}


