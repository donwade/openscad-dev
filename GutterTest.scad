use <myTools.scad>
$fn=100;

WALL_THICK= 4;
MM=25.41;

X=3 * MM;
Y=2 * MM;


INTERIOR=[X, Y, 9];


module mainBOX()
{
        abox_punch(INTERIOR, +WALL_THICK, round_out=2, true);
}

mainBOX();
