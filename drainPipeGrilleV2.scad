hans_hak  =   0;  
x   =  3 ; //81.61 + hans_hak; //13;
y   =  2 ; //57.24 + hans_hak; //12;16;
z  =   2.2 ;  // length of box

wall_thickness = (5/8);
$fn=50;

//difference()
{
    difference()
    {
        difference()
        {
            union()
            {
                cube ([x + wall_thickness, y + wall_thickness, z], center=true);    
            }
            union()
            {
                translate([0, 0, +wall_thickness ]) cube ([x, y, z ], center=true);
               
                //#rotate([0, -90, 0])
                linear_extrude(height=700, scale=50) square([x , y ], center=true);
            }
        }
        // punch in the grille.
        hold_diameter = (7/16);
        across = 6;
        down = 4;
        across_x = x / (across-1);  // fence post math :)
        down_y = y / (down-1);
        
        for (column = [ 0:1: across-1])
        { 
            for (row = [ 0:1: down-1])
            {
                tcol = column * across_x - x/2;
                trow = row  * down_y - y/2;
                
                echo(column, " ", row, "    ", tcol, " .. ", trow);
                translate([tcol , trow  , -z/2  - wall_thickness  ])
                #cylinder(wall_thickness+1, d=hold_diameter, center= false);
            }
        }
    }
    
    // cut in 2 for inspection
    //translate([0, y, 0])
    //cube ([2 *x, 2*y , 2* z], center=true);    
}
