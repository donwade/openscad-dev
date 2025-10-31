
screw_dist=40; // PCB hole spacing (square)
height=10; // peg height
peg_d=20; // peg diameter
screw_d=10; // hole diameter
tol=0.05; // used for CSG subtraction/addition
plate_th= 1;

module peg(action)
{
  if(action=="position")
  {
    for(r=[0:90:359])
      rotate([0,0,r])
        translate([screw_dist/2,screw_dist/2,0])
        {
         for(i=[0:$children-1])
           children(i); // do the shapes that come after us!
        }
  }
  else if(action=="add")
  {
    // main cylindrical body
    cylinder(r=peg_d/2,h=height);
    // with a tronconic base (bevel)
    cylinder(r1=peg_d/2+2,r2=peg_d/2,h=5);
  }
  else // "remove"
  {
    translate([0,0,-tol -plate_th]) // screw hole
      cylinder(r=screw_d/2,h=height+2*tol+plate_th); // through hole
  }
}

// Helper module: centered cube on (X,Y) but not on Z, like cylinder
module centered_cube(size)
{
  translate([-size[0]/2, -size[1]/2, 0])
    cube(size);
}

difference()
{
  union()
  {
    // Now call and build the four pegs
    peg("position")
      peg("add");

    color([0,0,1])
      translate([0,0,-plate_th])
        centered_cube([
          screw_dist+peg_d*2,
          screw_dist+peg_d*2,
          plate_th+tol]); // higher to avoid gaps with the pegs!
  }

  // And finally carve the pegs (all through the plate itself)
  peg("position")
    peg("remove");
}
