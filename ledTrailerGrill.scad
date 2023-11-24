$fn=100;
width =  35.64; //52.17 -11.68 - 2.85;
lenght = width/2;
thick = 3;

tweak = 0;
repeat = 11;

//cube( [ lenght, width - tweak, 2]);

echo ("final width = ", width - tweak, " mm");


module make1()
{
    difference()
    {
        cylinder( h = thick, r= width/2);
        cylinder( h = thick, r= width/2 - 5);
    }
}

difference()
{
    union()
    {
        for (x = [ 0: 1: repeat] )
        {
            translate( [ x * width/2, 0, 0])
            make1();
        }
        //color("green")
        //cube([ 8*25.4, 1, 1]);
    }
    union ()
    {
        translate( [-width/2, 0  , 0] )
        #cube([width, width, thick *2], center = true);

        translate( [ +width * (repeat+1)/2, 0 , 0] )
        #cube([width, width, thick * 2], center = true);

    }
}