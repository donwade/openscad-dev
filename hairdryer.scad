$fn=200;

inside_h= 50;

inside_bottom_dia= 35.5;
inside_top_dia = 40.5;

inside_bottom_r1= inside_bottom_dia / 2;
inside_top_r1 = inside_top_dia / 2;
hypotheneus = sqrt((inside_h  * inside_h) * 2);

thick = 7;


module solid(){
    difference() {
        union() {
            cylinder(h = inside_h, r1= inside_bottom_r1+ thick , r2 = inside_top_r1 + thick);
            cube([inside_h, inside_h, inside_h]);
        }
        // punch out
        union() {
            color("RED", 1)
            rotate([ 0,0,45])
            translate([hypotheneus/2, -hypotheneus/2, 0] )
            cube([hypotheneus,hypotheneus, inside_h], false);
            
            color ("GREEN", 1)
            cylinder(h = inside_h, r1= inside_bottom_r1, r2 = inside_top_r1);
        }
    }
}


solid();