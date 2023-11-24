$fn=100;
WIDTH = 38.32 - 2.7 * 2;
DEPTH = 20.5 + 5;
HEIGHT = 9.5;

// back wall plate
 translate([ 0, -HEIGHT, +HEIGHT])
 rotate ([-90, 0, 0])
 cube([WIDTH, DEPTH * 1.5, HEIGHT], center = false);


 difference()
 {
    union()
    {
        // bottom
         color("RED")
         cube([WIDTH, DEPTH, HEIGHT], center = false);

         // angled part
         translate([ 0, DEPTH-HEIGHT, +HEIGHT/2])
         rotate ([-45, 0, 0])
         cube([WIDTH, DEPTH, HEIGHT/2], center = false);
    }
    
    //
     translate([ 0, DEPTH-HEIGHT, +HEIGHT * 2/3])
     rotate ([-45, 0, 0])
     translate([0, -4, HEIGHT/3 ])
     color("GREEN")
     cube([WIDTH, DEPTH*2, HEIGHT], center = false);
}