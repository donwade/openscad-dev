$fn=90;

DIA= (2 + 3/8) * 25.4;
HEIGHT=50;


translate([0, 0, 8])

difference()
{
    color("GREEN", .5)
    cylinder(d = DIA + 6, h = HEIGHT);
    cylinder(d = DIA -1, h = HEIGHT);
    translate([0, -DIA, HEIGHT/4])
    #cube([DIA*2,DIA*2,3]);
}