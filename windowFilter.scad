$fn=60;
function in2mm(x) = (x * 25.4);
function mm2in(x) = (x / 25.4);
//function in2mm(x) = x;

// in inches.
user_height = 2;
user_length = 7;
user_depth  = .5;
user_hole_dia = 3/16;
user_hole_slope = 30;

length = in2mm(user_height);
depth = in2mm(user_depth);
height = in2mm(user_length);


hole_dia = in2mm(user_hole_dia);
between_holes = hole_dia * .4;

dist_bn_holes = hole_dia + between_holes;
echo ("length =", length, "height =", height,  " dist_bn_holes =", dist_bn_holes);

trim = (depth/2) / tan(  user_hole_slope);
echo ("shrink = ", trim);

xacross = length / dist_bn_holes;
xdown = height / dist_bn_holes;

across = floor(xacross) ;
down = floor(xdown) ;

across_offset =  (length - across * dist_bn_holes)/2;
down_offset   =  (height - down * dist_bn_holes)/2;

echo ("across_offset=" , across_offset, "down_offset= ", down_offset);
difference()
{
    union()
    {
        //show a reference where holes can cut thue the 0,0 axis
        //color("blue")
        //translate([0,30,0])
        //cube( [tacross, 1 , tdown], center = true);

        cube([length, depth, height], center = false);

    } 
    
    echo ("across =", across, " down =", down);

    // left limit sits on the x-z plane
    hi_limit = length - hole_dia;
    // right limit sits above x-z plane, needs trig adjustment.
    low_limit = trim;
    
    
    //translate( [-across/2, 0, - down/2])
    {
        for ( x = [ 1: 1: across]){
            for ( z = [ 1: 1: down   ]) {
                overx = x * dist_bn_holes;
                outz = z * dist_bn_holes;
                
                translate ([overx + across_offset, 0, outz + down_offset])
                // do not allow if hole will puncture a side wall
                if (    overx + across_offset < hi_limit 
                    &&  overx + across_offset  > low_limit 
                    &&  outz  <  height - hole_dia)
                {
                    color( "GREEN")
                    // slope rotate done z plain, rotate y on a circle is a circle :)
                    rotate ( [ -90, 0 , user_hole_slope ])
                    #cylinder(4 * depth, d=hole_dia, center = true);
                    echo ( "IN x:z=", x,":",z, " ", low_limit, " < ", overx, " < ", hi_limit, " trim=", trim  , -across/2);
                }
                else
                {
                    // can't drill this hole, it would come out a sidewall
                    color( "RED")
                    rotate ( [ -90, 0 , user_hole_slope ])
                    // * = disable action
                    *cylinder(4 * depth, d=hole_dia, center = true);
                    echo ( "OUT x:z=", x,":",z, " ", low_limit, " < ", overx, " < ", hi_limit, " trim=", trim  , -across/2);
                }
                
            }
        }
    }
}