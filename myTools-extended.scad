
$fn = $preview ? 50 : 120;
//=================================================

//            W   D   H   TRANS         ROTATE  btm top               
cylinder1 = [ +3, 20, 30, [0,0,0], [0,0,0],  0, 1 ]; // dia, len, translate[x,y,z]
//cylinder1 = [ +3, 20, 30, [0,0,0],      [0,0,0],  0, 0 ]; // dia, len, translate[x,y,z]
cylinder2 = [ -3, 20, 30, [0,40,0],     [0,0,0],  0, 1 ]; // dia, len, translate[x,y,z]

//cylinder2 = [ 4, 20, 30, [100,0,10/2], [0,0,0],   1, 0 ]; // dia, len, translate[x,y,z]
cylinder3 = [ 3, 55, 66, [-30,0,0],    [0,0,0],   0, 1 ]; // dia, len, translate[x,y,z]
cylinder4 = [ 3, 20, 30, [-100,0,10/2],[0,-90,0], 0, 1 ]; // dia, len, translate[x,y,z]

cylinder5 = [ 3, 55, 66, [ 0,30,0],     [0,0,0],   1, 0 ]; // dia, len, translate[x,y,z]

cylinder7 = [ 3, 20, 30, [ 0,100, 10/2],[0,-90,0], 1, 0 ]; // dia, len, translate[x,y,z]
cylinder8 = [ 3, 55, 66, [ 0,-30,0],    [0,0,0],   0, 1 ]; // dia, len, translate[x,y,z]
cylinder9 = [ 3, 30, [ 0,-100,10/2],[0,-90,0], 0, 1 ]; // dia, len, translate[x,y,z]

//       thick     dims           trans       rotate    left, right
box1 = [  3, [ 10, 20, 30] , [  30, 0, 0 ], [ 0, 0, 0 ],  0, 0];
box2 = [ -3, [ 10, 20, 30] , [  45, 0, 0 ], [ 0, 0, 0 ],  1, 0];
box3 = [ -3, [ 10, 20, 30] , [  60, 0, 0 ], [ 0, 0, 0 ],  0, 1];
box4 = [  3, [ 10, 20, 30] , [   0, 0, 0 ], [ 0, 0, 0 ],  1, 1];


CYLINDER_LIST =[cylinder1];//, cylinder2];// [cylinder1, cylinder2]; //, cylinder3, cylinder4, cylinder5, cylinder6, cylinder7, cylinder8 ]; 
BOX_LIST=[];
//, box2, box3]; //, box2, box3, box4]; //, box2];

module make_cubes(action, PARTS_LIST)
{
    BOX_THICK=0;
    BOX_DIMS=1;
    BOX_TRANS=2;
    BOX_ROTATE=3;
    BOX_ENDCAP_L=4;
    BOX_ENDCAP_R=5;
    
    echo ("DOIT (make_cubes): ", action);
        
    num_items =  len(PARTS_LIST);
    
    if (num_items)
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
            echo ("start add cubes ------------------");
            for ( item = [ 0: num_items -1 ])
            {
                echo ("add item ", item);
                THICK = PARTS_LIST[item][BOX_THICK] * 2;
                GLP1 = [ THICK, THICK , 0];  // z walls done later.
                
                // thick > 0 dims = inside dimension ... add walls on ADD
                // thick < 0 dims = outside dimension ... just use dim
                CUBE = (THICK > 0) ? PARTS_LIST[item][BOX_DIMS] + GLP1 
                                   : PARTS_LIST[item][BOX_DIMS];
                
                echo ("item = ", item);
                echo ("usr dim = ", PARTS_LIST[item][BOX_DIMS]);
                echo ("wall thick = ", THICK/2);
                echo ("new dims = ", CUBE);
                
                translate( PARTS_LIST[item][BOX_TRANS])
                rotate( PARTS_LIST[item][BOX_ROTATE]) // user override
     
                // if WIDTH>0 walls grow outwards from DIM
                if ($preview)
                    %cube( CUBE, center=true);
                else
                    cube( CUBE, center=true);
            }

