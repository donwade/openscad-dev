
module tube (r = 0, d = 0, l = 0, thick = 0, centered = true, taper_pct = 0, circlip = false) // r=radius d=dia l=length 
{
    assert( r != 0 || d != 0, "specify one of radius or diameter");
    assert( l != 0 , "tube: need length 'l' to be non zero");
    assert( thick != 0, "wall thickness cannot be zero");

    punch = $preview ? .2 : 0; // stop funny view artifact

    dia = r ? r * 2 : d;

    od = ((thick > 0) ? dia + thick * 2 : dia);
    id = (thick > 0) ? dia             : dia  + thick *2; 

    
    
    if (thick > 0)
        echo ("tube\tMIN id = ", id, "od = ", od, "wall = ", thick, "center= ", centered);
    else
        echo ("tube\tMAX od = ", od, "id = ", id, "wall = ", thick, "center= ", centered);

    echo ("tube\tHeigth = ", l);
        
    if (taper_pct != 0)
    {
        echo ("tube\t*** OD expanded by ", taper_pct, "%, : bottom od = ", od * (1. +taper_pct/100), "top od = ", od);
    }
    
    assert(dia || dia < 0, "tube : missing r or d ");
    
    // if taper_pct specified, the base will always be closest to 0,0,0
    translate([ 0, 0, taper_pct == 0 ? 0: centered ? l/2:l  ])
    rotate([0, taper_pct == 0 ? 0 : 180, 0 ])

    difference()
    {
        // make a reese's cup
        {
            color("YELLOW", .3)
            linear_extrude(height= l, scale = 1 + taper_pct/100)
                difference()
                {
                    circle(d = od);
                    circle(d = .5);
                }
        }
    
     // hollow out reessed cup
     color("GREEN")
     translate([0, 0, -punch/2])
     linear_extrude(height= l+ punch*2, $fn=100)
     {
        circle(d = id);
        if (circlip) #square([1 + punch, od ]);
     }
    
    }
}
        
module abox (dims, thick = 0, centered = true, bRoundOut = true, bRoundIn = false, bSolid = false)
{
    punch = $preview ? .1 : 0; // stop funny view artifact
    
    assert(thick != 0, "Thick must be specified. +=outside dim, -= inside dims");
    assert(dims.z > thick, "wall thickness too large for depth of box");

    wall2 = abs(thick) * 2; // 2 walls in each direction
    wall = wall2 / 2;
    
    // box either grows inward (thick < 0) or outward (thick > 0)  from dims
    fat = dims + [ wall2, wall2, wall];
    thin = dims - [ wall2, wall2, wall];
    
    offset = (thick > 0 && centered == false) ? wall : 0;
    
    //echo ("abox : adjusting x,y,z by ", offset, " to move origin from  center to 0,0,0");
    translate( [ centered ? 0 : dims.x /2 + offset, centered ? 0 : dims.y /2 + offset, centered ? 0 : dims.z /2 + offset/2]) 
    {
        if (thick > 0)
        {   
            // wall grows outwards from users dim
            echo ("making a box, MAX INSIDE dim = ", dims, "a wall=", thick, "mm ... max outside = ", fat, " mm");
        }
        else
        {
            // wall grows inward from users dime
            echo ("making a box, MAX OUTSIDE dim = ", dims, "a wall=", thick, "mm ... min inside = ", thin, " mm");
        }
        
        // linear extrude alway works in the positive x/y plane an goes upward.
        // after calc, re-center about 0,0,0 where a centered cube would be
        
        translate([ 0, 0, thick > 0  ? -fat.z/2 : -dims.z/2 ])
        difference()
        {
            router_outside = bRoundOut ? wall : 0;
            x = thick > 0  ? fat.x : dims.x;
            y = thick > 0  ? fat.y : dims.y;

            color("YELLOW", .2)

            // using 'offset' it will add r on all dimensions, then round., so it you want
            //      now you have fatter perimeter than you stared with, but corners are round.
            //      compensate by shrinking dimension by r, calling offset then will put it back include      for bRoundOut, subtract 'r' knowing expansion will happen.

            linear_extrude(thick > 0  ? fat.z : dims.z)
            if (bRoundOut)
            {
                offset( r= wall/2, $fn=30)
                square( [x - router_outside, y - router_outside], true);
            }
            else square( [x - router_outside, y - router_outside], true);
           
            if (bSolid == false)
            {
                // punching out inside. its either dims or thin.
                router_inside = bRoundIn ? wall : 0;
                xi = thick > 0  ? dims.x : thin.x;
                yi = thick > 0  ? dims.y : thin.y;

                color("GREEN")
                translate([ 0,0, wall]) // make sure the box has a bottom.
                linear_extrude(thick > 0  ? fat.z - wall + punch : dims.z - wall + punch)
                if (bRoundIn) 
                {
                    offset( r= wall/2, $fn=30)
                    square( [ xi - router_inside, yi - router_inside], true);
                }
                else
                    square( [ xi, yi], true);
            }
        }
    }
 }


// 50x25x10 box walls grow inward (-2). on center origin midpoint
// rounded outside (default), sharp corner inside(default), centered about 0,0,0
//color("GREEN", .9)
//abox([50,25, 10], -2, true); 

/*
// 50x25x10 box walls grow inward (-2). on center origin midpoint
// sharp outside corners, rounded inside corners. Sit on x,y plane
color("BLUE", .9)
abox([50,25, 10], -2, bRoundOut=false, bRoundIn=true, centered = false);  // 50x25x10 box inside dim origin has 0,0

// 50x25x10 box walls grow inward (-2). on center origin midpoint
// sharp corners inside and out. sits on x,y plane
color("GREY", .9)//
translate([ 55, 0, 0])      
abox([50,25, 10], +2, bRoundOut=false, bRoundIn=false, false); // 50x25x10 box outside dim origin is 0,0
*/

// 50x25x10 box walls grow inward (-2). on center origin midpoint
// round corners outside and SOLID
color("BLUE", .9)//
translate([ 55, 0, 0])      
abox([50,25, 10], +2, bRoundOut=true, bRoundIn=false, false, bSolid = true); // 50x25x10 box outside dim origin is 0,0


//translate ([-30,-30, 0])
{
/*
    // tube outer dia  20, inner dia = (20 - 8)
    color("PINK")
    tube (d = 20, l = 20, thick = -8, centered = false);

    // tube, inner dia = (2* 10), outer dia = ((2*10) + 2) 
    color("PURPLE", .3)
    tube (r = 10, l = 20, thick = +2, centered= true);
*/

    tube (d = 60, l = 20, thick = -6, centered = false);

    translate([0, 0, 50])
    tube (d = 60, l = 20, thick = -6, centered = false, taper_pct = 20, circlip = true);
    //color("GREEN")
    //tube (d = 20, l = 20, thick = -2, centered = false, taper = 10, circlip = true);


}
