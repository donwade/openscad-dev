
WIDTH = 5 * 25.4;
HEIGHT = 14;
THICK = HEIGHT/2;
PENCIL_WIDTH = 1/16 * 25.4;

difference()
{
    difference()
    {
        cube( [ WIDTH, WIDTH, HEIGHT], center = false);
        translate( [ THICK ,THICK ,THICK/2])
        cube( [ WIDTH, WIDTH, HEIGHT], center = false);
    }

    rotate( [ 0, 0, 45] )
    translate( [ -PENCIL_WIDTH/2, -PENCIL_WIDTH/2, -HEIGHT/2 ] )
    #cube([WIDTH * 1.2, PENCIL_WIDTH, HEIGHT], center = false);
}