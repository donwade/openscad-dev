//https://github.com/adrianschlatter/threadlib
/*
Currently, threadlib knows these threads:

    Metric threads (coarse, fine, and super-fine pitches) M0.25 to M600.
    Unified Inch Screw Threads (UNC, UNF, UNEF, 4-UN, 6-UN, 8-UN, 12-UN, 16-UN, 20-UN, 28-UN, and 32-UN). All threads are class 2 threads.
    BSP parallel thread G1/16 to G6. All threads are class A threads.
    PCO-1881 (PET-bottle thread)
*/

use <threadlib/threadlib.scad>

// make open thread, JUST a thread hanging in space
thread("G1/2-ext", turns=10);

// make a bolt with no head
translate([20,0,0])
bolt("M7", turns=12, higbee_arc=30);

// make a nut
translate([40,0,0])
nut("M12x0.5", turns=10, Douter=16);

// *** DO NOTuse scad difference on thread to make a tapped hole
// it will not fit well according to the author 
// Use provided module 'tap' to tap a hole

translate([60,0,0])
difference() {
     cube (30, center=false);
     translate([15, 15, 0])
     #tap("G1/2", turns=20);
}