/* [Hidden] */

TWEAK = 1;

module USB_A()
{
     DIA = 7.37 + TWEAK;
     WIDTH = 15.0 + TWEAK;
     DIST = WIDTH - DIA;
     LENGTH = 17.0;
    
     color("YELLOW", .3)
     hull()
     {
         translate([ DIST /2, 0, 0 ])
         cylinder(h = LENGTH, d = DIA, $fn=100);
         
         translate([ -DIST /2, 0, 0 ])
         cylinder(h = LENGTH, d = DIA, $fn=100);
     }
     
     xDIA = 1.92 + TWEAK/2;
     xWIDTH = 7.0 + TWEAK/2;
     xDIST = WIDTH - DIA;
     xLENGTH = 5.68;

     rotate([180, 0, 0])
     #hull()
     {
         translate([ xDIST /2, 0, 0 ])
         cylinder(h = xLENGTH, d = xDIA, $fn=100);
         
         translate([ -xDIST /2, 0, 0 ])
         cylinder(h = xLENGTH, d = xDIA, $fn=100);
     }
}

module USB_C()
{
     DIA = 6.10 + TWEAK;
     WIDTH = 10.9 + TWEAK;
     DIST = WIDTH - DIA;
     LENGTH = 14.0;
    
     color("YELLOW", .3)
     hull()
     {
         translate([ DIST /2, 0, 0 ])
         cylinder(h = LENGTH, d = DIA, $fn=100);
         
         translate([ -DIST /2, 0, 0 ])
         cylinder(h = LENGTH, d = DIA, $fn=100);
     }
     
     xDIA = 2.54 + TWEAK/2;
     xWIDTH = 8.25 + TWEAK/2;
     xDIST = WIDTH - DIA;
     xLENGTH = 7.47;

     rotate([180, 0, 0])
     #hull()
     {
         translate([ xDIST /2, 0, 0 ])
         cylinder(h = xLENGTH, d = xDIA, $fn=100);
         
         translate([ -xDIST /2, 0, 0 ])
         cylinder(h = xLENGTH, d = xDIA, $fn=100);
     }
}

translate([20, 0, 0])
USB_A();



USB_C();
