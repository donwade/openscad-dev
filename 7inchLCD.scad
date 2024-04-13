use <myTools.scad>
use <usbA-C.scad>

MM=25.43;


bMakeFrame = false; //true;
bMakeBottom = false; //true;
bMakeBackSide = true; //true;

inside_length = 6 * MM + 17.49 + 1.25;
inside_width = 111.23 + .5 ;
outside_height = 5;
BEZEL_THICK = 3.5;


flex_cable_wide = inside_length - 2 * 74 ;
flex_cable_offset = inside_length - 74;
MYLAR_FEED = [flex_cable_wide, 2, 9 ];


if (bMakeBottom)
{
    difference()
    {
        // don't need box to have max emptyness, raise floor via elevator = 3
        abox([inside_length, inside_width, outside_height], thick = +BEZEL_THICK, elevator = 2);

        translate([ -MYLAR_FEED.x/2,  
                    inside_width/2 - BEZEL_THICK + MYLAR_FEED.y/2 + 2 ,
                    -MYLAR_FEED.z * 3/4 + .5 ])
        color("RED")
        cube(MYLAR_FEED , center = false);
        

    }
}
//----------------------------------------------------------------------------------------

if (bMakeFrame)
{
    //
    //  MAKE HOLD DOWN FRAME

    LCD_WHITE_BOARDER = 1.6 + .5;
    NOTCH = .86;

    translate([ 0,0,50])
    union()
    {
        // don't need box to have max emptyness, raise floor via elevator = 3
        color("CYAN")
        abox([inside_length, inside_width, outside_height], thick = +BEZEL_THICK, bHollow = true, bCentered = true);

        // make small ridge .7mm high on the inside of the frame above
        translate([0, 0 , .7/2])
        color("PURPLE")
        abox([inside_length, inside_width, outside_height * 2 - .7 ],
                thick = -(LCD_WHITE_BOARDER),
                bHollow = true, bCentered=true);

        // hide white frame of display
        // don't need box to have max emptyness, raise floor via elevator = 3
        color("BLUE")
        translate([0, -inside_width/2 + BEZEL_THICK , 0])
        abox([inside_length, LCD_WHITE_BOARDER, outside_height], thick = +BEZEL_THICK, bSolid = true, bCentered = true);


    }
}


box_height = 40;

if (bMakeBackSide)
{

    translate([ 0,0, 120])
    {
        difference()
        {
            color("GREEN", .5)
            rotate([-180, 0, 0])
            {
                abox([inside_length + BEZEL_THICK *2 + .7, 
                      inside_width + BEZEL_THICK *2 + .7, 
                      box_height], 
                      thick = +BEZEL_THICK, 
                      bHollow = false, bCentered = true, round_out=3);
            }
            
            translate([0,0, -box_height/2 +2])
            #cylinder(h = box_height, d= 25.4 * 5 /8);
            
            // position usb from the center line, not from a wall.
            translate([ (inside_length + BEZEL_THICK *3)/2 -2, 
                        (inside_width + BEZEL_THICK *3)/2 - 51, 
                         box_height/2 - 33.8/4])
            rotate([ 90, 0, 90])
            #make_USBA();
        }
    }
}

