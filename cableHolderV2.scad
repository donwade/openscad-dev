use <myTools.scad>
$fn=100;

IN_DIA=5;
WALL=4;

OUT_DIA= IN_DIA + WALL;
/*
difference()
{
    rotate_extrude(angle=180, convexity = 10)
        translate([ OUT_DIA, 0, 0])  // must reside eniter on LHS or RHS
        circle(d = OUT_DIA, $fn = 100);
        
    rotate_extrude(angle=180, convexity = 10)
        translate([ OUT_DIA, 0, 0])  // must reside eniter on LHS or RHS
        circle(d = IN_DIA, $fn = 100);
}
*/

module make_cup(IN=5)
{
    OUT=IN+WALL;
    
    scale([ 1, 1, 2])
    difference()
    {
        rotate_extrude(angle=180, convexity = 10)
        //    color("RED")
            translate([ OUT, 0, 0])  // must reside eniter on LHS or RHS
            square(OUT, true);
          
        rotate_extrude(angle=180, convexity = 10)
            color("GREEN")
            translate([ OUT, +OUT/2, 0])  // must reside eniter on LHS or RHS
            #square(IN, true);//    ;//(size=IN_DIA);
  /*          
        translate( [-OUT*2, 0, 0 ])
            #cube([OUT*2, OUT*2, OUT]);

        translate( [ 0, 0, 0 ])
        #cube([OUT*2, OUT*2, OUT]);
  */
    }
}

module make_snake(SIZE=10)
{
    OUT=SIZE+WALL;
    make_cup(SIZE);
    
    translate([ OUT *2 , 0, 0 ])
    mirror([ 0, 90, 0 ])
    make_cup(SIZE);
}

make_snake(4.68);
translate([ 50, 10, 0 ]) make_snake(3.48);

