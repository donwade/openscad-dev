
/* flat circular coin
$fa = 1;
$fs = 0.4;
wheel_radius = 12;
tyre_diameter = 6;
translate([wheel_radius - tyre_diameter/2, 0])
    circle(d=tyre_diameter);

*/

// add rotate_extrude against the coin 
$fa = 1;
$fs = 0.4;
wheel_radius = 12;
tyre_diameter = 6;

color("GREEN")
rotate_extrude(angle=360) {
    translate([wheel_radius - tyre_diameter/2, 0])
        circle(d=tyre_diameter);
}

// make a circle, make it into an elipse using scale and make it 10 units high
color("BLUE")
translate([25,0, 0])
linear_extrude(height=50,center=true)
    scale([2,1,1])
    circle(d=10);
    
// make a circle, 
//  make it into an elipse using scale
// twist it 180 degrees
//  and make it 10 units high
color("RED")
translate([50,0, 0])
linear_extrude(height=50,center=true, twist=120)
    scale([2,1,1])
    circle(d=10);
    
// make a circle, 
//  make it into an elipse using scale
// twist it 180 degrees
// make the finishing end 1.5 times bigger than the bottom end via scale param
//  and make it 10 units high
color("YELLOW")
translate([75,0, 0])
linear_extrude(height=50,center=true, twist=120, scale=1.5)
    scale([2,1,1])
    circle(d=10);
    
