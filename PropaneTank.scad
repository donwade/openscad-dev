$fn=100;
CIRCUMFERENCE = 39;

radius = CIRCUMFERENCE / (2 * PI);
echo ("radius = ", radius);

diameter = radius * 25.4 * 2;  // meteric diameter

tall = 4.0 * 25.4;

difference()
{
    cube( [ diameter/2, diameter/2, tall],  false);
    cylinder(h = tall * 2+ 1, r = diameter/2, center = true);
}
