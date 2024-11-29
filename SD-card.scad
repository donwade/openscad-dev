use <myTools.scad>
$fn=50;
SD=[12, 7, 10];

color("BLUE", .9)
abox(SD, +2, round_in=2, bCentered = true);  // 

color("RED")
translate([ 0, -7.9, .4])
rotate([ 10, 0, 0 ])
cube([SD.x + 4, SD.y, SD.z], true);  // 
