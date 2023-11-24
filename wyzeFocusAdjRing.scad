$fn=200;

HEIGHT=6.61 - 2.4;

LENSE_OUTER = 14.05 - .02;
LENSE_COVER = 16.5- .1;
SHROUD_DIA = 30;
SHROUD_THICK = 3;

difference()
{
    cylinder(HEIGHT, d = LENSE_COVER);
    translate( [ 0, 0, -HEIGHT*2 ])
    cylinder(HEIGHT * 4 , d = LENSE_OUTER);
}

translate( [ 0, 0, -HEIGHT/2] )
{
    difference()
    {
        cylinder(h = HEIGHT/2, d = SHROUD_DIA);
        cylinder(h = HEIGHT/2, d = LENSE_COVER);
    }
}
 