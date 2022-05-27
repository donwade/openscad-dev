oversize_mm = 1;
echo ("********************************");
echo ("newMath.scad oversize_mm set to ", oversize_mm);
echo ("********************************");

//------------------------------------------------------------------------

module CYLINDER(height=1,radius=1, center = true)
{
    if (center == true)
    {
        color("RED")
        cylinder(h = height, r = radius, center = true);
 
        color("VIOLET", .2)
        cylinder(h = height, r = radius + oversize_mm/2, center = true);
    }
    else
    {
        color("RED")
        translate([radius, radius, 0])
        cylinder(h = height, r = radius, center = false);

        color("VIOLET", .2)
        translate([radius, radius, 0])
        cylinder(h = height, r = radius + oversize_mm/2, center = false);
    }
}

//------------------------------------------------------------------------
module CUBE(size, center = true)
{
    cube(size + oversize_mm_mm, center);
}
//------------------------------------------------------------------------

module CUBE(dimension = [0 , 0, 0], center = true)
{
    if (center == true)
    {
        // the true size
        color("GREEN", 1)
        cube([dimension[0], dimension[1], dimension[2]], center);

        // the adjusted size
        color("BLUE", .2)
        cube([dimension[0] + oversize_mm, dimension[1] + oversize_mm, dimension[2] + oversize_mm], center);
    }
    else
    {
        // the true size
        color("GREEN", 1)
        cube([dimension[0], dimension[1], dimension[2] ], center = false);

        // the adjusted size
        color("BLUE", .2)
        translate([-oversize_mm/2, -oversize_mm/2, -oversize_mm/2])
        cube([dimension[0] + oversize_mm, dimension[1] + oversize_mm, dimension[2] + oversize_mm], center = false);
    }
}

//------------------------------------------------------------------------
module SHIM(shim_width, shim_len, shim_degrees = 45, shim_origin = 0)
{
    // shim origin = 0 narrow point,  !=0 highest part
    translate([0, shim_origin ? -shim_len : 0, 0])
    difference ()
    {
        cube([shim_width, shim_len, max(shim_width, shim_len) ]);

        union()
        {
            // cut the incline, ensure mathmatically FULLY cut
            rotate([shim_degrees,0, 0 ])
            #cube([shim_width, sqrt(2*(shim_len * shim_len)), shim_len * 1]);
        }
    }
}

translate([150, 0, 0])
SHIM(25, 100, 30, 0);  // 25 wide 100 long 30 degrees

//CUBE(10, center = false);

CUBE(dimension=[3,6,9], center = true);
translate([ 10,10,10])
CUBE([3,6,9], center = false);

translate([75,75,0])
CYLINDER(height=30, radius=20, center=true);

translate([100,100,0])
CYLINDER(height=40, radius=9, center=false);
