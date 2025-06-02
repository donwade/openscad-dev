use <myTools.scad>
$fn=100;

THICK=3;
DIA=20;
HEIGHT= 30;

// = 0 ready for printer
DEMO=0;

UP= DEMO ? 0 : 5;


module top()
{
    difference()
    {
        union()
        {
            cylinder (d=DIA, h = HEIGHT);
            translate([-DIA/2, 0, 0])
            cube([DIA, DIA * 3/4, HEIGHT]);
        }
        
        translate([ 0, 0, UP -.1 ])
        cylinder (d=DIA-THICK*2, h= HEIGHT+.2);

        translate([ -DIA/8, -DIA, UP -.1 ])
        cube([DIA/4, DIA, HEIGHT+.1]);
        
    }
}   

module bottom()
{
    //difference()
    {
        //union()
        //{
        //    cylinder (d=DIA, h = HEIGHT);
        //    translate([-DIA/2, 0, 0])
        //    cube([DIA, DIA, HEIGHT]);
        // }
        
        translate([ 0, 0, UP ])
        cylinder (d=DIA-THICK*2 - .5, h= HEIGHT -UP );

        translate([ -DIA/8 + .5, -DIA, UP  ])
        cube([DIA/4-1, DIA, HEIGHT -UP ]);

        translate([-DIA/2, -DIA - .2, UP ])
        cube([DIA, DIA * 2/4, HEIGHT -UP]);
        
    }
}   


top();

//place bottom back on floor
translate([ DEMO ? 0 : 25, 0, DEMO ? 0 : -UP ]) 
bottom();
