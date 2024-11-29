$fn=90;

DIA= (2 + 3/8) * 25.4;
HEIGHT=50;
THICK=5;

translate([0, 0, 8])

difference()
{
    color("GREEN", .5)
    cylinder(d = DIA + THICK*2, h = HEIGHT);
    cylinder(d = DIA +.5, h = HEIGHT);
    translate([-DIA/4, -DIA*3/4, HEIGHT/3])
    #cube([DIA*2,DIA*2,3]);
}