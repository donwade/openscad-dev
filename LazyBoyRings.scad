use <myTools.scad>
$fn=50;

function MM(in)= in * 25.4; 
function IN(mm)= mm/25.4;

DIA_OUT= 84; //MM((3 + 1/4));

HEIGHT= MM(1/4);
THICK = MM(1/8);
AIR_GAP = 2; //THICK/2;

assert(THICK > AIR_GAP, "not good");

DIA_IN = MM(2 + 5/8);

module make_rings(start)
{
    for ( x = [ start: -THICK: DIA_IN])
    {
        union()
        {
            echo ("-----------------");
            echo ("dia =", IN(x) );
                tube(d = x, thick = -AIR_GAP/2, l = HEIGHT);
        } 
    }
}

make_rings(DIA_OUT);
translate([DIA_OUT+3 , 0, 0])
make_rings(DIA_OUT - THICK/2);


