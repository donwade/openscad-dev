$fn=100;

function shave(x)= x - 0;

tongue_length = 38;
tongue_width = 11;  //9.13

max_length = tongue_length + 20;
max_height = 50.0; // 30, 20
max_width = 34.56;


raise1 = 30;
raise2 = 46;

difference ()
{
    cube([shave(max_length), shave(max_width), shave(max_height) ]);

    translate([ 0, max_width - tongue_width, raise2])
    cube([max_length, tongue_width, max_height ]);
    
    translate([ 0, 0, 0])
    cube([max_length, tongue_width, max_height - raise1 ]);
    
}

ear_length = (max_length - tongue_length)/2;
cube([ear_length, max_width, max_height]);

translate([max_length - ear_length, 0, 0])
cube([ear_length, max_width, max_height]);
