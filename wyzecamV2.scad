$fn=200;

HEIGHT=6.61 - 2.4;

LENSE_OUTER = 14.05 - .02;
LENSE_COVER = 16.5- .1;
SHROUD_DIA = 32;
SHROUD_THICK = 3;

difference()
{
    cylinder(HEIGHT, d = LENSE_COVER);
    translate( [ 0, 0, -HEIGHT*2 ])
    cylinder(HEIGHT * 4 , d = LENSE_OUTER);
}

translate( [ 0, 0, -HEIGHT] )
{
    difference()
    {
        cylinder(h = HEIGHT, d1 = SHROUD_DIA, d2 = LENSE_COVER);
        #cylinder(h = HEIGHT, d1 = SHROUD_DIA - SHROUD_THICK , d2 = LENSE_COVER - SHROUD_THICK);
    }
}
