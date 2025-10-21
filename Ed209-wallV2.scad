use <myTools.scad>
$fn=50;

THICK = 9 + 48 * 1.42;
RADIUS=10;
DRILL = 3 + .1;

REAL = [61, 81, 20]; //real dims
TWEAK = [ 3,3,0 ];
BACKER = REAL + TWEAK;

EARS = [200, 81, THICK];
HOLES = [ 42, 21, 0];

TAPCON_OD = (1/4) * 25.4;
TAPCON_ID = (3/16) * 25.4;

build_camera = false;

EAR_HOLE= build_camera ? TAPCON_OD +2 : TAPCON_ID;

if (build_camera)
{
  echo ("BUILDING CAMERA PART");
  echo ("BUILDING CAMERA PART");
  echo ("BUILDING CAMERA PART");
  echo ("BUILDING CAMERA PART");
}
else
{
    echo ("BUILDING TEMPLATE");
    echo ("BUILDING TEMPLATE");
    echo ("BUILDING TEMPLATE");
    echo ("BUILDING TEMPLATE");
}

// make ear hole NOT align on same axis
// (stop screws intersection) 
   
OFFSET= (4.25 * 25.4)/2 - HOLES.y - 6 -6;

INSIDE = BACKER - [ RADIUS, RADIUS, 0 ];

module make_backplate()
{
    difference()
    {
        //color("GREEN", .3)
        hull()
        {
            translate ([+BACKER.x/2 - RADIUS, +BACKER.y/2 - RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([+BACKER.x/2 - RADIUS, -BACKER.y/2 + RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([-BACKER.x/2 + RADIUS, +BACKER.y/2 - RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
            translate ([-BACKER.x/2 + RADIUS, -BACKER.y/2 + RADIUS, 0]) cylinder(r=RADIUS, h = THICK);
        }

        color("BLUE")
        translate([ 0, BACKER.y/4, -THICK/3])
        {
            #translate ([+HOLES.x/2, +HOLES.y/2, +THICK/2]) cylinder(d=DRILL, h = THICK);
            #translate ([+HOLES.x/2, -HOLES.y/2, +THICK/2]) cylinder(d=DRILL, h = THICK);
            #translate ([-HOLES.x/2, +HOLES.y/2, +THICK/2]) cylinder(d=DRILL, h = THICK);
            #translate ([-HOLES.x/2, -HOLES.y/2, +THICK/2]) cylinder(d=DRILL, h = THICK);
        }
    }
}

module make_post()
{
    translate([0, BACKER.y/2, 0])
    rotate( [90, 0, 0 ])
    cylinder(d=RADIUS, BACKER.y);
}


LEN1= (2.125 * 22.5);
//-----------------------------------------------------------------
module make_ear(dist = LEN1, mirror = 1)
{
    difference()
    {
        hull()
        {
            make_post();
            translate([-(dist - RADIUS) * mirror, 0, -dist + RADIUS ])
            make_post();
        }
     
    }            

}
//-----------------------------------------------------------------
module make_pierce(dist = LEN1, mirror = 1)
{
    //drill hole for an ear
    // offset holes in y so that can't intersect.
    translate([-(-dist/2 ) * mirror, 15 * mirror, -dist/2])
    {
        rotate([ 0, 45 * mirror, 0])
        #cylinder(d=EAR_HOLE, h=THICK*2);

        rotate([ 0, (45+180) * mirror, 0])
        #cylinder(d=EAR_HOLE, h=THICK*2);
   }     
}
//-----------------------------------------------------------------

difference()
{
    union()
    {
        make_backplate();

        //-----------------------------------------------------------------

        translate([0, 0, RADIUS -3])
        {
            make_ear(LEN1, -1);
            make_ear(LEN1, +1);
        }
        
        // add fillets.
        translate([ RADIUS*2 -3, 0, 0]) make_post();
        translate([-RADIUS*2 +3, 0, 0]) make_post();
    }
    
    make_pierce(LEN1);
    make_pierce(LEN1, -1);
}