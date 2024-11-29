$fn=90;

difference()
{
    color("GREEN", .5)
    sphere(d = 20);
    translate([ 0, 0, -5])
    cylinder(h=20, d=10.1);
    translate([0, 0, 15])
    #cube([ 20,20, 20], true);
}