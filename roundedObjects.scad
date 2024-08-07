
// Title: rcube(), rcylinder() & torus()
// Author: Rene K. Mueller
// License: MIT License 2020
// Version: 0.0.2

RCUBE_FLATX = [false,true,true];
RCUBE_FLATY = [true,false,true];
RCUBE_FLATZ = [true,true,false];
RCUBE_FLATBOTTOM = [false,false,false,false,true,true,true,true];
RCUBE_FLATTOP = [true,true,true,true,false,false,false,false];
RCUBE_FLATFRONT = [false,false,true,true,false,false,true,true];
RCUBE_FLATBACK = [true,true,false,false,true,true,false,false];
RCUBE_FLATLEFT = [false,true,true,false,false,true,true,false];
RCUBE_FLATRIGHT = [true,false,false,true,true,false,false,true];

FAST_RCUBE = 2222;

module rcube(a=1,r=0.1,rd=[true,true,true],center=false,$fn=32) {
    if(FAST_RCUBE != undef)
       cube(a);
    else {
       x = len(a) ? a[0] : a;
       y = len(a) ? a[1] : a;
       z = len(a) ? a[2] : a;
       rd = len(rd) ? rd : [rd,rd,rd];

          if((len(rd)==3 && rd[0] && rd[1] && rd[2]) || (len(a)==0 && rd)) // rd=[true,true,true] or true
             hull() {
                translate([r,r,r]) sphere(r);
                translate([x-r,r,r]) sphere(r);
                translate([x-r,y-r,r]) sphere(r);
                translate([r,y-r,r]) sphere(r);
                translate([r,r,z-r]) sphere(r);
                translate([x-r,r,z-r]) sphere(r);
                translate([x-r,y-r,z-r]) sphere(r);
                translate([r,y-r,z-r]) sphere(r);
             } 
          else                                                        // anything else
             hull() {
                translate([r,r,r]) rcube_prim(r,rd,0);
                translate([x-r,r,r]) rcube_prim(r,rd,1);
                translate([x-r,y-r,r]) rcube_prim(r,rd,2);
                translate([r,y-r,r]) rcube_prim(r,rd,3);
                translate([r,r,z-r]) rcube_prim(r,rd,4);
                translate([x-r,r,z-r]) rcube_prim(r,rd,5);
                translate([x-r,y-r,z-r]) rcube_prim(r,rd,6);
                translate([r,y-r,z-r]) rcube_prim(r,rd,7);
             }
    }
 } 

module rcube_prim(r,rd,i) {
    a = len(rd);
    if(a<=3) {
       if(a && rd[0] && rd[1] && rd[2]) 
          sphere(r);
       else if(a && rd[0] && rd[1])
          translate([0,0,-r]) cylinder(r=r,h=r*2);
       else if(a && rd[1] && rd[2])
          translate([-r,0,0]) rotate([0,90,0]) cylinder(r=r,h=r*2);
       else if(a && rd[0] && rd[2])
          translate([0,-r,0]) rotate([-90,0,0]) cylinder(r=r,h=r*2);
       else
          translate([-r,-r,-r]) cube(r*2);
    } else 
       if(rd[i]) 
          sphere(r);
       else 
          translate([-r,-r,-r]) cube(r*2);
 }

RCYLINDER_FLATBOTTOM = [false,true];
RCYLINDER_FLATTOP = [true,false];

module rcylinder(h=2,d=1,r=0.1,rd=[true,true],$fn=40) {
    if(FAST_RCYLINDER != undef)
       cylinder(d=d,h=h);
    else
       hull() { 
          translate([0,0,r]) 
             if(len(rd) && rd[0]) torus(do=d,di=r*2); else translate([0,0,-r]) cylinder(d=d,h=r);          
          translate([0,0,h-r]) 
             if(len(rd) && rd[1]) torus(do=d,di=r*2); else cylinder(d=d,h=r);
       }
 }

 module torus(do=2,di=0.1,a=360) {
    rotate_extrude(convexity=10,angle=a) {
       translate([do/2-di/2,0,0]) circle(d=di,$fn=20);
    }
 }
 
 
 //=========================================================

rcube();
translate([5,0,0]) rcube(0.75);
translate([10,0,0]) rcube([2,1,1],0.2);

translate([0,2,0]) rcube([2,1,1],0.2,false);
translate([5,2,0]) rcube([2,1,1],0.2,true);

translate([0,4,0]) rcube([2,1,1],0.2,RCUBE_FLATX);
translate([5,4,0]) rcube([2,1,1],0.2,RCUBE_FLATY);
translate([10,4,0]) rcube([2,1,1],0.2,RCUBE_FLATZ);

translate([0,6,0]) rcube([2,1,1],0.2,RCUBE_FLATBOTTOM);
translate([5,6,0]) rcube([2,1,1],0.2,RCUBE_FLATTOP);

translate([0,8,0]) rcube([2,1,1],0.2,RCUBE_FLATFRONT);
translate([5,8,0]) rcube([2,1,1],0.2,RCUBE_FLATBACK);

translate([0,10,0]) rcube([2,1,1],0.2,RCUBE_FLATLEFT);
translate([5,10,0]) rcube([2,1,1],0.2,RCUBE_FLATRIGHT);

translate([0+1,14,0]) rcylinder(3,1.5,0.2);
translate([3+1,14,0]) rcylinder(3,1.5,0.2,false);
translate([6+1,14,0]) rcylinder(3,1.5,0.2,RCYLINDER_FLATBOTTOM);
translate([9+1,14,0]) rcylinder(3,1.5,0.2,RCYLINDER_FLATTOP);

//The library code (I might later release it as a separate library):
