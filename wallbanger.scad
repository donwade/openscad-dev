
SIDES=8;

$fn=SIDES; // make hexagon

HEIGTH= 4;
DEGREES = 360/ SIDES;

FLATSIDE = 3/4 * 25.4; 
ACROSS_CORNER = FLATSIDE / cos(DEGREES);

cylinder(h = HEIGTH, d= ACROSS_CORNER);