            echo ("end add cubes ------------------");
            echo ("");
        }
        else if (action == "REMOVE")
        {
            echo ("start removing cubes ------------------");

            num_items =  len(PARTS_LIST)-1;
            for ( item = [ 0: num_items ])
            {
               echo ("remove cube ", item);

                THICK = PARTS_LIST[item][BOX_THICK];
                GLP1 = [ THICK *2 , THICK*2 , 0];  // z walls done later.

                //thick < 0 dims = outside dimension ... make walls
                //thick > 0 dims = inside dimension of hole
                CUBE = PARTS_LIST[item][BOX_DIMS]; 
               
                newW = (PARTS_LIST[item][BOX_ENDCAP_L] + PARTS_LIST[item][BOX_ENDCAP_R]) * THICK;

                echo ("item = ", item);
                echo ("endcapL = ",PARTS_LIST[item][BOX_ENDCAP_L]);
                echo ("endcapR = ",PARTS_LIST[item][BOX_ENDCAP_R]);
                echo ("newW = ", newW);
               
                // div 2, we are working with centered items.
                punch = ((PARTS_LIST[item][BOX_ENDCAP_R] - PARTS_LIST[item][BOX_ENDCAP_L]) * THICK);
                echo ("punch = ", punch);

                // thick>0 wall grows out from DIM 
                // thick<0 wall grow in from dim. 
                A_CUBE = (THICK > 0) ? CUBE : CUBE + GLP1;
                
                //NEW_CUBE = A_CUBE;
                NEW_CUBE = [ A_CUBE.x, A_CUBE.y, (punch ==0) ? A_CUBE.z: A_CUBE.z - abs(punch/4)];
                             
                echo ("remove: usr dims = ", PARTS_LIST[item][BOX_DIMS]);
                echo ("remove: final dims = ", NEW_CUBE);   
                    
                if ($preview)
                {
                    // apply encap walls 
                    translate ([ 0, 0, -punch/4,]) // remember were on center /2 

                    // now do user PARTS_LIST
                    translate( PARTS_LIST[item][BOX_TRANS])
                    rotate( PARTS_LIST[item][BOX_ROTATE]) // user override
                    
                    #cube( [NEW_CUBE.x, 
                            NEW_CUBE.y,
                            NEW_CUBE.z],
                           center=true);
                }
                else
                {
                    // apply encap walls 
                    translate ([ 0, 0, punch/4]) // remember were on center /2 

                    // now do user PARTS_LIST
                    translate( PARTS_LIST[item][BOX_TRANS])
                    rotate( PARTS_LIST[item][BOX_ROTATE]) // user override
                    
                    cube( [NEW_CUBE.x, 
                            NEW_CUBE.y,
                            NEW_CUBE.z],
                           center=true);
                }
            }
            echo ("end remove cubes ------------------");
        }
        else
            assert(0);   
    }
    else
    {
        echo ("NOTE: (make_cubes) no parts in parts list");
    }
    
}
//---------------------------------------------------------------------------    
module make_cylinders(action, PARTS_LIST)
{

//            D   H   TRANS         ROTATE   endcap endcap               
    CYL_THICK=0;
    CYL_DIA=1;
    CYL_HEIGHT=2;
    CYL_TRANS=3;
    CYL_ROTATE=4;
    CYL_ENDCAPL=5;
    CYL_ENDCAPR=6;

    echo ("DOIT (make_cylinders): ", action);
    
