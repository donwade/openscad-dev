$fn=60;

/*
  http://mathcentral.uregina.ca/QQ/database/QQ.09.09/h/darryl1.html
*/
C=90.5;
S=4.5;

HEIGHT = 18;
THICK = 2;

R=(4 * S * S + C * C)/(8 * S);
echo (" ");
echo ("value of R is ", R);

SHORT = R - S;
ANGLE = atan2( C/2, SHORT);

echo ("half angle =", ANGLE, " degrees");
echo (" ");

module first()
difference()
{
    cylinder(h = HEIGHT, r= R + THICK/2);
    cylinder(h = HEIGHT, r= R - THICK/2);
}

module grooved()
difference()
{
    cylinder(h = HEIGHT, r= R + THICK/4);
    cylinder(h = HEIGHT, r= R - THICK/4);
}

module cutter()
{
    color("GREEN")
    {
        translate([ -R *2, -R , 0 ])
        cube( [ R *2, R *2, HEIGHT * 2] );
        
        rotate([ 0, 0, ANGLE])
        cube( [ R *2, R *2, HEIGHT * 2] );

        color("RED")
        rotate([ 0, 0, -ANGLE])
        translate( [0, -R *2 , 0])
        cube( [ R *2, R *2, HEIGHT * 2] );
    }
}

_WIDE=7;
_UP=5;

module holder()
{
    color("BLUE")
    {
        union() {
            //translate ([0, -7/2, 7])
            //cube([R*2, 7 *2,  _UP]);

            translate ([0, -7/2, 5+ 3.88])
            cube([R*2, 7 *2,  _UP*10]);

            //translate ([0, -7/2, 5])
            //cube([R*2, 7 *2,  _UP*2]);
        }
    }
}

difference()
{
    difference()
    {
        union()
        {
            first();
            //holder(); //cutter();
        }
        translate([ 0, 0, 2])
        grooved();
    }
    cutter();
    holder();
}