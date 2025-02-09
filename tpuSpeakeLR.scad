use <myTools.scad>
$fn=100;

MINX=109;
MINY=90;
BOARDER=10;
BASEX=MINX + 2 *BOARDER;
BASEY=MINY + 2 *BOARDER;

SBASEX = BASEX * 1/2;
SBASEY = BASEY * 1/2;

THICK = 8;
KNURL=8;

difference()
{
    cube([BASEX, BASEY, THICK], true);
    translate([ 0, 0, THICK/3 ])
    cube([SBASEX, SBASEY, THICK], true);
    
    for ( x = [ -9: 1: + 9 ])
    {
        echo ("x= ", x)
        
        translate([0, x*KNURL , THICK/2+2])
        rotate([45, 0, 0])
        #cube([BASEX,KNURL,KNURL], true);
    }

    for ( x = [ -11: 1: + 11 ])
    {
        echo ("x= ", x)
        
        translate([x*KNURL, 0, THICK/2 +2.0])
        rotate([45, 0, 90])
        cube([BASEY,KNURL,KNURL], true);
    }    
} 

