$fn=50;
root_diameter = 35.5;

nub_thickness = .9;
nub_width = 3.4;
nub_height = 11;

crest_diameter = root_diameter + nub_thickness;
crest_radius = crest_diameter/2;

wall_thickness = 14.7;

arm_length = 50;
screw_diameter = 4;

can_radius = crest_radius + wall_thickness;
difference()
{
    cylinder(h=nub_height, r=can_radius, center = true);
    union()
    {
        #cylinder(h=nub_height, r=crest_radius, center = true);
    }
}

// horizontal arm
translate([can_radius -5, -can_radius/2, -nub_height/2])
#cube([arm_length, can_radius, nub_height], center = false);

difference()
{
    // vertical arm
    translate([can_radius + arm_length, -can_radius/2, -nub_height/2])
    rotate([0, -90, 0])
    #cube([arm_length, can_radius, nub_height], center = false);

    union() {
        // vertical hole
        translate([can_radius + arm_length, -can_radius/3, arm_length/2])
        rotate([0, -90, 0])
        #cylinder(h=nub_height, d=screw_diameter);

        // vertical hole
        translate([can_radius + arm_length, +can_radius * 1/3, arm_length/2])
        rotate([0, -90, 0])
        #cylinder(h=nub_height, d=screw_diameter);
        
            // vertical hole
        translate([can_radius + arm_length, 0 , arm_length * 3 /4])
        rotate([0, -90, 0])
        #cylinder(h=nub_height, d=screw_diameter);
    }
}

// fillet start of horizontal arm, end at vertical arm
translate([can_radius -5 - 7.5, -nub_height/2 , -nub_height/2])
#cube([arm_length + 7.5, nub_height, can_radius ], center = false);