    num_items =  len(PARTS_LIST);
    if (num_items > 0)
    {
        if (action == "BOM")
        {
            // for each work object, execute the cmd on the object
            // the command is specified on the line after this PARTS_LIST caller
            for(i=[0:1:$children-1])
               children(i); // do the shapes that come after us!
        }
        
        else if (action == "ADD")
        {
            echo ("start add cylinders ------------------");
            for ( item = [ 0: num_items-1])
            {
                echo ("");
                echo ("add item ", item);
                THICK = PARTS_LIST[item][CYL_THICK];  // diameter speak.
                DIA = PARTS_LIST[item][CYL_DIA];

                newDIA = (THICK > 0) ? DIA + THICK*2 : DIA;
 
                height =  PARTS_LIST[item][CYL_HEIGHT];
                echo ("height = ", PARTS_LIST[item][CYL_HEIGHT]);
                echo ("thick = ", THICK);
                echo ("usr dia = ", PARTS_LIST[item][CYL_DIA]);
                echo ("newDIA = ", newDIA);

                translate( PARTS_LIST[item][CYL_TRANS])
                rotate( PARTS_LIST[item][CYL_ROTATE]) // user override
                #cylinder( d= newDIA, h = height, center=true);
                
            }
            echo ("----- end adding cylinders ------");
            echo ("");
        }
        else if (action == "REMOVE")
        {
            // make remove surface visable when previewing
            DEBUG = $preview ? 1 : 0;
            
            echo ("start remove cylinders ------------------");
            num_items =  len(PARTS_LIST)-1;
            for ( item = [ 0: num_items ])
            {
               echo ("remove cylinder -------- #", item);
             
               THICK = PARTS_LIST[item][CYL_THICK];  // diameter speak.
               
                echo ("item = ", item);
                echo ("endcapL = ",PARTS_LIST[item][CYL_ENDCAPL]);
                echo ("endcapR = ",PARTS_LIST[item][CYL_ENDCAPR]);

               // reduce height when punching by the wall thickness of each endcap
                height = DEBUG * .01 + PARTS_LIST[item][CYL_HEIGHT]
                         - (PARTS_LIST[item][CYL_ENDCAPL] + PARTS_LIST[item][CYL_ENDCAPR]) * abs(THICK);
                echo ("orig H = ", PARTS_LIST[item][CYL_HEIGHT]);
                echo ("new H = ", height);
               
                punch = (PARTS_LIST[item][CYL_ENDCAPL] - PARTS_LIST[item][CYL_ENDCAPR])* THICK/2;
                echo ("punch = ", punch,"\n");
             

                echo ("THICK = ", THICK);
                echo ("DIA = ", PARTS_LIST[item][CYL_DIA]);
                newDIA = (THICK > 0) ? PARTS_LIST[item][CYL_DIA]: PARTS_LIST[item][CYL_DIA] + THICK*2;
                echo ("newDIA = ", newDIA);
                
                if ($preview)
                {
                    // apply encap walls 
                    translate ([ 0, 0, -punch]) // remember were on center /2 

                    // now do user PARTS_LIST
                    translate( PARTS_LIST[item][CYL_TRANS])
                    rotate( PARTS_LIST[item][CYL_ROTATE]) // user override
                    
                    %cylinder( d= newDIA, h = height, center=true);
                }
                else
                {
                    // apply encap walls 
                    translate ([ 0, 0, -punch]) // remember were on center /2 

                    // now do user PARTS_LIST
                    translate( PARTS_LIST[item][CYL_TRANS])
                    rotate( PARTS_LIST[item][CYL_ROTATE]) // user override
                    
                    cylinder( d= newDIA, h = height, center=true);
                }
            }
            echo ("----- end removing cylinders ------\n");
        }
        else
            assert(0);   
    }
    else
    {
        echo ("NOTE: (make_cylinders) no parts in parts list");
    }
       
}
//77777777777777777777777777


//------------------------------------------------------------
module testx()
{
    difference()
    {
        union()
        {
            make_cubes("BOM", PARTS_LIST=BOX_LIST)
              make_cubes("ADD", PARTS_LIST=BOX_LIST);
              
            make_cylinders("BOM", PARTS_LIST=CYLINDER_LIST)
              make_cylinders("ADD", PARTS_LIST=CYLINDER_LIST);
        }
        
        union()
        {
          make_cubes("BOM", PARTS_LIST=BOX_LIST)
            make_cubes("REMOVE", PARTS_LIST=BOX_LIST);
            
          make_cylinders("BOM", PARTS_LIST=CYLINDER_LIST)
            make_cylinders("REMOVE", PARTS_LIST=CYLINDER_LIST);
          
          translate([0,0,-50]) cube([100,100,100]);
        }
    } 
}

testx();
