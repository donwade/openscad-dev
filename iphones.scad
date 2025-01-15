use <myTools.scad>

phone6= [ 138, 7.1, 40 ];
tweak = [ 4, 1, 0 ];

phone8 = [ 142+ 22, 15.20, 40 ];

Xphone6 = phone6 + tweak;
Xphone8 = phone8 + tweak;

WALL=4;

color("BLUE", .9)
abox( Xphone6, +WALL, round_in=2, bCentered = false);  // 50x25x10 box inside dim origin has 0,0
translate([ 0, Xphone6.y + WALL*2 , 0 ])
color("RED", .9)
abox( Xphone8, +WALL, round_in=2, bCentered = false);  // 50x25x10 box inside dim origin has 0,0


