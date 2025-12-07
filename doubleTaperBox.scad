
// makes a double ended tapered cube.


module INT_taper_cube( big, small, height, wall, indent_pct)
{

    difference()
    {
        cube ([ big.x, big.y, height],center=true);
        
        translate([0, 0, height/2])
        union ()
        {
            hull()
            {
                cube([ big.x - wall, big.y -wall , .01],center=true);
                translate([ 0, 0, -height])
                cube ([ small.x, small.y, .01],center=true);
            }
        }
    }
    
    translate([0, 0, -height/2+.1]) // .1 no gcode issue
    hull()
    {
        cube([ big.x, big.y , .01],center=true);
        translate([ 0, 0, -height/2-1.1])
        cube ([ small.x + wall, small.y + wall, .01],center=true);
    }

    
}

module taper_cube(  big = [10, 20], 
                    small = [3, 6], 
                    height=15,
                    wall = 4, 
                    indent_pct=10)
{
    // punch out. work is done elsewhere
    difference()
    {
        INT_taper_cube( big, small, height, wall, indent_pct);
        cube ([ small.x, small.y, height*4],center=true);
    }
}
//make_bar(10);
//make_drip([ 3*25.4 , 2*25.4]);
taper_cube(big=[3 * 25.4,
                2 * 25.4],
           small=[2.5  * 25.4,
                  1.75 * 25.4],
           height=30,
           indent_pct=50);
