//outside dimensions of the box

 bBuildBody = 1;
 bBuildLockRim = 1;

straight_run = 2.5;  // make it a few feet ha ha

/* [Hidden] */
$fn= $preview ? 50 : 75;

length_outside = 80.24;
width_outside = 55.62;
dim_outside = [width_outside, length_outside];

pipe_outside_dia = length_outside;
pipe_outside_radius = pipe_outside_dia/2;


length_inside = 77.29;
width_inside = 52.7;
dim_inside = [ width_inside, length_inside];


ripple = (length_outside - length_inside)/2;

straight_run_mm = straight_run * 25.4;

//additional parameters
wall_thicknessX2 = 10;   // one wall is 5mm.
wall_thicknessX1 = wall_thicknessX2 /2;   

module mark() 
{
    if ($preview)  cylinder(h=10, r1 =2, r2=1);
}

//-----------------------------------------------------------------------------------

module run_iterator(bRemove = true)
{

    echo ("run_iterator : ", $children, " objects passed in, remove = ", bRemove);
    //difference()
    {
        //cube ([200,200,200]);
        
        for(i=[0:$children-1])
               children(i); // do the shapes that come after us!
               
    }
}
//-----------------------------------------------------------------------------------

SCALE_PCT= 0.3;

module make_male_box(from_dim = [1,1], bRemove = false, heigth = straight_run_mm) 
{

    translate([ 0, 0, -.1])  // move to start in xy plane

    if (bRemove)
    {
        start = from_dim;
        linear_extrude(height= heigth +.1, scale = 1 + SCALE_PCT)
        square(from_dim);
    }
    else
    {
        // taper goes up. start with fat bottom
        start = from_dim + [ -wall_thicknessX1, -wall_thicknessX1];
        linear_extrude(height= heigth + .1, scale =1 + SCALE_PCT)
        square(from_dim);
    }
}

//----------------------------------------------------------------------------------
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

        hull()
        {
            {
                color("RED")
                cube([from.x - wall_thicknessX1, from.y - wall_thicknessX1, .01], true );

                translate([0,0, h])
                color("BLUE")
                cube([to.x -wall_thicknessX1 , to.y - wall_thicknessX1, .01], true);
            }
        }
    }
}
//----------------------------------------------------------------------------------


module make_female_box(from_dim = [ -1, -1], scaler = 10.1233, bRemove = false, heigth = straight_run_mm) 
{
    
    translate([ 0, 0, -.1])  // move to start in xy plane
    
        echo ("FOAD");
        new = [from_dim.x + wall_thicknessX2, from_dim.y + wall_thicknessX2];
        make_trapezoid(from = from_dim, to = new, h = heigth);
 
}


//========= main ==========================================================
INTER_SPACE = 40; 

module make_cylinder(bRemove = false, heigth = straight_run_mm, dia = length_outside)
{
    if (bRemove)
    {
        translate([0, 0,wall_thicknessX2/2] )
        cylinder(h = heigth - wall_thicknessX2   , d = dia - wall_thicknessX2, center = false);
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


translate([0,-150, 0])
//make_trapezoid(from= [width_outside, length_outside], to = [width_outside +5, length_outside + 5], h =50);
make_trapezoid();




if (bBuildBody)
{
    difference()
    {  
        run_iterator(bRemove = false)
        {
            color("CYAN", .8)
            translate([ -pipe_outside_radius + width_inside/2, 
                        length_inside/2, pipe_outside_radius/2 ])
                        
            make_female_box( from_dim = dim_inside, scaler = 1.3, heigth = 100);

/*
            color("RED", .2)
            translate([ pipe_outside_radius - width_outside, length_outside + INTER_SPACE , 0])
            make_male_box(from_dim = [ width_outside, length_outside], heigth = 100);
*/               
            color("GREEN", .2)
            rotate([-90, 0, 0]) 
            make_cylinder( heigth = (length_outside ) * 2 + INTER_SPACE, dia = length_outside); 

            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            translate([0, 0,  length_outside + INTER_SPACE/2 - RIM_THICK/2 ])
            make_cylinder( heigth = RIM_THICK, dia = length_outside + RIM_HEIGTH); 

        }
        
        run_iterator(bRemove = true)
        {
       
            color("PURPLE")
            translate([ -pipe_outside_dia + width_inside + wall_thicknessX2,
                        length_inside/2,
                        pipe_outside_radius/2 ])
                        
            #make_female_box( from_dim = dim_inside,
                                scaler = 1.3, heigth = 100);

            /*
            color("RED")
            translate([ pipe_outside_radius - width_outside + wall_thicknessX1, length_outside + INTER_SPACE + wall_thicknessX1, 0])
            make_male_box(bRemove = true, heigth = 100);
 */           
            color("BLACK")
            rotate([-90, 0, 0]) 
            make_cylinder( bRemove = true, heigth = (length_outside ) * 2 + INTER_SPACE, dia = length_outside); 

            // screw holes
            color("BLACK")
            rotate([-90, 0, 0]) 
            translate([ 0, -length_outside, -1])
            cylinder(h = (length_outside  ) * 3 , d = (3/16) * 25.4);
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
            translate([0, 0,  length_outside + INTER_SPACE/2 - RIM_COLLAR_THICK/2 ])
            make_cylinder( heigth = RIM_COLLAR_THICK, dia = length_outside + RIM_COLLAR_HEIGTH); 

            {   // make ears for bolt hold downs
                translate([length_outside - RIM_COLLAR_HEIGTH + 6, length_outside + INTER_SPACE/2, -EAR_HEIGHT/2 + 11  ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT* 8/10, d = EAR_DIA * 2); 
                    echo ("rotate = ", $t * 360);
                }

                translate([-(length_outside - RIM_COLLAR_HEIGTH + 6) , length_outside + INTER_SPACE/2, -EAR_HEIGHT/2 + 11 ])
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
            make_cylinder( heigth = (length_outside ) * 2 + INTER_SPACE, dia = length_outside); 

            color("MAGENTA", .2)
            rotate([-90, 0, 0])
            translate([0, 0,  length_outside + INTER_SPACE/2 - RIM_THICK/2 ])
            make_cylinder( heigth = RIM_THICK +1, dia = length_outside + RIM_HEIGTH); 

            {   // drill out ear holes
                translate([length_outside - RIM_COLLAR_HEIGTH + 6, length_outside + INTER_SPACE/2, -EAR_HEIGHT/2 ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT, d = EAR_DIA); 
                    echo ("rotate = ", $t * 360);
                }

                translate([-(length_outside - RIM_COLLAR_HEIGTH + 6) , length_outside + INTER_SPACE/2, -EAR_HEIGHT/2 ])
                {

                    color("RED", .4)
                    rotate([ 0, 0, 0])
                
                    #cylinder(h = EAR_HEIGHT, d = EAR_DIA); 
                    echo ("rotate = ", $t * 360);
                }
            }
        
            color("BLACK")
            rotate([-90, 0, 0]) 
            make_cylinder( bRemove = true, heigth = (length_outside ) * 2 + INTER_SPACE, dia = length_outside); 
        }
     }
}

