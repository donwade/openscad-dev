fan_outside = 139.75;
fan_wall =    2.14;       // radius to straight wall
$fn=100;
 
fan_inside_diameter=fan_outside - fan_wall * 2;
fan_inside_radius = fan_inside_diameter/2;

fan_thickness = 25.21;
fan_hole2hole = 124.75;
fan_screw_crest_diameter = 4.95;
fan_screw_root_diameter = 3.81;
fan_corner_radius = 6.34;

fudge = .0;
display_outside = 150.0;
box_outside = 146.9;
box_inside = 140.6;
box_thickness = box_outside - box_inside;
box_height =   10; //45.23;

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


difference()
{
    //translate([-display_outside/2, -fan_outside/2 , 0])
    cube([display_outside, fan_outside, box_height ], center=true);

    difference() 
    {
       
        // punch out the fan pipe and screws
        union ()
        {
        //translate([0, 0, -10])
        cylinder( h=box_height, r= fan_inside_radius, center=true);
        
        // punch out the screw holes
         posts(  
            x=fan_hole2hole/2,
            y=fan_hole2hole/2,
            z= 0,
            h= box_height+2, //fan_thickness+1,
            r = fan_screw_root_diameter/2);
            

        }
    }
}

track_depth = 12;
track_width = box_thickness;   
//track_width = box_thickness;

echo (fan_outside)
echo (box_inside)
echo(display_outside)
translate([box_inside/2 -track_width , -fan_outside/2 - track_depth  ,  0])   
#cube([ track_width, track_depth, box_height], center=false);   

translate([-box_inside/2 , -fan_outside/2 - track_depth ,  0])   
#cube([ track_width, track_depth, box_height], center=false);   


