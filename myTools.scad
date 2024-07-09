
module tube (r = 0, d = 0, l = 0, 
            thick = 0, 
            bCentered = true, 
            taper_pct = 0, 
            circlip = false) // r=radius d=dia l=length 
{
    assert( r != 0 || d != 0, "specify one of radius or diameter");
    assert( l != 0 , "tube: need length 'l' to be non zero");
    assert( thick != 0, "wall thickness cannot be zero");

    punch = $preview ? .2 : 0; // stop funny view artifact

    dia = r ? r * 2 : d;

    od = ((thick > 0) ? dia + thick * 2 : dia);
    id = (thick > 0) ? dia             : dia  + thick *2; 

    
    
    if (thick > 0)
        echo ("tube\tMIN id = ", id, "od = ", od, "wall = ", thick, "center= ", bCentered);
    else
        echo ("tube\tMAX od = ", od, "id = ", id, "wall = ", thick, "center= ", bCentered);

    echo ("tube\tHeigth = ", l);
        
    if (taper_pct != 0)
    {
        echo ("tube\t*** OD expanded by ", taper_pct, "%, : bottom od = ", od * (1. +taper_pct/100), "top od = ", od);
    }
    
    assert(dia || dia < 0, "tube : missing r or d ");
    
    // if taper_pct specified, the base will always be closest to 0,0,0
    translate([ 0, 0, taper_pct == 0 ? 0: bCentered ? l/2:l  ])
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
//==============================================================================
        
module abox (dims, 
            thick = 0, 
            bCentered = true, 
            round_out = 0, 
            round_in = 0, 
            bSolid = false,
            bHollow = false,
            elevator = 0)   // move bottom up by X
{
    punch = $preview ? .1 : 0; // stop funny view artifact
    
    assert(thick != 0, "Thick must be specified. +=outside dim, -= inside dims");
    assert(dims.z > thick, "wall thickness too large for depth of box");

    wall2 = abs(thick) * 2; // 2 walls in each direction
    wall = wall2 / 2;
    
    // box either grows inward (thick < 0) or outward (thick > 0)  from dims
    fat = dims + [ wall2, wall2, wall];
    thin = dims - [ wall2, wall2, wall];
    
    offset = (thick > 0 && bCentered == false) ? wall : 0;
    
    //echo ("abox : adjusting x,y,z by ", offset, " to move origin from  center to 0,0,0");
    translate( [ bCentered ? 0 : dims.x /2 + offset, bCentered ? 0 : dims.y /2 + offset, bCentered ? 0 : dims.z /2 + offset/2]) 
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
        // after calc, re-center about 0,0,0 where a bCentered cube would be
        
        translate([ 0, 0, thick > 0  ? -fat.z/2 : -dims.z/2 ])
        difference()
        {
            echo ("round_out = ", round_out);

            // MAKE SOLID BOX --------------------------------------
            router_outside = round_out ? round_out : 0;
            x = thick > 0  ? fat.x - router_outside : dims.x - router_outside;
            y = thick > 0  ? fat.y - router_outside : dims.y - router_outside;


            // MAKE PUCHNED INSIDE
            // using 'offset' it will add r on all dimensions, then round., 
            // so now you have fatter perimeter than you started with :(
            //  but at least the corners are round.
            
            // Compensate by shrinking dimension by r, 
            // and then by calling offset, offset will then add it back

            color("YELLOW", .2)

            linear_extrude(thick > 0  ? fat.z : dims.z)
            if (round_out)
            {
                offset( r= round_out, $fn=30)
                square( [x - router_outside, y - router_outside], true);
            }
            else square( [x - router_outside, y - router_outside], true);
           
            // time to punch out the inside if requested.
            if (bSolid == false)
            {
                hollow_offset = bHollow ? fat.z/2 + .2  : dims.z/2 +.2;
                // punching out inside. its either dims or thin.
                router_inside = round_in;
                echo ("round_in = ", router_inside);
                xi = thick > 0  ? dims.x  : thin.x;
                yi = thick > 0  ? dims.y : thin.y ;

                color("GREEN")

                // move 'punch' up if you need a bottom else zero (hollowed out)

                translate([ 0,0, bHollow ? -.1 : wall + elevator]) 
                linear_extrude(thick > 0  ? fat.z - wall  + hollow_offset : dims.z - wall + hollow_offset)
                //#linear_extrude(fat.z - wall  + hollow_offset)
                
                if (round_in) 
                {
                    offset( r= round_in, $fn=30)
                    square( [ xi - router_inside, yi - router_inside], true);
                }
                else
                    square( [ xi, yi], true);
            }
        }
    }
 }
