$fn=100;

hans_hak = 1; // don't make things too tight.

inside_width = 32; //81.61 + hans_hak; //13;
inside_height = 16; //57.24 + hans_hak; //12;
inside_length = 8;
thickness = 10;

x=8;
y=4;
z=1;
cube(x,y,z);

translate([inside_length/2, 0, 0])

difference ()
{
    difference()
    {
        union()
        {
            cube([inside_length , inside_width+ thickness, inside_height + thickness ], center=true);

        }
        // hollow out the innerds
        union()
        {

            #rotate([0,-90,0])
            linear_extrude(height=500, scale=2) square([inside_height, inside_width], center=true);

            // make sure there is a right wall to the box
            translate([-thickness, 0, 0])
            cube([inside_length, inside_width, inside_height], center=true);

        }
    }

    num_across = 3;
    num_down = 3;

    mid_across = num_across /2;
    mid_down = num_down /2;

    step = 5;

    //translate([inside_length/2 ,0, 0])
    for ( across = [0:1:num_across-1])
    {
        for (down = [0:1: num_down-1])
        {
            echo ("across", across, "  down", down);
            //echo ("acrossx", across - mid_across, "  down", down - mid_down);
            echo ("------");
            y = across * step - mid_across + 2;
            z = down * step - mid_down + 2;
            //echo ("y ", y, "  z", z);

            //rotate([0, -90, 0])
            //translate([ y ,  z, -inside_length/2 -1])
            //#cube([y-1, z-1, inside_length/2] , center = true);
        }
    }


}