
//=================================================
WALL_THICK = 4;

//            D   H   TRANS         ROTATE   endcap endcap               
cylinder1 = [ 55, 66, [0,0,0],      [0,0,0],   0, 1 ]; // dia, len, translate[x,y,z]
cylinder2 = [ 20, 30, [100,0,10/2], [0,0,0],   1, 0 ]; // dia, len, translate[x,y,z]
cylinder3 = [ 55, 66, [-30,0,0],    [0,0,0],   0, 1 ]; // dia, len, translate[x,y,z]
cylinder4 = [ 20, 30, [-100,0,10/2],[0,-90,0], 0, 1 ]; // dia, len, translate[x,y,z]

cylinder5 = [ 55, 66, [ 0,30,0],     [0,0,0],   1, 0 ]; // dia, len, translate[x,y,z]
cylinder6 = [ 20, 30, [ 0,100, 10/2],[0,-90,0], 1, 0 ]; // dia, len, translate[x,y,z]
cylinder7 = [ 55, 66, [ 0,-30,0],    [0,0,0],   0, 1 ]; // dia, len, translate[x,y,z]
cylinder8 = [ 20, 30, [ 0,-100,10/2],[0,-90,0], 0, 1 ]; // dia, len, translate[x,y,z]

//             0              1              2       3    4
box1 = [ [ 10, 20, 30] , [  0, 0, 0 ], [ 0,  0, 0 ], 0, 0];
box2 = [ [ 10, 20, 30] , [ 15, 0, 0 ], [ 0,  0, 0 ], 1, 0];
box3 = [ [ 10, 20, 30] , [ 30, 0, 0 ], [ 0,  0, 0 ], 0, 1];
box4 = [ [ 10, 20, 30] , [ 45, 0, 0 ], [ 0,  0, 0 ], 1, 1];

CYLINDER_LIST = [cylinder1, cylinder2]; //, cylinder3, cylinder4, cylinder5, cylinder6, cylinder7, cylinder8 ]; 
BOX_LIST=[box1, box2, box3, box4]; //, box2];

module make_cubes(action, stuff)
{
    if (action == "BOM")
    {
        // for each work object, execute the cmd on the object
        // the command is specified on the line after this BOM caller
        for(i=[0:1:$children-1])
           children(i); // do the shapes that come after us!
    }
    
    else if (action == "ADD")
    {
        num_items =  len(BOX_LIST)-1;
        for ( item = [ 0: num_items ])
        {
            echo ("item = ", item);
            echo ("dims = ", BOX_LIST[item][0]);

            rotate( [ 0, 90, 0 ])           // axis start on x axis

            rotate( BOX_LIST[item][2]) // user override
            translate( BOX_LIST[item][1])
            
            if ($preview)
                %cube( BOX_LIST[item][0], center=true);
            else
                cube( BOX_LIST[item][0], center=true);
        }
        echo ("----- end adding ------");
    }
    else if (action == "REMOVE")
    {
        num_items =  len(BOX_LIST)-1;
        for ( item = [ 0: num_items ])
        {
           echo ("rmv -------- #", item);
           
            newW = (BOX_LIST[item][3] + BOX_LIST[item][4]) * WALL_THICK;

            echo ("item = ", item);
            echo ("x = ", BOX_LIST[item].x);
            echo ("endcapL = ",BOX_LIST[item][3]);
            echo ("endcapR = ",BOX_LIST[item][4]);
            echo ("newW = ", newW);
           
            // div 2, we are working with centered items.
            bump = ((BOX_LIST[item][3] - BOX_LIST[item][4]) * WALL_THICK)/2;
            echo ("bump = ", bump);

            if ($preview)
            {
                // apply encap walls 
                translate ([ bump/2, 0, 0]) // remember were on center /2 
                // start cylinder on x-axis
                rotate( [ 0, 90, 0 ])      

                // now do user stuff
                rotate( BOX_LIST[item][2]) // user override
                translate( BOX_LIST[item][1])
                
                #cube( [BOX_LIST[item][0].x - WALL_THICK, 
                       BOX_LIST[item][0].y - WALL_THICK,
                       BOX_LIST[item][0].z - newW/2],
                       center=true);
            }
            else
            {
                // apply encap walls 
                translate ([ bump/2, 0, 0]) // remember were on center /2 
                // start cylinder on x-axis
                rotate( [ 0, 90, 0 ])      

                // now do user stuff
                rotate( BOX_LIST[item][2]) // user override
                translate( BOX_LIST[item][1])
                
                cube( [BOX_LIST[item][0].x - WALL_THICK, 
                       BOX_LIST[item][0].y - WALL_THICK,
                       BOX_LIST[item][0].z - newW/2],
                       center=true);
            }
        }
    }
    else
        assert(0);   
}
//---------------------------------------------------------------------------    
module make_cylinders(action, stuff)
{
    if (action == "BOM")
    {
        // for each work object, execute the cmd on the object
        // the command is specified on the line after this BOM caller
        for(i=[0:1:$children-1])
           children(i); // do the shapes that come after us!
    }
    
