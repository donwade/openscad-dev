use <myTools.scad>

$fn=100;
MM=25.4;
//MM=10;
FUDGE=2;

gutterPipe = [ 3 * MM + FUDGE, 2 * MM + FUDGE, 3.5 * MM];
THICK = 3;
APART = 20;
FIXED_COLLAR_HEIGTH = 15; // add extra diameter to main body
FIXED_COLLAR_WIDTH = 6; //7;

REMOVE_COLLAR_WIDTH = FIXED_COLLAR_WIDTH + 6;
REMOVE_COLLAR_HEIGTH = FIXED_COLLAR_HEIGTH + 6;

//------------------------------------------------------------
module primary(yOffset = 0)
{
    difference()
    {
        union()
        {
            //pipe 2
            color("GREEN", .9)//
            translate([ 0, yOffset, 0 ])      
            abox(gutterPipe, +THICK, bHollow = true, bCentered = false); 

            //cylinder
            color ("RED", .9)
            translate([0, gutterPipe.y, 0 ])      
            rotate([ 0, 90, 0])
            cylinder(d = gutterPipe.y *2, 
                     h = gutterPipe.x + APART + THICK*2, center= false );

        }
        // punch time
        
        //cylinder
        color ("CYAN", .9)
        translate([ THICK, gutterPipe.y, 0 ])      
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2, 
                  h = gutterPipe.x + APART + THICK *2 );

        //pipe 2
        color("GREEN", .9)//
        translate([ 0, yOffset, 0 ])      
        abox_punch(gutterPipe, +THICK, bHollow = true, bCentered = false); 

    }

    // add pipe stops.
    difference()
    {
        union()
        {
            //pipe stop 2
            color("BLUE", .9)//
            translate([ THICK, THICK + yOffset, +gutterPipe.z/4  ])      
            abox(gutterPipe- [ 0, 0, gutterPipe.z * 5/8], -THICK*2, bHollow = true, bCentered = false); 
        }

        //clean out inside cylinder (again)
        color ("CYAN", .9)
        translate([ THICK , gutterPipe.y, 0 ])      
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2, 
                  h = gutterPipe.x + APART + THICK *5 );
    }
    
    translate([gutterPipe.x + APART + THICK *2,
               gutterPipe.y, 0])
    fixed_ring(_width=FIXED_COLLAR_WIDTH,
                _heigth=FIXED_COLLAR_HEIGTH,
                adjust = 0);

}

//-----------------------------------------------------------
module fixed_ring(adjust=0, _width=1, _heigth=1)
{    
    difference()
    {
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2 + _heigth + adjust,
                 h = _width + adjust );

        // punch out pipe (again);
        rotate([ 0, 90, 0])
        cylinder(d = gutterPipe.y *2 - THICK *2,
                 h = _width * 4 );

     }
}
//------------------------------------------------------------
module ring_collar()
{
    LOOSEN = 2;

    
    // fixed on body pivot ring.
    color("GREY", .6)
    translate([gutterPipe.x + APART + 40 ,
               gutterPipe.y, 0])
    difference()
    {
        fixed_ring(_width=REMOVE_COLLAR_WIDTH,
                    _heigth=REMOVE_COLLAR_HEIGTH,
                    adjust = LOOSEN);

        fixed_ring(_width=FIXED_COLLAR_WIDTH ,
                    _heigth=FIXED_COLLAR_HEIGTH,
                    adjust = 0);

        //cylinder
    }

    color("BROWN")
    translate([gutterPipe.x + APART + 40 + REMOVE_COLLAR_WIDTH - FIXED_COLLAR_WIDTH*2,
               gutterPipe.y, 0])
    mirror([ 1,0, 0])
    difference()
    {
        fixed_ring(_width=REMOVE_COLLAR_WIDTH,
                    _heigth=REMOVE_COLLAR_HEIGTH,
                    adjust = LOOSEN);

        fixed_ring(_width=FIXED_COLLAR_WIDTH ,
                    _heigth=FIXED_COLLAR_HEIGTH,
                    adjust = 0);

        //cylinder
    }

}
//------------------------------------------------------------
bCrossSection = false;

module make_main(yOffset = 0)
{
    translate([ 0, -gutterPipe.y, 0])
    difference()
    {
        union()
        {
            primary(yOffset);
            ring_collar();
        }
        if (bCrossSection)
        {
            translate([-gutterPipe.x/2, gutterPipe.y/2, -gutterPipe.z ])
            cube([gutterPipe.x*3, gutterPipe.y*2, 100], center=false);
        }
    }
}

make_main();

translate([ 0, 130 , 0])
make_main(gutterPipe.x/2 + THICK *2);
