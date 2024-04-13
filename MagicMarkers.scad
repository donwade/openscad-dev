$fn=50;
PEN_DIA_TOP=12;
PEN_DIA_BOTTOM=10.25;

PEN_HEIGHT= 100; //40;

module make_pens()
{
    for (pen=[ 1 : 4])
    {
        location =(PEN_DIA_BOTTOM * 1.5 + PEN_DIA_BOTTOM/2) * pen;

        echo ("pen = ", pen, " location = ", location + PEN_DIA_BOTTOM/2); // max RHS
       
        translate ( [location, 0, 0 ])
        rotate( [ 20, 0, 0])
        cylinder(h = PEN_HEIGHT, r1 = PEN_DIA_BOTTOM/2, r2 = PEN_DIA_TOP/2);
        
        echo ("RHS = ", location + PEN_DIA_BOTTOM);
    }   
}

BOX_THICK = 25;
BOX_LENGTH = 92.5;
module make_box()
{
    translate([ 0, -BOX_THICK * 3/4, -5 ])
    color("GREEN", .3)
    cube( [100, BOX_THICK , 50]);
}

make_pens();
make_box();