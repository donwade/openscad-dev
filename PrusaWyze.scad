$fn=100;

wyze_foot = 52 - 1.75;  // it's square
wyze_foot_thick = 6.0;
wyze_boarder = 5.0;

hypotenuse_corner = 36.0;
square_corner = sqrt(hypotenuse_corner * hypotenuse_corner / 2) ;
echo ("square_corner = ", square_corner);

area_length = 4.5;
area_1_depth  = 20.0;

prusa_2_camera = 45.0 + 16;
prusa_plate = 3;
prusa_spacer = 5.53;


hole_across = 16.7;
hole_diameter = 6.0 + 1;

box_length = area_length + wyze_boarder + wyze_foot;

box_depth =  area_length  + square_corner + prusa_2_camera + wyze_foot + wyze_boarder;
box_height =  prusa_plate + prusa_spacer;

difference()
{
    cube( [box_length, box_depth, box_height] );
    union() {
        translate ( [ wyze_boarder, wyze_boarder, wyze_foot_thick ])
        cube ( [wyze_foot, wyze_foot, wyze_foot_thick]);
    
        translate ( [ area_length, box_depth - area_1_depth, box_height - prusa_plate ])
        rotate( [ 0, 0, -45 ])
        cube ( [hypotenuse_corner, hypotenuse_corner, prusa_plate ]);
        
        translate ( [ area_length, box_depth - area_1_depth , box_height - prusa_plate] )
        cube( [box_length, hypotenuse_corner/2 + 10,  prusa_plate] );

        translate ( [ area_length + square_corner, box_depth - square_corner - area_1_depth, box_height - prusa_plate] )
        #cube( [box_length, square_corner,   prusa_plate] );
        
        translate( [ hole_across + area_length, box_depth - area_1_depth , 0 ])
        cylinder(box_height, d = hole_diameter);

    }
}

