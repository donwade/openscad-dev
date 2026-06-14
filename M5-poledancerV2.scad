//use <otherPeoplesWork/threads-scad/threads.scad>
use <myTools.scad>
punch = $preview ? 2: 0;

// M5 core 2 dimensions
x = 54.36;
y = x;
z = 16.63;

wall = +2;

speaker = [ 28, 10, 5];
speaker_origin = [ 20, 0, 4.52 + 5]; // measured on outside

power = [ 36.33 + 1, 7, 10];
power_origin = [ 9 , y , 2.56 + wall];

sd = [ 33.3 , 7, 10 ];
sd_origin = [ wall*2, 10, 4.5 + 1];

/* [Hidden] */
$fn=60;   //circle quantize 360/10=36 degrees per side
wall_thick = 2;
bumps = 1;
nubs =7;
nub_dia = 1;

M5_outside = [ x, y, z] + [bumps/2,bumps/2,bumps/2];
M5_middle = [ M5_outside.x/2, M5_outside.y/2, M5_outside.z/2];


module make_bumps(runlen = 10)
{
   run = runlen/2;
   step = run/nubs;
  
   translate([ run  + wall_thick, 0, 0 ])
   for (i = [ 0: 1 : nubs -1 ])
   {
       echo ("i=", i);
       translate( [i*step, wall_thick, 0 ])
       cylinder(h = z, d =nub_dia);

       translate( [-i*step, wall_thick, 0 ])
       cylinder(h = z, d =nub_dia);
   }

   translate([ run , M5_outside.y, 0 ])
   for (i = [ 0: 1 : nubs -1 ])
   {
       echo ("i=", i);
       translate( [i*step, wall_thick, 0 ])
       #cylinder(h = z, d =nub_dia);

       translate( [-i*step, wall_thick, 0 ])
       #cylinder(h = z, d =nub_dia);
   }
  
  
   for (i = [ 0: 1 : nubs -1 ])
   {
       echo ("i2=", i);
       translate( [ wall_thick, i * step + run, 0 ])
       cylinder(h = z, d =nub_dia);

       translate( [wall_thick, -i*step + run,  0 ])
       cylinder(h = z, d =nub_dia);
   }

   translate([ M5_outside.x, 0, 0 ])
   for (i = [ 0: 1 : nubs -1 ])
   {
       echo ("i2=", i);
       translate( [ wall_thick, i * step + run, 0 ])
       cylinder(h = z, d =nub_dia);

       translate( [wall_thick, -i*step + run,  0 ])
       cylinder(h = z, d =nub_dia);
   }
}

module hi_level()
{
    union()
    {
        abox(M5_outside, +wall_thick, round_out=3, false);
        make_bumps(runlen=M5_outside.x);
        
    }
}
 
 difference()
 {
    hi_level();
    translate([M5_outside.x/2 + wall_thick, M5_outside.y/2 + wall_thick, 0])
    cylinder(d=20, h= 10);

    translate(speaker_origin)
    #cube(speaker);

    translate(power_origin)
    cube(power);
     
    translate(sd_origin)
    rotate([0,0, 90])
    cube(sd); 
 }