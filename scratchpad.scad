
//===============================================================
/*
 //example for()  loops ....multi line vs single liner

 color_vec = ["black","red","blue","green","pink","purple"];
 
 // 3 separate for's
 
 for (x = [-20:10:20] )
 for (y = [0:4] )color(color_vec[y])
 for (z = [0,4,10] )
     {translate([x,y*5-10,z])cube();}
 
// single 'for' with implicit multiple 'for's"
 
 for (x = [-20:10:20], y = [0:4], z = [0,4,10] )
     translate([x,y*5-10,z])
     {color(color_vec[y])cube();}
*/     
//===============================================================
/*     
// iteratate a list using for

// NOTICE : all objects inside the for loop will be UNIONED  
for(i = [ [ 0,  0,  0],
          [10, 12, 10],
          [20, 24, 20],
          [30, 36, 30],
          [20, 48, 40],
          [10, 60, 50] ])
{
   translate(i)
   color("RED")
   cube([50, 15, 10], center = true);
}

// iterate over vectors of vectors
// example 3 - iteration over a vector of vectors
// NOTICE : all objects inside the for loop will be UNIONED  

for(i = [ [[ 0,  0,  0], 20],
          [[10, 12, 10], 50],
          [[20, 24, 20], 70],
          [[30, 36, 30], 10],
          [[20, 48, 40], 30],
          [[10, 60, 50], 40] ])
{
  translate([i[0][0], 2*i[0][1], 0])  // notice [0][1]
  color("GREEN")
  cube([10, 15, i[1]]);
}
*/
//===============================================================     
/*
// intersection_for is the INTERSECTION of all objects created in the "FOR"
// hard to see effect in preview.... use render not preview
color("GREEN")
intersection_for(n = [1 : 4])
{
    rotate([0, 0, n * 90])
    {
        translate([6,0,0])
        sphere(r=12);
    }
}

// simpple FOR with same commands is a UNION
color("RED")
translate([35, 0, 0])
for(n = [1 : 4])
{
    rotate([0, 0, n * 90])
    {
        translate([6,0,0])
        sphere(r=12);
    }
}
*/
//===============================================================     
/*
// ANIMATION
// it is controlled by the variable $t
// uses the 'Animate' toolbar in openscad
// makes one "STEP" at the "FPS" rate... REMEMBER TO SET THEM.
//
// below will rotate a ball like hands on a clock.
rotate([0,0,-$t*360])
{
    color("RED")
    translate([50,0,0])
    sphere(10);
}
*/


// TRANSFORMS ===============================================================
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations

// make a cylinder with a cube nub.
module Obj() {
    difference()
    {
        union()
        {
            cylinder(r=10.0,h=10,center=false);
            //cube(size=[10,10,10],center=false);
        }

        translate([ 0, 0, -.1]) 
        cylinder(r=8,h=10.2,center=false);
        //cube(size=[8,8,8],center=false);
    }
}

// This itterates into the future 6 times and demonstrates 
// how multimatrix is moving the object around the center point


for(time = [0 : 10 : 60])
{
    y_ang=-time;

    mrot_y = [ [ cos(y_ang), 0,  sin(y_ang), 0],
               [         0,  1,           0, 0],
               [-sin(y_ang), 0,  cos(y_ang), 0],
               [         0,  0,           0, 1]
             ];
    mtrans_x = [ [1, 0, 0, 40],
                 [0, 1, 0,  0],
                 [0, 0, 1,  0],
                 [0, 0, 0,  1]
               ];

    echo(mrot_y*mtrans_x);
    
    // This is the object at [0,0,0]
    color("BLUE")
    Obj();
    
    // This is the starting object at the [40,0,0] coordinate
    color("GREEN")
    multmatrix(mtrans_x) Obj();
    
     // TRANSLATION and ROTATION TOGETHER.
     // so its rotation of an object ABOUT A DISTANT POINT
     //This is the one rotating and appears 6 times
    color("RED")
    multmatrix(mrot_y * mtrans_x) Obj();
};

//00000000000000000000000000000000000000000000000000000000
// passing in a object
/*
module peg(action)
{
  if(action=="position")
  {
    for(r=[0:90:359])
      rotate([0,0,r])
        translate([screw_dist/2,screw_dist/2,0])
        {
         for(i=[0:$children-1])
           children(i); // do the shapes that come after us!
        }
  }
  ...
*/
