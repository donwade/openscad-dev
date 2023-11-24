$fn=100;
sides = 6;;
spacing = 4;
vector = 360 / sides;
acrossFlats =50;
acrossPoints = acrossFlats /cos(vector/2);

echo (acrossPoints = acrossPoints);
hi=1;
rad=1;
dia=10;
wall_thickness = 5;


module makeCell(width, length,  offset_angle, radius, count )
{
    
    for ( neighbour = [ offset_angle: 360/count : 360 + offset_angle])
    {
        echo (neighbour = neighbour);
        translate([radius * sin(neighbour), radius * cos(neighbour), -.01])
        cylinder( h = 10 + .03, d=acrossFlats *.5 , $fn=sides);
     }

}

width = 300;
length= 300;


//difference()
{
        #cube([  width, length, 10]);
        union()
        {
            makeCell(300, 300, 0, acrossPoints/2, 6 );
            color("GREEN")
            {
                makeCell(300, 300, vector/2, acrossPoints, 12 );
            }
            
            color("BLUE")
            {
                makeCell(300, 300, vector, acrossPoints * 1.5, 18);
                //makeCell(300, 300, 0, acrossPoints );
            }
        }
 }