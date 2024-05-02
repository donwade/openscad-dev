/* [Hidden] */

TWEAK = 1;

module make_USBA(location = "UNKNOWN")
{
     // true measurements of usb.
     PUNCH_DIA = 6 + TWEAK;
     PUNCH_WIDTH = 11.0 + TWEAK;
     PUNCH_DIST = PUNCH_WIDTH - PUNCH_DIA;
     PUNCH_LENGTH = 17.0;

     // this is the hole punch size
     USB_DIA = 1.92 + TWEAK/2;
     USB_WIDTH = 7.0 + TWEAK/2;
     USB_DIST = PUNCH_WIDTH - PUNCH_DIA;
     USB_LENGTH = 5.68;
    

    mUSB_DIA = (location == "ABOVE") ? +USB_DIA/2 : location == "BELOW" ? -USB_DIA/2: 0;
    
    translate([ 0, mUSB_DIA, 0])  
    {
         if ($preview)
         {
             color("PINK")
             translate( [-PUNCH_WIDTH , -mUSB_DIA, 0])  // one face to sit 'on the board'
             rotate([90, 90, 0])
             cube( [PUNCH_WIDTH * 2, PUNCH_WIDTH * 2, 0.1], center = false);    // targeting plane
         }
         
         //translate( [0, USB_DIA/2, 0])  // one face to sit 'on the board'
         {
             color("YELLOW", .3)
             hull()
             {
                 translate([ PUNCH_DIST /2, 0, 0 ])
                 cylinder(h = PUNCH_LENGTH, d = PUNCH_DIA, $fn=100);
                 
                 translate([ -PUNCH_DIST /2, 0, 0 ])
                 cylinder(h = PUNCH_LENGTH, d = PUNCH_DIA, $fn=100);
             }
             
             rotate([180, 0, 0])
             #hull()
             {
                 translate([ USB_DIST /2, 0, 0 ])
                 cylinder(h = USB_LENGTH, d = USB_DIA, $fn=100);
                 
                 translate([ -USB_DIST /2, 0, 0 ])
                 cylinder(h = USB_LENGTH, d = USB_DIA, $fn=100);
             }
         }
     }
}

module make_USBC( location = "UNKNOWN")
{
     PUNCH_DIA = 6.10 + TWEAK;
     PUNCH_WIDTH = 10.9 + TWEAK;
     PUNCH_DIST = PUNCH_WIDTH - PUNCH_DIA;
     PUNCH_LENGTH = 14.0;

    // true usb metal dimensions.
     USB_DIA = 2.54 + TWEAK/2;
     USB_WIDTH = 8.25 + TWEAK/2;
     USB_DIST = PUNCH_WIDTH - PUNCH_DIA;
     USB_LENGTH = 7.47;

    mUSB_DIA = (location == "ABOVE") ? +USB_DIA/2 : location == "BELOW" ? -USB_DIA/2: 0;
    
    translate([ 0, mUSB_DIA, 0])  
    {
         if ($preview)
         {
             color("GREY")
             translate( [-PUNCH_WIDTH , -mUSB_DIA, 0])  // one face to sit 'on the board'
             rotate([90, 90, 0])
             cube( [PUNCH_WIDTH * 2, PUNCH_WIDTH * 2, 0.1], center = false);    // targeting plane
         }
         
         //translate( [0, USB_DIA/2, 0])  // one face to sit 'on the board'
         {
             color("ORANGE", .3)
             hull()
             {
                 translate([ PUNCH_DIST /2, 0, 0 ])
                 cylinder(h = PUNCH_LENGTH, d = PUNCH_DIA, $fn=100);
                 
                 translate([ -PUNCH_DIST /2, 0, 0 ])
                 cylinder(h = PUNCH_LENGTH, d = PUNCH_DIA, $fn=100);
             }
             
             rotate([180, 0, 0])
             #hull()
             {
                 translate([ USB_DIST /2, 0, 0 ])
                 cylinder(h = USB_LENGTH, d = USB_DIA, $fn=100);
                 
                 translate([ -USB_DIST /2, 0, 0 ])
                 cylinder(h = USB_LENGTH, d = USB_DIA, $fn=100);
             }
         }
     }

}
translate([20, 0, 0])
make_USBA("ABOVE");
translate([40,0, 0])
make_USBA("CENTER");
translate([60, 0, 0])
make_USBA("BELOW");
/*
translate([ 0, 10, 0])
{
    translate([20, 0, 0])
    make_USBC("ABOVE");
    translate([40,0, 0])
    make_USBC("CENTER");
    translate([60, 0, 0])
    make_USBC("BELOW");
}
*/
//make_USBC("CENTER");