//-----------------------------------------------------
module abox_punch (dims, 
            thick = 0, 
            bCentered = true, 
            round_out = 0, 
            round_in = 0, 
            bSolid = false,
            bHollow = false,
            elevator = 0)   // move bottom up by X
{
    punch = $preview ? .1 : 0; // stop funny view artifact
    
    assert(thick != 0, "Thick must be specified. +=outside dim, -= inside dims");
    assert(dims.z > thick, "wall thickness too large for depth of box");

    wall2 = abs(thick) * 2; // 2 walls in each direction
    wall = wall2 / 2;
    
    // box either grows inward (thick < 0) or outward (thick > 0)  from dims
    fat = dims + [ wall2, wall2, wall];
    thin = dims - [ wall2, wall2, wall];
    
    offset = (thick > 0 && bCentered == false) ? wall : 0;
    
    //echo ("abox : adjusting x,y,z by ", offset, " to move origin from  center to 0,0,0");
    translate( [ bCentered ? 0 : dims.x /2 + offset, bCentered ? 0 : dims.y /2 + offset, bCentered ? 0 : dims.z /2 + offset/2]) 
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
        // after calc, re-center about 0,0,0 where a bCentered cube would be
        
        translate([ 0, 0, thick > 0  ? -fat.z/2 : -dims.z/2 ])
        difference()
        {
            echo ("round_out = ", round_out);

            // MAKE SOLID BOX --------------------------------------
            router_outside = round_out ? round_out : 0;
            x = thick > 0  ? fat.x - router_outside : dims.x - router_outside;
            y = thick > 0  ? fat.y - router_outside : dims.y - router_outside;


            // MAKE PUCHNED INSIDE
            // using 'offset' it will add r on all dimensions, then round., 
            // so now you have fatter perimeter than you started with :(
            //  but at least the corners are round.
            
            // Compensate by shrinking dimension by r, 
            // and then by calling offset, offset will then add it back

            color("YELLOW", .2)

            // delete the solid part.
            
            // time to punch out the inside if requested.
            if (bSolid == false)
            {
                hollow_offset = bHollow ? fat.z/2 + .2  : dims.z/2 +.2;
                // punching out inside. its either dims or thin.
                router_inside = round_in;
                echo ("round_in = ", router_inside);
                xi = thick > 0  ? dims.x  : thin.x;
                yi = thick > 0  ? dims.y : thin.y ;

                color("GREEN")

                // move 'punch' up if you need a bottom else zero (hollowed out)

                translate([ 0,0, bHollow ? -.1 : wall + elevator]) 
                linear_extrude(thick > 0  ? fat.z - wall  + hollow_offset : dims.z - wall + hollow_offset)
                //#linear_extrude(fat.z - wall  + hollow_offset)
                
                if (round_in) 
                {
                    offset( r= round_in, $fn=30)
                    square( [ xi - router_inside, yi - router_inside], true);
                }
                else
                    square( [ xi, yi], true);
            }
        }
    }
 }



// 50x25x10 box walls grow inward (-2). on center origin midpoint
// rounded outside (default), sharp corner inside(default), bCentered about 0,0,0
//color("GREEN", .9)
//abox([50,25, 10], -2, true); 


// 50x25x10 box walls grow inward (-2). on center origin midpoint
// sharp outside corners, rounded inside corners. Sit on x,y plane
color("BLUE", .9)
abox([50,20, 10], +2, round_in=2, bCentered = false);  // 50x25x10 box inside dim origin has 0,0


// 50x25x10 box walls grow inward (-2). on center origin midpoint
// sharp corners inside and out. sits on x,y plane
color("GREY", .9)//
translate([ 55, 0, 0])      
abox([50,20, 10], +2, round_out=3, false);

color("PINK", .9)//
translate([ 115, 10, 10])      
abox([86.66, 56.865, 5], -5, bHollow = true, bCentered = false); 

color("GREEN", .9)//
translate([ 140, 10, -10])      
abox([86.66, 56.865, 5], 3, bHollow = true, bCentered = false); 

/*
// 50x25x10 box walls grow inward (-2). on center origin midpoint
// round corners outside and SOLID
color("BLUE", .9)//
translate([ 55, 0, 0])      
abox([50,25, 10], +2, round_out=2, round_in=0, false, bSolid = true); // 50x25x10 box outside dim origin is 0,0
*/

//translate ([-30,-30, 0])
{
/*
    // tube outer dia  20, inner dia = (20 - 8)
    color("PINK")
    tube (d = 20, l = 20, thick = -8, bCentered = false);

    // tube, inner dia = (2* 10), outer dia = ((2*10) + 2) 
    color("PURPLE", .3)
    tube (r = 10, l = 20, thick = +2, bCentered= true);
*/
/*
    tube (d = 60, l = 20, thick = -6, bCentered = false);

    translate([0, 0, 50])
    tube (d = 60, l = 20, thick = -6, bCentered = false, taper_pct = 20, circlip = true);
    //color("GREEN")
    //tube (d = 20, l = 20, thick = -2, bCentered = false, taper = 10, circlip = true);
*/

}
