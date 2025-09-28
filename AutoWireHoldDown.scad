use <myTools.scad>
$fn=100;


WIRE_PAIR= [ 7.25, 3.75, 12.0 ];
//SQUEEZE = [ 1.5, 1, 0];
SQUEEZE = [ 0, .3, 0];
REAL_PAIR = WIRE_PAIR - SQUEEZE;
MIDDLE=3;

OUTSIDE=[WIRE_PAIR.x * 2 + MIDDLE *8 ,
        WIRE_PAIR.y * 2, 
        WIRE_PAIR.z -1];
        
difference()
{
    cube (OUTSIDE, true);
    
    
    translate([ -MIDDLE/2 - REAL_PAIR.x/2, 0,0])
    #cube (REAL_PAIR, true);
    
    translate([ +MIDDLE/2 + REAL_PAIR.x/2, 0,0])
    #cube (REAL_PAIR, true);
    
    translate([ 0, WIRE_PAIR.y + REAL_PAIR.y/2 ,0])
    #cube ([WIRE_PAIR.x * 2 + MIDDLE *8 , WIRE_PAIR.y * 2, WIRE_PAIR.z -1], true);
}
