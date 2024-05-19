$fn=60;

total_heigth= 30;
inside_core_dia= 5.2;
hypotheneus = sqrt((total_heigth  * total_heigth) * 2);

thick = 2;  // 3 is not flexible


module make_tube(){
    difference() {
        union() 
        {
            cylinder(h = total_heigth-.1, d= inside_core_dia + thick);
            //cube([total_heigth, total_heigth, total_heigth]);
            rotate( [0, 0, 90 ])
            translate([-inside_core_dia-3, 0, total_heigth/2])
            cylinder(h=total_heigth, d = inside_core_dia *4, $fn=3, center=true);
        }
        // punch out
        union() {
            color("RED", 1)

            color("BLUE", 1) 
            cylinder(h = total_heigth, d = inside_core_dia);
        }
    }
}

module make_snap_ring()
{
    inside = 4.72;
    outside = inside + 2;
    thick = .5;
    difference()
    {
        cylinder(d=outside,  h = thick);
        cylinder(d=inside, h = thick);
    }
}

module make_snap_rings()
{
    translate([ 0, 0, 5.45])
    make_snap_ring();
    
    translate([0,0, 10.45])
    make_snap_ring();
}

union()
{
    difference()
    {
        union()
        {
            color("GREEN", .2)
            make_tube();
            make_snap_rings();
        }
        
        // cut a slit along entire length of tube
        color("RED")
        translate([ 0, inside_core_dia/2 + 1, 0])
        rotate([ 0, 0, 45])
        cube([2, 2, total_heigth *2], true);
   }          
}