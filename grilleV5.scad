$fn=50;

hole_diameter = 3/8 * 25.4;
hole_gap = 2;
hole_spacing = hole_diameter + hole_gap;

//gross_length = (11.0 * 25.4);  // airconditioner top grille
//gross_width  = ( 6.0 * 25.4);

gross_length = (17.5 * 25.4) / 2;  // airconditioner top grille
gross_width  = ( 12 * 25.4) / 2;


length = (gross_length) + (gross_length) % hole_spacing/2; // round up to nearest half hole 
width  = ( gross_width) + (gross_width) % hole_spacing/2;
thick = 3;

punch_tweak = 2;  // 2 above and below punch
numAcross = length / hole_spacing ;
numDown   = width / hole_spacing ;

union ()
{

    difference ()
    {
        color("BLUE", .4)
        cube([length, width, thick]);
        
        union()
        {
            translate ( [hole_spacing /2 , hole_spacing /2 , -thick ])
            cube([length - hole_spacing, width - hole_spacing, thick]); 

            
            difference ()
            {
                for ( across = [ 0: 1: numAcross])
                {
                    for ( down = [ 0: 1: numDown ])
                    {
                        
                        translate ( [across * hole_spacing + hole_spacing/2 * (down %2), down * hole_spacing, -punch_tweak ])
                        //translate ( [across * hole_spacing + hole_spacing/2 * (down %2), down * hole_spacing + hole_spacing/2 * (across %2), -punch_tweak ])
                        #cylinder(thick + punch_tweak *2, d=hole_diameter);
                        
                        // echo ( across = across, down = down);
                    }
                }
            }
            

        }
    }
    // reissue the perimeter, to fill in half holes that go past internal walls.
    color("PURPLE", .4)
    {
        cube([length, hole_spacing/2, thick * 3]);
        cube([hole_spacing/2, width, thick * 3]);
        
        translate([ 0, width - hole_spacing/2, 0])
        cube([length, hole_spacing/2, thick * 3]);

        translate([ length - hole_spacing/2 , 0, 0])
        cube([hole_spacing/2, width, thick * 3]);
    }
}    
echo ( gross_length = gross_length, length = length, gross_width = gross_width, width = width);
echo ( gross_length = 2* gross_length/25.4, length = 2* length/25.4, gross_width = 2* gross_width/25.4, width = 2*width/25.4);
echo ( numAcross = numAcross, numDown = numDown);