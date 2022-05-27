use </home/dwade/openscad-dev/newMath.scad>
$fn=100;
oversize_mm = 10;
echo ("********************************");
echo ("NEW - OVERRIDE newMath.scad oversize_mm set to ", oversize_mm, " mm");
echo ("********************************");


window_width= (29 * 25.4) / 4; //25.4;  // 29.25 * 25.4  29 1/4 into mm
adapter_depth = 105.37;
adapter_height = 35;

part1y = 28.3;
part1z = 8.54;

part2y = 38.4;
part2z = 0 ; //.0001;

part3y = 1.6;
part3z = 17.7 + 2;

part4y = 33.0;
part4z = 0; //.00001

part5y = 4;
part5z = 4;

start = 0;

difference ()
{
    union() 
    {
    color("GREEN", .2)
    cube([window_width , adapter_depth, adapter_height], center = false);

    color("GREY")
    translate([0, part1y + part2y + part3y - .5, 0])  // move to just past high cut
    rotate([-7, 0, 0])
    cube([window_width, part4y, 10], center = false) ;
                
   }
    union ()
    {
        start1 = 0;

        echo ("start at ", start1);
        translate([0, start1, 0])
        {
            color("PURPLE")
            CUBE([window_width, part1y, part1z], center = false);
        
            echo("start at ", part1y);
            translate([0,  part1y , 0])
            {
                color("RED");
                CUBE([window_width, part2y, part2z], center = false);
                
                    echo ("start at ", part2y);
                    translate([0, part2y, 0])
                    {
                        color("BLUE")
                        CUBE([window_width, part3y, part3z], center = false);

                        echo ("start at ", part3y);
                        translate([0, part3y, 0])
                        {
                            ///color("ORANGE")
                            //CUBE([window_width, part4y, part4z], center = false);
                            
                            echo ("start at ", part4y);
                            translate([0, part4y, 0])
                            {
                                color("CYAN")
                                CUBE([window_width, part5y, part5z], center = false);
                            }
                        }
                    }
            }
            
            
          //  start4 = part1y + part2y + part3y;
          //  echo ("start at to ", start4);
          //  translate([0, start4, -.30000])
          //  #cube([window_width, part4y, part4z], center = false);
        }
    }
    

}