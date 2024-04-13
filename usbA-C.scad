/* [Hidden] */

TWEAK = 1;

module make_USBA()
{
     DIA = 6 + TWEAK;
     WIDTH = 11.0 + TWEAK;
     DIST = WIDTH - DIA;
     LENGTH = 17.0;

     xDIA = 1.92 + TWEAK/2;
     xWIDTH = 7.0 + TWEAK/2;
     xDIST = WIDTH - DIA;
     xLENGTH = 5.68;

    translate([ 0, -xDIA, 0])  // "0" is where part sits ON a board
    {
         if ($preview)
         {
             color("PINK")
             translate( [-WIDTH , xDIA, 0])  // one face to sit 'on the board'
             rotate([90, 90, 0])
             cube( [WIDTH * 2, WIDTH * 2, 0.1], center = false);    // targeting plane
         }
         
         translate( [0, xDIA/2, 0])  // one face to sit 'on the board'
         {
             

             color("YELLOW", .3)
             hull()
             {
                 translate([ DIST /2, 0, 0 ])
                 cylinder(h = LENGTH, d = DIA, $fn=100);
                 
                 translate([ -DIST /2, 0, 0 ])
                 cylinder(h = LENGTH, d = DIA, $fn=100);
             }
             
             rotate([180, 0, 0])
             #hull()
             {
                 translate([ xDIST /2, 0, 0 ])
                 cylinder(h = xLENGTH, d = xDIA, $fn=100);
                 
                 translate([ -xDIST /2, 0, 0 ])
                 cylinder(h = xLENGTH, d = xDIA, $fn=100);
             }
         }
     }
}

module make_USBC()
{
     DIA = 6.10 + TWEAK;
     WIDTH = 10.9 + TWEAK;
     DIST = WIDTH - DIA;
     LENGTH = 14.0;

     xDIA = 2.54 + TWEAK/2;
     xWIDTH = 8.25 + TWEAK/2;
     xDIST = WIDTH - DIA;
     xLENGTH = 7.47;

     translate([ 0, -xDIA, 0])  // "0" is where part sits ON a board
     {
         if ($preview)
         {
             color("CYAN")
             translate( [-WIDTH , xDIA, 0])  // one face to sit 'on the board'
             rotate([90, 90, 0])
             cube( [WIDTH * 2, WIDTH * 2, 0.1], center = false);    // targeting plane
         }
         

         translate( [0, xDIA/2, 0])  // one face to sit 'on the board'
         {
             color("YELLOW", .3)
             hull()
             {
                 translate([ DIST /2, 0, 0 ])
                 cylinder(h = LENGTH, d = DIA, $fn=100);
                 
                 translate([ -DIST /2, 0, 0 ])
                 cylinder(h = LENGTH, d = DIA, $fn=100);
             }
             
             rotate([180, 0, 0])
             #hull()
             {
                 translate([ xDIST /2, 0, 0 ])
                 cylinder(h = xLENGTH, d = xDIA, $fn=100);
                 
                 translate([ -xDIST /2, 0, 0 ])
                 cylinder(h = xLENGTH, d = xDIA, $fn=100);
             }
        }
    }
}
translate([20, 0, 0])
make_USBA();
make_USBC();
