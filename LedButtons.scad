$fn=200;

LED_DIA = 4.9;
LED_HEIGHT = 3.63;

//cylinder(h = .3 , d =LED_DIA *4);

difference()
{
    difference()
    {
        sphere(d= LED_DIA * 4);
        translate([ 0, 0, -LED_DIA * 2])
        cube([LED_DIA*4, LED_DIA*4, LED_DIA *4], true);
    }
    #cylinder(h = LED_HEIGHT + .2 , d= LED_DIA);
}
