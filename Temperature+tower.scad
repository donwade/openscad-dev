/* [Temperature] */
// Maximum temperature
temp_max=230;           
// Minimum temperature
temp_min=190;         
// Increment between blocks
increment=10;           

/* [Layout] */
// Passing text
passing_text=false;     

maximumAtBottom=true;    

// Height of the taller cone
cone_height=5;          // Height of the cones for each block

/* [Hidden] */

block_height=10;

block_width_right=40;
block_width_left=20;
block_depth=5;

$fn = 90;

// Generate the temperature tower
module block(temp, base_z) {
    translate([0,base_z,0]){
        difference() {
            cube([20,block_height,block_depth], center=true);
            text_size=min(block_height,8);
            if (!passing_text)
                translate([0,0,block_depth-6])
                    linear_extrude(200)
                        text(str(temp), halign="center", valign="center", size=text_size, spacing=1);
            else 
                translate([0,0,-10])
                    linear_extrude(200)
                        text(str(temp), halign="center", valign="center", size=text_size, spacing=1);
        }
    }
    translate([block_width_right/2,base_z - block_height/2,0])
        cube([block_width_right,1,block_depth], center=true);
    translate([-block_width_left/4,base_z - block_height/2,0])
        cube([block_width_left/2,1,block_depth], center=true);
    translate([block_width_right/2,base_z + block_height/2,0])
        cube([block_width_right,1,block_depth], center=true);
    translate([-block_width_left/2,base_z + block_height/2,0])
        cube([block_width_left,1,block_depth], center=true);

    translate([block_width_right-5,base_z,0])
        difference() {
            cube([10,block_height,block_depth], center=true);
            cyl_radius=min((block_height/2)-0.5,4);
            cylinder(10,cyl_radius,cyl_radius,center=true);
        }
    
    translate([-10,block_height/2+base_z+0.5,-block_depth/2])
        linear_extrude(block_depth)
            polygon(points = [[0, 0], [0, -block_height-1], [-11, 0]]);
    
    cone_base=min(block_depth/2,10) - 1;
    translate([block_width_right/2.5,base_z - block_height/2 + cone_height,0])
        rotate([90,0,0])
            cylinder(h=cone_height,r1=0,r2=cone_base);

    translate([block_width_right/1.5,base_z - block_height/2 + cone_height/2,0])
        rotate([90,0,0])
            cylinder(h=cone_height/2,r1=0,r2=cone_base);
}

if (maximumAtBottom) 
    for (i = [ temp_max : -increment : temp_min]) {
        new_height=((temp_max-i)/increment)*block_height;
        rotate([90,0,0])
            block(i, new_height);
    }
else
    for (i = [ temp_min : increment : temp_max]) {
        new_height=-((temp_max-i)/increment)*block_height;
        rotate([90,0,0])
            block(i, new_height);
    }





