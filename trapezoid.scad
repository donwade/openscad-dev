//-----------------------------------------------------------------------------------
module make_trapezoid( from = [10,10] , to = [20,20] , h = 10)
{
    difference()
    {

        offset_x = (to.x - from.x)/2;
        offset_y = (to.y - to.y)/2;
       
        assert ( from.x < to.x, "reverse direction");
        {
            
            hull()
            {
                {
                    color("RED")
                    cube([from.x, from.y, .01], true );

                    translate([0,0, h])
                    color("BLUE")
                    cube([to.x, to.y, .01], true);
                }
            }
        }

        {
            
            hull()
            {
                {
                    color("RED")
                    cube([from.x - 3, from.y - 3, .01], true );

                    translate([0,0, h])
                    color("BLUE")
                    cube([to.x -3 , to.y - 3, .01], true);
                }
            }
        }
        
    }
/*    
    color("RED")
    cube([from.x, from.y, .01], true );

    translate([0,0, h])
    color("BLUE")
    cube([to.x, to.y, .01], true);
*/
   
}

make_trapezoid();
