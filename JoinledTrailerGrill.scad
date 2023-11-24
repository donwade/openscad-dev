$fn=150;
width =  35.64; //52.17 -11.68 - 2.85;  
lenght = width/2;
thick = 3;

tweak = 0;
repeat = 2;

//cube( [ lenght, width - tweak, 2]);

echo ("final width = ", width - tweak, " mm");


module make1(height, rads)
{
    difference()
    {
        cylinder( h = height, r= rads/2);
        cylinder( h = height, r= rads/2 - 5);
    }
}

module make2(height, rads)
{
    difference()
    {
        #cylinder( h = height, r= rads/2);
        cylinder( h = height, r= rads/2 - 5);
    }
}

difference()
{
    union()
    {
        for (x = [ 0: 1: repeat] )
        {
            translate( [ x * width/2, 0, 0])
            make1(height = thick, rads = width );
        }
    }
    
    // chop end pieces
    union ()
    {
        color("PURPLE", .1)
        {
            translate( [-width/2, 0  , 0] )
            cube([width, width, thick *2], center = true);

            translate( [ +width * (repeat+1)/2, 0 , 0] )
            cube([width, width, thick * 2], center = true);
        }
    }
}
/*
color("BLUE")
{
    
    intersection()
    {
        translate( [ width/2, 0, 0 ])
        make1(height = thick, rads = width - 10);
        translate( [ 0, 0, 0 ])
        make1(height = thick, rads = width - 10);
    }
    
    intersection()
    {
        translate( [ width/2, 0, 0 ])
        make1(height = thick, rads = width - 10);
        translate( [ width, 0, 0] )
        make1(height = thick, rads = width - 10);
    }
}
*/
