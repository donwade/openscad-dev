$fn=100;

logitec_width = 62;  
logitec_depth = 28.5;
logitec_thick = 9.30;
logitec_boarder = 5.0;

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

box_width = area_length + logitec_boarder + logitec_width;

box_depth =  area_length  + square_corner + prusa_2_camera + logitec_width + logitec_boarder;
box_height =  prusa_plate + prusa_spacer;

difference()
{
    union()
    {
        cube( [box_width, box_depth, box_height] );
        cube( [box_width, box_depth/2, box_height * 1.3] );
    }
    union() {
        translate ( [ logitec_boarder, logitec_boarder, 3 ])
        #cube ( [logitec_width, logitec_depth, logitec_thick]);
    
        translate ( [ area_length, box_depth - area_1_depth, box_height - prusa_plate ])
        rotate( [ 0, 0, -45 ])
        cube ( [hypotenuse_corner, hypotenuse_corner, prusa_plate ]);
        
        translate ( [ area_length, box_depth - area_1_depth , box_height - prusa_plate] )
        cube( [box_width, hypotenuse_corner/2 + 10,  prusa_plate] );

        translate ( [ area_length + square_corner, box_depth - square_corner - area_1_depth, box_height - prusa_plate] )
        #cube( [box_width, square_corner,   prusa_plate] );
        
        translate( [ hole_across + area_length, box_depth - area_1_depth , 0 ])
        cylinder(box_height, d = hole_diameter);

    }
}

