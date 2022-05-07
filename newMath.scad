abs_tweek = 1;


module CYLINDER(height=1,radius=1, center = true)
{
    if (center == true)
    {
        color("RED")
        cylinder(h = height, r = radius, center = true);
 
        color("VIOLET", .2)
        cylinder(h = height, r = radius + abs_tweek/2, center = true);
    }
    else
    {
        color("RED")
        translate([radius, radius, 0])
        cylinder(h = height, r = radius, center = false);

        color("VIOLET", .2)
        translate([radius, radius, 0])
        cylinder(h = height, r = radius + abs_tweek/2, center = false);
    }
}


module CUBE(size, center = true)
{
    cube(size + abs_tweek_mm, center);
}

module CUBE(dimension = [0 , 0, 0], center = true)
{
    if (center == true)
    {
        // the true size
        color("GREEN", 1)
        cube([dimension[0], dimension[1], dimension[2]], center);

        // the adjusted size
        color("BLUE", .2)
        cube([dimension[0] + abs_tweek, dimension[1] + abs_tweek, dimension[2] + abs_tweek], center);
    }
    else
    {
        // the true size
        color("GREEN", 1)
        cube([dimension[0], dimension[1], dimension[2] ], center = false);

        // the adjusted size
        color("BLUE", .2)
        translate([-abs_tweek/2, -abs_tweek/2, -abs_tweek/2])
        cube([dimension[0] + abs_tweek, dimension[1] + abs_tweek, dimension[2] + abs_tweek], center = false);
    }
}


//CUBE(10, center = false);

CUBE(dimension=[3,6,9], center = true);
translate([ 10,10,10])
CUBE([3,6,9], center = false);

translate([75,75,0])
CYLINDER(height=30, radius=20, center=true);

translate([100,100,0])
CYLINDER(height=40, radius=9, center=false);
