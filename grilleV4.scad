$fn=50;

hole_diameter = 10;
hole_gap = 2;
hole_spacing = hole_diameter + hole_gap;

length = (11.0 * 25.4) - (11.0 * 25.4) % hole_spacing; 
width  = ( 6.0 * 25.4) - ( 6.0 * 25.4) % hole_spacing;
thick = 5;

numAcross = length / hole_spacing -1;
numDown   = width / hole_spacing -1 ;

difference ()
{
    color("BLUE", .4)
    cube([length, width, thick * 2]);
    
    union()
    {
        translate ( [hole_spacing /2 , hole_spacing /2 , -thick + 1 ])
        cube([length - hole_spacing, width - hole_spacing, thick * 2]); 


        difference ()
        {
            for ( across = [ 1: 1: numAcross ])
            {
                for ( down = [ 1: 1: numDown ])
                {
                    translate ( [across * hole_spacing, down * hole_spacing, -1 ])
                    cylinder(thick * 2 +1, d=hole_diameter);
                    
                    echo ( across = across, down = down);
                }
            }
        }

    }
}
echo ( length = length, width = width);
echo ( numAcross = numAcross, numDown = numDown);