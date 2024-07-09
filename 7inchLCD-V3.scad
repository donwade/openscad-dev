use <myTools.scad>

MM=25.43;

bMakeFront = false;//false;//true;
bMakeSides = false; 
 
bMakeBack = true; //true;

TWEAK=.8;

epaper_length = 170.20 + TWEAK; //170.20 on spec
epaper_width = 111.20 + TWEAK ; // 111.2 on spec
epaper_thick = 1.2 + TWEAK;     // 1.2 +/- .1 on spec

LCD_WHITE_BOARDER = 3.5;
LCD_WHITE_HEIGHT = 111.20 - 97.92 - 3.49; 
LCD_WHITE_WIDTH = 163.2;     



outside_height = 10;
BEZEL_THICK = 3;
BOTTOM_WALL_REDUCTION = 2;

flex_cable_wide = epaper_length - 2 * 74 ;
flex_cable_offset = 78.5 - 5;
MYLAR_FEED = [flex_cable_wide, 2, 15 ];


if (bMakeBack)
{
    rotate([0, 0, 0 ])
    translate([ BEZEL_THICK, BEZEL_THICK, 20])
    {
        difference()
        {
            // don't need box to have max emptyness, raise floor via elevator = 3
            color("CYAN")
            abox([epaper_length - TWEAK, 
                  epaper_width - TWEAK, 
                  outside_height * 1.2 ], 
                  thick = -LCD_WHITE_BOARDER, 
                  bHollow = false, 
                  bCentered = false);

            translate([ flex_cable_offset,  
                        BEZEL_THICK/2,
                        LCD_WHITE_BOARDER])
            color("GREEN")
            #cube(MYLAR_FEED , center = false);
            
            translate([ epaper_length/2,  
                epaper_width - 25,
                -LCD_WHITE_BOARDER])
                
                color("GREEN")
                #cylinder(d=20, h=10);

        }
    }
}
//----------------------------------------------------------------------------------------

if (bMakeSides)
{
    //rotate([ 0, 0, 180])
    difference()
    {
        // don't need box to have max emptyness, raise floor via elevator = 3
        abox([epaper_length,
              epaper_width, 
              outside_height], 
              thick = +BEZEL_THICK,
              bHollow = true, 
              bCentered = false);

        translate([ flex_cable_offset,  
                    BEZEL_THICK/2,
                    LCD_WHITE_BOARDER])
        color("RED")
        #cube(MYLAR_FEED , center = false);
        

    }
}
//----------------------------------------------------------------------------------------

if (bMakeFront)
{
    //
    //  MAKE HOLD DOWN FRAME

    translate([ BEZEL_THICK, BEZEL_THICK, 0])
    union()
    {
        // don't need box to have max emptyness, raise floor via elevator = 3
        color("CYAN")
        abox([epaper_length, 
              epaper_width, 
              LCD_WHITE_BOARDER ], 
              thick = -LCD_WHITE_BOARDER, 
              bHollow = true, 
              bCentered = false);


        // hide white frame of display
        // don't need box to have max emptyness, raise floor via elevator = 3
        color("BLUE")
        translate([LCD_WHITE_BOARDER, 
                    0, //LCD_WHITE_BOARDER, 
                    0])
                    
        abox([LCD_WHITE_WIDTH + TWEAK,
              LCD_WHITE_HEIGHT, 
              3.5],
              thick = -3.5, 
              bSolid = true,
              bCentered = false);


    }
}



