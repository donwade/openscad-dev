$fn=100;
MM = 25.42;
FUDGE = 1;

inkbird_width = 112 + 97 + FUDGE;
inkbird_depth = (3 + 3/8) * MM + FUDGE;
inkbird_heigth = 35; // (1 + 3/8) * MM + FUDGE;

thick = 10;

module make_box()
{
    translate([0, -inkbird_depth/3, 0])
    color("GREEN")
    cube([inkbird_width + thick *2 , inkbird_depth/2 , thick+.1], center = false);

    difference()
    {
        cube([inkbird_width + thick *2, (inkbird_depth + thick)/2, inkbird_heigth + thick], center = false);
        translate([thick, thick, thick +.01])
        cube([inkbird_width , inkbird_depth, inkbird_heigth], center = false);
    }

    translate([0, (inkbird_depth + thick)/2, 0])
    color("BLUE")
    cube([inkbird_width + thick *2 , thick/2 , thick + 9], center = false);

    // front display is not flat but 2 steps. Add shim to pin it against wall.
    SHIM_LEN = 120;
    SHIM_THICK = 3;
    color("MAGENTA")
    translate([inkbird_width - SHIM_LEN + 20, (inkbird_depth + thick)/2 - SHIM_THICK])
    cube([inkbird_width + thick - SHIM_LEN , thick/2 , thick + 9], center = false);
}

module thermo_hole(x_offset)
{
    translate([x_offset + thick/2 + FUDGE, -60/2, -5])
    cube([ thick, 70, 10]);

    color("CYAN")
    translate([x_offset + thick/2 + FUDGE, 0, +.1])
    cube([ thick , inkbird_depth/2, 10]);
}

difference()
{
    make_box();
    thermo_hole(34.5);
    thermo_hole(54.6);
   
}
