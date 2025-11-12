
// makes a double ended tapered cube.

module taper_cube(  big = [10, 20], 
                    small = [3, 6], 
                    height=15, 
                    indent_pct=10)
{
    difference()
    {
        cube ([ big.x, big.y, height],center=true);
        
        translate([0, 0, height/2])
        union ()
        {
            hull()
            {
                cube([ big.x, big.y, .01],center=true);
                translate([ 0, 0, -height])
                cube ([ small.x, small.y, .01],center=true);
            }
        }

        indent = height * indent_pct/100;
        translate([0, 0, -height/2 + indent])
        union ()
        {
            #hull()
            {
                cube ([ small.x, small.y, .01],center=true);
                translate([ 0, 0, -indent])
                cube([ big.x, big.y, .01],center=true);
            }
        }

    }
}


//make_bar(10);
//make_drip([ 3*25.4 , 2*25.4]);
taper_cube(indent_pct=30);
