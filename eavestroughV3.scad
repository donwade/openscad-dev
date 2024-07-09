use <myTools.scad>

$fn=100;
MM=25.4;
//MM=10;
FUDGE=2;

gutterPipe = [ 3 * MM + FUDGE, 2 * MM + FUDGE, 3.5 * MM];
THICK = 3;
APART = 30;
FIXED_COLLAR_HEIGTH = 15; // add extra diameter to main body
FIXED_COLLAR_WIDTH = 6; //7;

REMOVE_COLLAR_WIDTH = FIXED_COLLAR_WIDTH + 6;
REMOVE_COLLAR_HEIGTH = FIXED_COLLAR_HEIGTH + 6;

//------------------------------------------------------------
module primary()
{
    difference()
    {
        union()
        {
            // pipe 1
            color("PINK", .9)//
            translate([ 0, gutterPipe.y - THICK *2, 0])      
            abox(gutterPipe, +THICK, bHollow = true, bCentered = false); 

            //pipe 2
            color("GREEN", .9)//
            translate([ -(gutterPipe.x + APART), 0, ])      
            abox(gutterPipe, +THICK, bHollow = true, bCentered = false); 

            //cylinder
            color ("RED", .9)
            translate([ -(gutterPipe.x  + APART), gutterPipe.y, 0 ])      
            rotate([ 0, 90, 0])
            cylinder(d = gutterPipe.y *2, h = gutterPipe.x * 2 + APART + THICK *2 );

        }

        // punch time
        
        //cylinder
        color ("CYAN", .9)
        translate([ -(gutterPipe.x  + APART) + THICK, gutterPipe.y, 0 ])      
        rotate([ 0, 90, 0])
        #cylinder(d = gutterPipe.y *2 - THICK *2, h = gutterPipe.x * 2 + APART );
        
        // pipe 1
        color("PINK", .9)//
        translate([ 0, gutterPipe.y - THICK *2, 0])      
        abox_punch(gutterPipe, +THICK, bHollow = true, bCentered = false); 

        //pipe 2
        color("GREEN", .9)//
        translate([ -(gutterPipe.x + APART), 0, 0 ])      
        abox_punch(gutterPipe, +THICK, bHollow = true, bCentered = false); 
        
    }

    // add pipe stops.
    difference()
    {
        union()
        {
            // pipe stop 1
            color("BLUE", .9)//
            translate([ THICK , gutterPipe.y - THICK, +gutterPipe.z/4 ])      
            abox(gutterPipe - [ 0, 0, gutterPipe.z * 5/8], -THICK*2, bHollow = true, bCentered = false); 
                
            //pipe stop 2
            color("BLUE", .9)//
            translate([ -gutterPipe.x  - APART +THICK, THICK, +gutterPipe.z/4  ])      
            abox(gutterPipe- [ 0, 0, gutterPipe.z * 5/8], -THICK*2, bHollow = true, bCentered = false); 
        }
        
        //clean out inside cylinder (again)
        color ("CYAN", .9)
        translate([ -gutterPipe.x  - APART + THICK, gutterPipe.y, 0 ])      
        rotate([ 0, 90, 0])
        #cylinder(d = gutterPipe.y *2 - THICK *2, h = gutterPipe.x * 2 + APART );
    }    

    fixed_ring(_width=FIXED_COLLAR_WIDTH,
                _heigth=FIXED_COLLAR_HEIGTH,
                adjust = 0);

}

//-----------------------------------------------------------
module fixed_ring(adjust=0, _width=1, _heigth=1)
{    
    translate([ -APART/2 - THICK/2 - _width/2,
                gutterPipe.y, 0 ])      
                
    difference()
    {
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2 + _heigth + adjust,
                 h = _width + adjust );

        // punch out pipe (again);
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2,
                 h = _width );
    }
}
//------------------------------------------------------------
module ring_collar()
{
    // cut in half and glue in place
    bCollar = 0;
    collar_w = 5;
    collar_h = 10;
    LOOSEN = 1;

    
    // fixed on body pivot ring.
    color("GREY", .6)
    
    difference()
    {
        fixed_ring(_width=REMOVE_COLLAR_WIDTH,
                    _heigth=REMOVE_COLLAR_HEIGTH,
                    adjust = 2);

        fixed_ring(_width=FIXED_COLLAR_WIDTH,
                    _heigth=FIXED_COLLAR_HEIGTH,
                    adjust = 0);
    }

}
//------------------------------------------------------------

bCrossLeft = 0;
bCrossRight = 0;
bShowRing = 0;

if (! bCrossLeft && !bCrossRight && !bShowRing)
{
    difference()
    {
        union()
        {
            primary();
            ring_collar();
        }
            translate([-gutterPipe.x *1.7, gutterPipe.y - 2* THICK, -gutterPipe.z])
            cube([gutterPipe.x*3, gutterPipe.y*2, 100], center=false);
     }
}
else
{
    if (bCrossLeft)
    {
        difference()
        {
            primary();
            
            translate([-APART /2 + THICK, -gutterPipe.y, -gutterPipe.y - 10])
            cube(200);
        }
    }

    if (bCrossRight)
    {
        difference()
        {
            primary();

            translate([-APART /2 + THICK, -gutterPipe.y, -gutterPipe.y - 10])
            rotate([ 0, 0, 90])
            cube(200);
        }
    }

    if ( bShowRing || ( ! bCrossRight && ! bCrossLeft) )
    {
        ring_collar();
    }
}