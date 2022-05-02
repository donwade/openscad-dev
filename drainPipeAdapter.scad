$fn=100;

hans_hak = 1; // don't make things too tight.

inside_width = 81.61 + hans_hak; //13;
inside_height = 57.24 + hans_hak; //12;
inside_length = 80;
thickness = 10;

rotate_degrees = 45;

//3'=76mm
tube_inner_diameter = 76 + hans_hak;
tube_outer_diameter = tube_inner_diameter + thickness;
tube_length = 12;  //amount tube will stick up from rectangular body

translate([inside_length/2, 0, 0])

difference ()
{
    difference()
    {
        union()
        {
            translate([inside_length/2, 0, (tube_outer_diameter - inside_height )/2]) 
                sphere(d = tube_outer_diameter );
            
            cube([inside_length , inside_width+ thickness, inside_height + thickness ], center=true);

            translate([inside_length/2, 0, 0])
            rotate([0, rotate_degrees, 0])
            cylinder(h=(tube_outer_diameter/2 + tube_length), d=tube_outer_diameter, center = false);
        }
        // hollow out the innerds
        union()
        {

            translate([inside_length/2, 0, 0])
            rotate([0, rotate_degrees, 0])
            cylinder(h=(tube_outer_diameter/2 + tube_length +1 ), d=tube_inner_diameter, center = false);

            translate([inside_length/2, 0, (tube_inner_diameter - inside_height + thickness )/2]) 
                sphere(d = tube_inner_diameter );

        }
    }
  
    // make sure there is a right wall to the box
    translate([-thickness, 0, 0]) 
        #cube([inside_length, inside_width, inside_height], center=true);
            
    // shear the bottom, ensure box sits flat on platter
    translate([0, 0, -inside_height/2 - thickness])
    #cube([inside_length *2 , inside_width+ thickness, thickness ], center=true);

}