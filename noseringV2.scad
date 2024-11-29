use <myTools.scad>
$fn=50;

INSIDE = [ 29.62, 25-1, 50];
THICK = 2;

//---------------------------------------------------------

module make_torroid( dia = 10)
{
    rotate_extrude(convexity = 10) // num segements
    translate([dia/2 - THICK/2, 0, 0])
    circle(d = THICK);
}
//---------------------------------------------------------

module stack_torroids( dia = 10, L = 10)
{
    //hull()
    {
        for ( H = [1: THICK/4: L] )
        {
            echo ( "H= ", H);
            translate([0, 0, H])
            make_torroid (dia);
        } 
    }
}
//---------------------------------------------------------

FROM=16;
TO=19;
color("GREEN")

difference()
{
    translate([ 0, 0, -THICK/2])
    for (DIA = [FROM:1:TO])
    {
        translate([(TO+3) * (TO-DIA), 0, 0])
        stack_torroids( dia = DIA); 
    }
    
    translate( [ 30, 0, - 5])
    #cube([100, 100, 10], true);
}
