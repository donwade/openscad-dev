// slip cover for dwalt atomic laser range finder DW055PL.
// it protects LCD screen and on/off button

// you want rounded corners? Get a file out of your toolbox you lazy cow.

inside_x = 38.33;
inside_y = 51;
inside_z = 20.63;    // switch is fatest

thick = 8;  // 5mm walls should protect it from my hammer :(

outside_x = inside_x + thick;
outside_y = inside_y + thick;    
outside_z = inside_z + thick;

difference()
{
    color("RED", .3) cube ([outside_x, outside_y, outside_z], true);
    translate ([0, -thick/2, 0])
    cube ([inside_x, inside_y, inside_z], true);
}