    else if (action == "ADD")
    {
        num_items =  len(CYLINDER_LIST)-1;
        for ( item = [ 0: num_items ])
        {
            height =  CYLINDER_LIST[item][1];
            echo ("item = ", item);
            echo ("dia = ", CYLINDER_LIST[item][0], "height = ", CYLINDER_LIST[item][1]);

            rotate( [ 0, 90, 0 ])           // axis start on x axis

            rotate( CYLINDER_LIST[item][3]) // user override
            translate( CYLINDER_LIST[item][2])
            
            #cylinder( d= CYLINDER_LIST[item][0], h = height, center=true);
            
        }
        echo ("----- end adding ------");
    }
    else if (action == "REMOVE")
    {
        num_items =  len(CYLINDER_LIST)-1;
        for ( item = [ 0: num_items ])
        {
           echo ("rmv -------- #", item);
           
           height =   CYLINDER_LIST[item][1] 
                     - (CYLINDER_LIST[item][4] + CYLINDER_LIST[item][5]) * WALL_THICK;
            echo ("item = ", item);
            echo ("dia = ", CYLINDER_LIST[item][0], "height = ", CYLINDER_LIST[item][1]);
            echo ("endcapL = ",CYLINDER_LIST[item][4]);
            echo ("endcapR = ",CYLINDER_LIST[item][5]);
            echo ("newH = ", height);
           
            bump = (CYLINDER_LIST[item][4] - CYLINDER_LIST[item][5]) * WALL_THICK;
            echo ("bump = ", bump);

            if ($preview)
            {
                // apply encap walls 
                translate ([ bump/2, 0, 0]) // remember were on center /2 
                // start cylinder on x-axis
                rotate( [ 0, 90, 0 ])      

                // now do user stuff
                rotate( CYLINDER_LIST[item][3]) // user override
                translate( CYLINDER_LIST[item][2])
                
                %cylinder( d= CYLINDER_LIST[item][0] - WALL_THICK * 2, h = height, center=true);
            }
            else
            {
                // apply encap walls 
                translate ([ bump/2, 0, 0]) // remember were on center /2 
                // start cylinder on x-axis
                rotate( [ 0, 90, 0 ])      

                // now do user stuff
                rotate( CYLINDER_LIST[item][3]) // user override
                translate( CYLINDER_LIST[item][2])
                
                #cylinder( d= CYLINDER_LIST[item][0] - WALL_THICK * 2, h = height, center=true);
            }
        }
    }
    else
        assert(0);   
}
//77777777777777777777777777


//------------------------------------------------------------

if (1)
{
    difference()
    {
      make_cubes("BOM", stuff=BOX_LIST)
        make_cubes("ADD", stuff=BOX_LIST);

      union()
      {
          make_cubes("BOM", stuff=BOX_LIST)
            make_cubes("REMOVE", stuff=BOX_LIST);
      }
    } 
}
else
{
    difference()
    {
      make_cylinders("BOM", stuff=CYLINDER_LIST)
        make_cylinders("ADD", stuff=CYLINDER_LIST);

      union()
      {
          make_cylinders("BOM", stuff=CYLINDER_LIST)
            make_cylinders("REMOVE", stuff=CYLINDER_LIST);
      }
    } 
}