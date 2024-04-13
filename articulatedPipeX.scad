//outside dimensions of the box

 bBuildBody = 1;
 bBuildLockRim = 1;

straight_run = 2.5;  // make it a few feet ha ha

/* [Hidden] */
$fn= $preview ? 50 : 75;

MM = 25.43;

length_od = 80.24;
width_od = 55.62;

straight_run_mm = straight_run * MM;

tilt = 6.15; //below 90 degrees

//additional parameters
wall_thickness = 10;

module mark() 
{
    if ($preview)  cylinder(h=10, r1 =2, r2=1);
}


module run_iterator(action)
{
    echo ("run_iterator : ", $children, " objects passed in");
    //difference()
    {
        //cube ([200,200,200]);
        
        for(i=[0:$children-1])
               children(i); // do the shapes that come after us!
               
    }
}

module make_2D_template(bRemove = false, heigth = straight_run_mm) 
{

    translate([ 0, 0, heigth/2])  // move to start in xy plane

    if (bRemove)
    {
        x = width_od - wall_thickness;
        y = length_od - wall_thickness;
        cube([x, y, heigth +.1], center = true);
    }
    else
    {
        x = width_od;
        y = length_od;
        cube([x, y, heigth], center = true);
    }
}

//========= main ==========================================================
INTER_SPACE = 40; 

module make_cylinder(bRemove = false, heigth = straight_run_mm, dia = length_od)
{
    if (bRemove)
    {
        translate([0, 0,wall_thickness/2] )
        cylinder(h = heigth - wall_thickness   , d = dia - wall_thickness, center = false);
    }
    else
    { 
        cylinder(h = heigth , d = dia, center = false);
    } 
}
// ===========================================================================
RIM_THICK = 20;
RIM_HEIGTH = 10;

RIM_COLLAR_THICK = RIM_THICK + 14;
RIM_COLLAR_HEIGTH = RIM_HEIGTH + 25;

if (bBuildBody)
{
    difference()
    {  
        run_iterator()
        {
            
            //left end
            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            //translate([0, 0,  RIM_THICK/2 ])
            cylinder( d= length_od + RIM_HEIGTH, h= RIM_THICK, true); 
            
            //right end
            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            translate([0, 0,  (length_od ) * 2 + INTER_SPACE - RIM_THICK  ])
            cylinder( d= length_od + RIM_HEIGTH, h= RIM_THICK, true); 
            

            color("CYAN", .2)
            translate([ 11, length_od/2, 0])
            make_2D_template(heigth = 100);

            color("RED", .2)
            translate([ -11, (length_od/2 + length_od) + INTER_SPACE, 0])
            make_2D_template(heigth = 100);
               
            color("GREEN", .2)
            rotate([-90, 0, 0]) 
            make_cylinder( heigth = (length_od ) * 2 + INTER_SPACE, dia = length_od); 

            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            translate([0, 0,  length_od + INTER_SPACE/2 - RIM_THICK/2 ])
            make_cylinder( heigth = RIM_THICK, dia = length_od + RIM_HEIGTH); 

        }
        
        run_iterator()
        {
            color("PURPLE")
            translate([ 11, length_od/2, 1])
            make_2D_template(bRemove = true, heigth = 100);

            color("RED")
            translate([ -11, (length_od/2 + length_od) + INTER_SPACE, 1])
            make_2D_template(bRemove = true, heigth = 100);
               
            color("BLACK")
            rotate([-90, 0, 0]) 
            make_cylinder( bRemove = true, heigth = (length_od ) * 2 + INTER_SPACE, dia = length_od); 

            // screw holes
            color("BLACK")
            rotate([-90, 0, 0]) 
            translate([ 0, -length_od, -1])
            cylinder(h = (length_od  ) * 3 , d = 3.2);
        }
     }
}
// LOCK RIM LOCK RIM LOCK RIM LOCK RIM LOCK RIM LOCK RIM LOCK RIM LOCK RIM LOCK RIM 
if (bBuildLockRim)
{

    NUT_DIA = 4;            //mm
    EAR_DIA = NUT_DIA * 2;
    EAR_HEIGHT = 100;         //mm

    translate([0, 180, 0])
    difference()
    {  
        run_iterator()
        {
            color("PINK", .2)
            rotate([-90, 12, 0])
            translate([0, 0,  length_od + INTER_SPACE/2 - RIM_COLLAR_THICK/2 ])
            make_cylinder( heigth = RIM_COLLAR_THICK, dia = length_od + RIM_COLLAR_HEIGTH); 

            {   // make ears for bolt hold downs
                translate([length_od - RIM_COLLAR_HEIGTH + 6, length_od + INTER_SPACE/2, -EAR_HEIGHT/2 + 11  ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT* 8/10, d = EAR_DIA * 2); 
                    echo ("rotate = ", $t * 360);
                }

                translate([-(length_od - RIM_COLLAR_HEIGTH + 6) , length_od + INTER_SPACE/2, -EAR_HEIGHT/2 + 11 ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT * 8/10, d = EAR_DIA * 2); 
                    echo ("rotate = ", $t * 360);
                }
            }
            
        }
        
        run_iterator()
        {
        
            color("GREEN", .2)
            rotate([-90, 0, 0]) 
            make_cylinder( heigth = (length_od ) * 2 + INTER_SPACE, dia = length_od); 

            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            translate([0, 0,  length_od + INTER_SPACE/2 - RIM_THICK/2 ])
            make_cylinder( heigth = RIM_THICK +1, dia = length_od + RIM_HEIGTH); 

            {   // drill out ear holes
                translate([length_od - RIM_COLLAR_HEIGTH + 6, length_od + INTER_SPACE/2, -EAR_HEIGHT/2 ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT, d = EAR_DIA); 
                    echo ("rotate = ", $t * 360);
                }

                translate([-(length_od - RIM_COLLAR_HEIGTH + 6) , length_od + INTER_SPACE/2, -EAR_HEIGHT/2 ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT, d = EAR_DIA); 
                    echo ("rotate = ", $t * 360);
                }
            }
        
            color("BLACK")
            rotate([-90, 0, 0]) 
            make_cylinder( bRemove = true, heigth = (length_mm ) * 2 + INTER_SPACE, dia = length_mm); 
        }
     }
}
