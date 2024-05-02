
$fn=100;

dime_dia = 18;

battery18mm = 18.57;
dime_thick = 1.2;

big = dime_dia + 2;

/*
difference()
{
    cylinder(h = dime_thick *2, d= big);
    translate([0, 0, dime_thick/4])
    #cylinder(h = dime_thick *2 , d = dime_dia);

    translate([0, 0, dime_thick/2])
    cube([ dime_thick, big, dime_thick]);
}
*/

difference()
{
    cylinder(h = 20, d= battery18mm + 1);
    translate([0, 0, dime_thick/4])
    #cylinder(h = 20 , d = battery18mm +.2);

    translate([0, 0, dime_thick/2])
    cube([ dime_thick, big, dime_thick]);
}

