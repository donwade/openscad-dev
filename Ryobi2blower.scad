
$fn=50;

HEIGHT= 10;
OUTER_DIAMETER=68;
difference()
{
    cylinder(h=HEIGHT, d=OUTER_DIAMETER);
    cylinder(h=HEIGHT, d=OUTER_DIAMETER-10);
}