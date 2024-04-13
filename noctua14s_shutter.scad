
make_box = true;
make_gate = true;

window_outside = 150.0;  // as it fits in the window.

/* [Hidden] */
// physical dimensions measured on fan ---------------------------

fan_outside = 139.75;
fan_wall =    2.14;       // fan radius wall to straight wall
$fn=100;

fan_inside_diameter=fan_outside - fan_wall * 6;  // was 2 for true adapter.
fan_inside_radius = fan_inside_diameter/2;

fan_thickness = 25.21;
fan_hole2hole = 124.75;

fan_screw_crest_diameter = 4.95;
fan_screw_root_diameter = 3.81;

fudge = .0;


punch_thick = 10; // want to make a hole that is unquestioned....

// ---------------------------------------------------------------

/* [ Global ] */
adapter_heigth =   20; //45.23;



// make 4 "posts" about 0,0,0 offset by +/-x +/-y 
module posts(x,y,z,h,r)
{
    translate([x,y,z]){         // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([-x,y,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }   
    translate([-x,-y,z]){       // move post to this location
        cylinder(r = r, h = h); // make one post
    }
    translate([x,-y,z]){        // move post to this location
        cylinder(r = r, h = h); // make one post
    }    
}
GATE_LENGTH = fan_inside_diameter + 50;
GATE_WIDTH = fan_inside_diameter + 8;

if ( make_box == true )
{
    difference()
    {

        // plain box to hold everything
        union()
        {
            color("GREEN", .3)
            cube([window_outside, window_outside, adapter_heigth ], center=true);

            //punch out the screw holes
            posts(  
                x=fan_hole2hole/2,
                y=fan_hole2hole/2,
                z= 0,
                h= adapter_heigth, 
                r = fan_screw_root_diameter/2);
            
        }
        
        // punch out the fan pipe and screws
        union ()
        {
            translate([0, 0, +(adapter_heigth)/2 - punch_thick])
            {
            
               color("GREEN")
               cylinder( h=adapter_heigth + punch_thick*2, r= fan_inside_radius, center=true);
                
            }
            color("RED")
            translate([ -GATE_WIDTH/2, -GATE_WIDTH/2, -adapter_heigth/4 ])
            cube([GATE_WIDTH , GATE_WIDTH + 40 , adapter_heigth/2 ], center=false);
               
        }
    }
}

if (make_gate)
{
    color("RED")
    translate([ -GATE_WIDTH/2, -GATE_WIDTH/2, -adapter_heigth/4 ])
    {
        shrink = 1;
        thumb_hole_dia = 25;
        difference()
        {
            cube([GATE_WIDTH - shrink , GATE_LENGTH, adapter_heigth/2 - shrink ], center=false);
            translate([GATE_WIDTH/2,GATE_LENGTH - thumb_hole_dia *3/4, -punch_thick/2])
            cylinder(h = punch_thick *2, d = thumb_hole_dia);
            
        }
    }
}

echo (fan_outside);
echo(window_outside);


