/*
 * Raspberry Pi3 case for Prusa MK3

 * Originally not intended for use with the Prusa MK3; I just wanted a openscad code base to work with to make future cases.
 * I have borrowed the standoff design and the supports at the ports from https://www.thingiverse.com/thing:1325370

 * PI Fan hole contributed by: Daniel Tanner https://www.thingiverse.com/cyfire/designs
 *
 */

/* [Main] */

// Which part to render
part = "print"; // [ lid: Lid, base: Base, both: Box, print: print ]

// Make slot for the camera cable
camera_slot = "false"; // [ true: Yes, false: No ]

// Make slot for the video cable
video_slot = "false"; // [ true: Yes, false: No ]

// Make slot for the gpio_connector (not implemented)
gpio_slot = "false"; // [ true: Yes, false: No ]

// Prusa i3 Mk3 mount
mk3_mount = "false"; // [ true: Yes, false: No ]

// Cover holes with single layer, helps some screw hole avoid need for supports, requires to be punched through afterwards ( thanks Angus for the tip )
hole_covers = "false"; // [ true: Yes, false: No ]

// PI Fan
pi_fan = "false"; // [ true: Yes, false: No]
// PI Fan size, only 2 sizes 25 = 25mm and 30 = 30mm
pi_fan_size = 25; // [ 25: 25, 30: 30 ]

thick_vert_wall  = 3;  // Thickness of outer walls
thick_horz_wall  = 3;  // Thickness of top and bottom

pi3_board_width = 56;
pi3_board_length = 85;
pi3_board_thickness = 1.4;



pi3_hole_offset = 3.5;      // 3mm screw holes equadistant from any side.

pi3_hole_x1 = pi3_hole_offset;
pi3_hole_y1 = pi3_hole_offset;

pi3_hole_x2 = pi3_board_width  - pi3_hole_offset;
pi3_hole_y2 = pi3_board_length - pi3_hole_offset;

_rpi_hole_l_offset = 58;

// the void above the pi3 board where hat is

pi3_tophat_height = 22.8 -8.7 ; // 11 for single? 22 for dual? Just guessing here
pi3_hat_width = 56.6;

pi3_diff_width = pi3_hat_width - pi3_board_width;  //really hat is fatter !

pi3_board2hat_space = 11;  // distance b/n comp side of pi3 and bottom side of hat board
pi3_hat_length = 64; // hat width is same as pi3.
pi3_hat_board_thick = 2;   // board thicknes + components

// This cannot be fiddle with too much as it will break the stereo jack hole
_split_offset = 10;

// so pi3 is an easy fit boards are slightly different sizes.
pi3_to_wall_space = 0.5 + (pi3_hat_width - pi3_board_width);

pi3_standoff_height = 4 - 1.2;  // don't mess with this as others may depend on this value?

pi3_homeX = thick_vert_wall + pi3_to_wall_space;  // zero zero point of pi3 card X direction
pi3_homeY = thick_vert_wall + pi3_to_wall_space;  // zero zero point of pi3 card Y direction
pi3_homeZ = pi3_standoff_height + thick_horz_wall; //zero zero point Z (aka where card sits on).

box_outside_length = thick_vert_wall * 2 + pi3_to_wall_space * 2 + pi3_board_length;
box_outside_width = thick_vert_wall *  2 + pi3_to_wall_space * 2 + pi3_board_width;

// referenced from underside of top lid.
pi3_hat_standoff_height = 4.5;

// two walls + one standoff + one board thickness + empty void above pcb and top wall.
box_outside_heigth = thick_horz_wall + 
                     pi3_standoff_height +
                     pi3_board_thickness + 
                     pi3_board2hat_space +
                     pi3_hat_board_thick +
                     pi3_hat_standoff_height + 
                     thick_horz_wall;

// all components sit on the pi board.
pi3__component_surface = [pi3_homeX, pi3_homeY, pi3_homeZ + pi3_board_thickness];    

// top plastic SURFACE of base , (the rpi sits a little bit above this).
base_floor = [thick_vert_wall, thick_vert_wall, thick_horz_wall]; //top face of bottom base


bolt_crest_diameter=1.9;
bolt_countersink =  bolt_crest_diameter *2;
bolt_length = 5.5;

/*

antenna_mount= 6.58;
antenna_fudgeX = 14.5;  //16.0; com'n they couldnt center 2 antennas on the board center? :(
antenna_center_X = antenna_fudgeX - antenna_mount / 2;

antenna_fudgeY = 9.36;
antenna_center_Y = antenna_fudgeY - antenna_mount / 2;
*/

antenna_sma_male = 6.29;
antenna_sma_female = 9.2 + 2;  // too tight. 

ant_left_y = 6.44;   // from the inside top wall
ant_left_x = 12.26;  // from the inide left wall

ant_right_y = 6.95;  // from the inside top wall
ant_right_x = 13.77; // from the inside right wall

$fn=60;

//base();
//lid();
//box();

show();



module pieSlice(degrees, radius, thick){
    // rotate a flat object 
    rotate_extrude(angle=degrees) square([radius,thick]);
}

module show() {
    if (part == "lid") {
        //rotate([0, 180, 0]) translate([1, 0, -box_outside_heigth]) lid();
        lid();
    } else if (part == "base") {
        color("CYAN") base();
    } else if (part == "print") {
        color("CYAN") base();
        rotate([0, 180, 0]) translate([10, 0, -box_outside_heigth]) lid();
    } else {
        color("CYAN") base();
        lid();
    }
}


module rpi() {
    difference() {
        union() {
            cube([pi3_board_width, pi3_board_length, pi3_board_thickness]);


            // SD card
            _sd_width = 11;
            _sd_depth = 3;
            translate([pi3_board_width/2-_sd_width/2, pi3_board_length-thick_vert_wall, -pi3_board_thickness-1])
                cube([_sd_width, _sd_depth + pi3_to_wall_space + thick_vert_wall, 1]);

            // USB 1
            //usb1  =  [[70   , 21.4 , 0] , [17.4 , 15.3  ,  17.4] , [0,    -2,     0] ,  [0,    4,  10  ]];
            // 14.7 is the outer edge,  the main module is 13.14
            translate([40.43, -2, pi3_board_thickness]) {
                usb(padding=0);
            }


            // USB 2
            //usb2  =  [[70   , 39   , 0] , [17.4 , 15.3  ,  17.4] , [0,    -2,     0] ,  [0,    4,  10  ]];
            translate([22.43, -2, pi3_board_thickness]) {
                usb(padding=0);
            }


            // Ethernet
            translate([2.5, -2, pi3_board_thickness])
                ether(padding=0);

            // Audio
            translate([0, 31, pi3_board_thickness])
                audio(padding=0);

            // HDMI
            translate([0, 45.75, pi3_board_thickness])
                hdmi(padding=0);

             // Micro USB
            translate([0, 70.5, pi3_board_thickness])
                musb(padding=0);

            // Camera
            translate([0, 38.6, pi3_board_thickness])
                cube([22.5, 2.95, 5.7]);

            // Video
            translate([pi3_board_width/2-22.5/2, 79.55, pi3_board_thickness])
                cube([22.5, 2.95, 5.7]);

       }


        // holes  (I can't find them)
        //translate([pi3_hole_x1, pi3_hole_y2, -1]) cylinder(r=2.75/2, h=pi3_board_thickness + 2);
        //translate([pi3_hole_x2, pi3_hole_y2, -1]) cylinder(r=2.75/2, h=pi3_board_thickness + 2);

        //translate([pi3_hole_x1, pi3_board_length - _rpi_hole_l_offset - 3.5, -1]) color("PURPLE")cylinder(r=2.75/2, h=pi3_board_thickness + 2);
        //translate([pi3_hole_x2, pi3_hole_y2 - _rpi_hole_l_offset, -1])            cylinder(r=2.75/2, h=pi3_board_thickness + 2);
    }
}

module usb(padding=0.2, extends=0.2) {
    _extra_width = (14.7-13.14);
    cube([13.14 + 2 * padding, 17.4 + 2 * padding, 15.3 + padding]);
    translate([-(14.7 + 2 * padding-13.14-2 * padding)/2, -extends + 0.2, -_extra_width/2]) cube([14.7 + 2 * padding, extends, 15.3 + padding + _extra_width]);
}

module ether(padding=0.2, extends=0) {
    translate([0, -extends, 0])
    cube([15.51 + 2 * padding, 21.45 + extends, 13.9 + padding]);
}

module audio(padding=0.4, extends=0, hole=true) {
    echo ("audio padding = ", padding, " extends = ", extends);
    difference() {
        union() {
            translate([0, 0, 3 ]) rotate([0, -90, 0]) cylinder(r=3 + padding, h=2 + extends);
            translate([0, -3, 0]) cube([11, 6, 6]);
        }
        if (hole) {
            translate([5, 0, 3]) rotate([0, -90, 0]) cylinder(r=1.5, h=11);
        }
    }
}

module hdmi() {
    difference() {
        union() {
            translate([1, 0, 0]) cube([10.7, 14.5, 6.4]);
            hull() {
                translate([-1, 0, 2]) cube([10.7, 14.5, 4.4]);
                translate([-1, 1, 1]) cube([10.7, 12.5, 5.4]);
            }
        }
        hull() {
            translate([-2, 0.5, 2.3]) cube([10.7, 13.5, 3.6]);
            translate([-2, 1.6, 1.5]) cube([10.7, 11.7, 2]);
        }
    }
}

module hdmi_hole(padding=0.6, extends=5, outer_padding=2) {
    union() {
        translate([-1-0.1, -padding, -padding])
            cube([10.7 + 0.1, 14.5 + padding * 2, 6.4 + padding * 2]);

        translate([-1-extends, -outer_padding, -outer_padding])
            cube([extends, 14.5 + outer_padding * 2, 6.4 + outer_padding * 2]);
    }
}

module musb() {
    difference() {
        union() {
            translate([1, 0, 0]) cube([5.7, 7.5, 3]);
            hull() {
                translate([-1, 0, 1]) cube([5.7, 7.5, 2]);
                translate([-1, 1, 0.5]) cube([5.7, 5.5, 2]);
            }
        }
        hull() {
            translate([-1.1, 0.2, 1.2]) cube([5.7, 7.1, 1.6]);
            translate([-1.1, 1.2, 0.7]) cube([5.7, 5.1, 2]);
        }
    }
}

module musb_hole(padding=0.6, extends=5, outer_padding=2) {
    union() {
        translate([-1-0.1, -padding, -padding])
            cube([5.7 + 0.1, 7.5 + padding * 2, 3 + padding * 2]);

        translate([-1-extends, -outer_padding, -outer_padding])
            cube([extends, 7.5 + outer_padding * 2, 3 + outer_padding * 2]);
    }
}


module box() {

    _sd_width = 12;
    _sd_depth = 3;
    _sd_inset = 4;

    difference() {

        // solid block of maximum dimensions possible
        cube([box_outside_width, box_outside_length, box_outside_heigth]);

        // cut out a cube in the shape of the 'pi card'
        translate(base_floor)  //move to inside x.y,z "walls" make cube to gut block above.
        cube([pi3_to_wall_space * 2 + pi3_board_width,   // cut cube in X slightly bigger than true pi   
                      pi3_to_wall_space * 2 + pi3_board_length,  // cut cube in Y slightly bigger than trup pi
                      box_outside_heigth - 2 * thick_horz_wall]); // cut cube in Z not including top and bottom faces.
/******
        NO CLUE
        difference() {
            translate(base_floor)  //move to inside x.y,z "walls" make cube to gut block above.
                cube([pi3_to_wall_space * 2 + pi3_board_width,   // cut cube in X slightly bigger than true pi   
                      pi3_to_wall_space * 2 + pi3_board_length,  // cut cube in Y slightly bigger than trup pi
                      box_outside_heigth - 2 * thick_horz_wall]); // cut cube in Z not including top and bottom faces.

            translate([0, thick_vert_wall, box_outside_heigth-thick_horz_wall])
            rotate([0, 90, 0])
            linear_extrude(height=box_outside_width)
                polygon([[0, 0], [0, (box_outside_heigth-_split_offset-thick_horz_wall) * 0.8], [box_outside_heigth-_split_offset-thick_horz_wall, 0]]);
        }
*/


        _hole_padding=0.2;

        // SD card slot
        // We assume the slot is "almost" centered
        translate([pi3_homeX + pi3_board_width/2 - _sd_width/2,  box_outside_length-thick_vert_wall-pi3_to_wall_space-_sd_inset, -1])
            cube([_sd_width, _sd_depth + pi3_to_wall_space + thick_vert_wall + _sd_inset + 1, pi3_homeZ + 1]);

        translate(pi3__component_surface) {

            // USB 1
            translate([40.43-_hole_padding/2, -2, 0]) {
                usb(padding=_hole_padding, extends=thick_vert_wall);
            }

            // USB 2
            translate([22.43-_hole_padding/2, -2, 0]) {
                usb(padding=_hole_padding, extends=thick_vert_wall);
            }

            // Ether
            _ether_padding = _hole_padding + 0.2;
            translate([2.5-_ether_padding/2, -2, 0])
                ether(padding=_ether_padding, extends=thick_vert_wall);

            // Audio
            translate([0, 31, 0])
                audio(padding=0.5, extends= thick_horz_wall , hole=false);

            // HDMI
            translate([0.1, 45.75, 0])
                hdmi_hole(extends=thick_vert_wall * 2);

            // Micro USB
            translate([0.1, 70.5, 0])
                musb_hole();

        }
        

        // Camera
        if (camera_slot == "true") {
            translate([pi3_homeX, pi3_homeY + 38.6, thick_horz_wall + pi3_tophat_height])
                rounded_slot(22.5, 2.95, 20);
        }

        if (video_slot == "true") {
            // Video
            translate([pi3_homeX + pi3_board_width/2-22.5/2, pi3_homeY + 79.55, thick_horz_wall + pi3_tophat_height])
                rounded_slot(22.5, 2.95, 20);
        }

        if (gpio_slot == "true") {
            translate([pi3_homeX + 49.9, pi3_homeY + 27, 5]) cube([5.1, 51, 20]);
        }

        // Cooling always
        translate([pi3_homeX + 16, pi3_homeY + 18, thick_horz_wall + pi3_tophat_height]) {
            translate([12, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
            translate([-6, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
            translate([0, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2, 20);
            translate([6, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
            translate([12, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
            
            if (gpio_slot == "true") {
               translate([24, 0, 0]) rotate([0, 0, 45]) roundeheadd_slot(22.5/2, 2.95, 20);
            } else {
               translate([18, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
               translate([24, 0, 0]) rotate([0, 0, 45]) rounded_slot(22.5, 2., 20);
            }

        }

        if (pi_fan == "true") {
            if (pi_fan_size == 25){
                translate([18, 50, 20]) 25mmFan();
            }
            if (pi_fan_size == 30) {
                translate([16, 48, 20]) 30mmFan();
            }
        } else {
            // Air cooling no fan
            translate([pi3_homeX + 14, pi3_homeY + 40, thick_horz_wall + pi3_tophat_height]) {
                translate([0, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                translate([6, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                translate([12, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                translate([18, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);

                if (gpio_slot == "true") {
                    translate([32, 0, 0]) rotate([0, 0, 125]) translate([22.5/2, 0, 0]) rounded_slot(22.5/2, 2.95, 20);
                } else {
                    translate([24, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                    translate([30, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                    translate([36, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                    translate([42, 0, 0]) rotate([0, 0, 125]) rounded_slot(15.5, 2., 20);
                }
            }

            // drop in the dual antennas
            translate ([ box_outside_width  - thick_horz_wall - ant_right_x,
                         box_outside_length - thick_horz_wall - ant_right_y, 
                         box_outside_heigth - thick_vert_wall - 3 ])
                    cylinder(h = 10, d =antenna_sma_female);
 
            translate ([                      thick_horz_wall + ant_left_x,
                         box_outside_length - thick_horz_wall - ant_left_y,
                         box_outside_heigth - thick_vert_wall - 3 ])
                    cylinder(h = 10, d =antenna_sma_female);

            // LED screen
            translate ([                     18.41 , 
                        box_outside_length - 30.33 ,
                        box_outside_heigth - thick_vert_wall - 3])
                    cube ([27.4 -1.6, 14, 30]);
        }   
    }
    /* debug
    // drop in the dual antennas
    translate ([ box_outside_width  - thick_horz_wall - ant_left_x,
                 box_outside_length - thick_horz_wall - ant_left_y, 
                 box_outside_heigth - thick_vert_wall ])
            cylinder(h = thick_vert_wall, d =antenna_sma_female);

    translate ([                      thick_horz_wall + ant_right_x,
                 box_outside_length - thick_horz_wall - ant_right_y,
                 box_outside_heigth - thick_vert_wall ])
            cylinder(h = thick_vert_wall, d =antenna_sma_female);
    */

    // SD card slot support (the one on the base)
    // We assume the slot is "almost" centered

    translate([pi3_homeX + pi3_board_width/2 - _sd_width/2,  box_outside_length-thick_vert_wall-pi3_to_wall_space-11-_sd_inset, 0])
        cube([_sd_width, 11, pi3_homeZ-2]);



}

module rounded_slot(l, t, h) {
    translate([t/2, t/2, 0])
    hull() {
        cylinder(r=t/2, h=h);
        translate([l-t, 0, 0]) cylinder(r=t/2, h=h);
    }
}


module lid_cut() {
    difference() {
        box();
        translate([-1, -1, _split_offset-200])
            cube([pi3_board_width * 2, pi3_board_length * 2, 200]);
    }
}


module lid() {

    _standoff_r=3.5;
    // Screw standoffs
    
    _height_start = pi3_homeZ + pi3_board_thickness + 0.5;
    _height = box_outside_heigth - _height_start;

    difference() {
        union() {
            lid_cut();

            // Flap out for the SD card
            _sd_width = 11;
            _sd_depth = 3;
            translate([pi3_homeX + pi3_board_width/2 - _sd_width/2,  pi3_homeY  + pi3_board_length, pi3_homeZ])
                cube([_sd_width, thick_vert_wall * 2, box_outside_heigth - pi3_homeZ ]);

            // Standoffs -----------------------------------
            translate([0, 0, pi3_homeZ + pi3_board_thickness + 0.5]) {
                translate([pi3_homeX + pi3_hole_offset, pi3_homeY + pi3_hole_y2, 0])
                {
                    hull() {
                        cylinder(r=_standoff_r, h=_height);
                        translate([-_standoff_r, pi3_hole_offset + pi3_to_wall_space-1, 0]) cube([_standoff_r * 2, 1, _height]);
                        translate([-pi3_hole_offset-pi3_to_wall_space, -_standoff_r, 0]) cube([1, _standoff_r * 2, _height]);
                        translate([-pi3_to_wall_space-pi3_hole_offset, 0, 0])  cube([pi3_to_wall_space + pi3_hole_offset, pi3_to_wall_space + pi3_hole_offset, _height]);
                    }
                }


                translate([pi3_homeX + pi3_hole_x2, pi3_homeY + pi3_hole_y2, 0])
                {
                    hull() {
                        cylinder(r=_standoff_r, h=_height);
                        translate([-_standoff_r, pi3_hole_offset + pi3_to_wall_space-1, 0]) cube([_standoff_r * 2, 1, _height]);
                        translate([pi3_hole_x1 + pi3_to_wall_space-1, -_standoff_r, 0]) cube([1, _standoff_r * 2, _height]);
                        translate([0, 0, 0])  cube([pi3_to_wall_space + pi3_hole_offset, pi3_to_wall_space + pi3_hole_offset, _height]);
                    }
                }

                translate([pi3_homeX + pi3_hole_offset, pi3_homeY + pi3_hole_y2-_rpi_hole_l_offset, 0])
                {
                    hull() {
                        cylinder(r=_standoff_r, h=_height);
                        translate([-pi3_hole_offset-pi3_to_wall_space, -_standoff_r, 0]) cube([1, _standoff_r * 2, _height]);
                    }
                }

                translate([pi3_homeX + pi3_hole_x2, pi3_homeY + pi3_hole_y2-_rpi_hole_l_offset, 0])
                {
                    hull() {
                        cylinder(r=_standoff_r, h=_height);
                        translate([pi3_hole_x1 + pi3_to_wall_space-1, -_standoff_r, 0]) cube([1, _standoff_r * 2, _height]);
                    }
                }

            }
            
            /* debug punch out for lid standoff
            translate([ thick_vert_wall - pi3_diff_width/2,  // ya hat is fat (small tweak)
                        box_outside_length - thick_vert_wall,
                        box_outside_heigth - thick_horz_wall -pi3_hat_standoff_height])
            rotate ([180, 0, 0 ])          
            color("RED", .5)
            
            cube( [ pi3_to_wall_space * 2 + pi3_hat_width,  // ya hat is fat 
                  pi3_to_wall_space * 2 + pi3_hat_length,
                  30 ]); // gut everything below the lid standoff. 
            */
        }
        // Standoffs build end -------------------------------------

        // Standoffs remove material start ----------------------------------
            // locate underside of top off box
            translate([ thick_vert_wall - pi3_diff_width/2,  // ya hat is fat (small tweak)
                        box_outside_length - thick_vert_wall,
                        box_outside_heigth - thick_horz_wall -pi3_hat_standoff_height])
            rotate ([180, 0, 0 ])          
            color("RED", .5)
            
            cube( [ pi3_to_wall_space * 2 + pi3_hat_width,  // ya hat is fat 
                  pi3_to_wall_space * 2 + pi3_hat_length,
                  30 ]); // gut everything below the lid standoff. 
                  
        // Standoffs remove end ----------------------------------
        
       
        // Screw holes

        translate([pi3_homeX, pi3_homeY, 0]) {
        
            translate([pi3_hole_x1, pi3_hole_y2, 0])
            {
               translate([0, 0, -1]) cylinder(d=bolt_crest_diameter, h=_height * 2);
               translate([0, 0, box_outside_heigth-3]) cylinder(d=bolt_countersink, bolt_length); // bolt head recess
            }

            translate([pi3_hole_x2, pi3_hole_y2, 0])
            {
                translate([0, 0, -1]) cylinder(d=bolt_crest_diameter, h=_height * 2);
                translate([0, 0, box_outside_heigth-3]) cylinder(d=bolt_countersink, bolt_length);
            }

            translate([pi3_hole_x1, pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
               translate([0, 0, -1]) cylinder(d=bolt_crest_diameter, h=_height * 2);
               translate([0, 0, box_outside_heigth-3]) cylinder(d=bolt_countersink, bolt_length);
            }

            translate([pi3_hole_x2, pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
                translate([0, 0, -1]) cylinder(d=bolt_crest_diameter, h=_height * 2);
                translate([0, 0, box_outside_heigth-3]) cylinder(d=bolt_countersink, bolt_length);
            }
        }


    }

    if (hole_covers == "true") {
        translate([pi3_homeX, pi3_homeY, box_outside_heigth-3]) {

            translate([pi3_hole_x1, pi3_hole_y2, 0])
            {
               cylinder(d=bolt_countersink + 0.1, h=0.2);
            }

            translate([pi3_hole_x2, pi3_hole_y2, 0])
            {
                cylinder(d=bolt_countersink + 0.1, h=0.2);
            }

            translate([pi3_hole_x1, pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
                cylinder(d=bolt_countersink + 0.1, h=0.2);
            }

            translate([pi3_hole_x2, pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
                cylinder(d=bolt_countersink + 0.1, h=0.2);
            }

        }
    }

}

module base_cut() {
    difference() {
        box();
        translate([-1, -1, _split_offset])
            cube([pi3_board_width * 2, pi3_board_length * 2, (pi3_tophat_height + pi3_homeZ) * 2]);
    }
}

module base() {

    difference() {

        union() {

            base_cut();

            _standoff_r=3.5;


            // Screw standoffs
            translate([pi3_homeX + pi3_hole_offset, pi3_homeY + pi3_hole_y2, 0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r, h=pi3_homeZ);
                        translate([-_standoff_r, pi3_hole_offset + pi3_to_wall_space-1, 0]) 
                            cube([_standoff_r * 2, 1, pi3_homeZ]);
                            
                        translate([-pi3_hole_offset-pi3_to_wall_space, -_standoff_r, 0]) 
                            cube([1, _standoff_r * 2, pi3_homeZ]);
                            
                        translate([-pi3_to_wall_space-pi3_hole_offset, 0, 0])  
                            cube([pi3_to_wall_space + pi3_hole_offset, pi3_to_wall_space + pi3_hole_offset, pi3_homeZ]);
                    }
                    translate([0, 0, thick_horz_wall]) cylinder(d=bolt_crest_diameter, h=pi3_homeZ);
                }
            }


            translate([pi3_homeX + pi3_hole_x2, pi3_homeY + pi3_hole_y2, 0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r, h=pi3_homeZ);
                        translate([-_standoff_r, pi3_hole_offset + pi3_to_wall_space-1, 0]) 
                            cube([_standoff_r * 2, 1, pi3_homeZ]);
                            
                        translate([pi3_hole_x1 + pi3_to_wall_space, -_standoff_r, 0]) 
                            cube([1, _standoff_r * 2, pi3_homeZ]);
                            
                        translate([0, 0, 0])  
                            cube([pi3_to_wall_space + pi3_hole_offset, pi3_to_wall_space + pi3_hole_offset, pi3_homeZ]);
                    }
                    translate([0, 0, thick_horz_wall]) cylinder(d=bolt_crest_diameter, h=pi3_homeZ);
                }
            }

            translate([pi3_homeX + pi3_hole_offset, pi3_homeY + pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r, h=pi3_homeZ);
                        translate([-pi3_hole_offset-pi3_to_wall_space, -_standoff_r, 0]) cube([1, _standoff_r * 2, pi3_homeZ]);
                    }
                    translate([0, 0, thick_horz_wall]) cylinder(d=bolt_crest_diameter, h=pi3_homeZ);
                }
            }

            translate([pi3_homeX + pi3_hole_x2, pi3_homeY + pi3_hole_y2-_rpi_hole_l_offset, 0])
            {
                difference() {
                    hull() {
                        cylinder(r=_standoff_r, h=pi3_homeZ);
                        translate([pi3_hole_x1 + pi3_to_wall_space, -_standoff_r, 0]) cube([1, _standoff_r * 2, pi3_homeZ]);
                    }
                    translate([0, 0, thick_horz_wall]) cylinder(d=bolt_crest_diameter, h=pi3_homeZ);
                }
            }
        }

        // Cut out for the SD card
        _sd_width = 12;
        _sd_depth = 3;
        translate([pi3_homeX + pi3_board_width/2 - _sd_width/2,  box_outside_length-thick_vert_wall-pi3_to_wall_space, 4])
            cube([_sd_width, _sd_depth + pi3_to_wall_space + thick_vert_wall + 1, pi3_homeZ + 1]);

    }


    if (mk3_mount == "true") {

        translate([box_outside_width, box_outside_length, 0])
        difference() {
            union() {
                rotate([0, -90, 0])
                linear_extrude(height=4)
                    polygon([[0, -1], [_split_offset, -1], [_split_offset, 0.5], [50, 0.5], [50, 20], [0, 20]]);

                linear_extrude(height=_split_offset)
                    polygon([[-24, -1], [-4, 20], [-4, 20-2], [-22, -1]]);
            }

            translate([-5, 10, 4]) rotate([0, 90, 0]) cylinder(r=1.5, h=6);
            translate([-20, 10, 4]) rotate([0, 90, 0]) cylinder(r=3, h=12);
            translate([-5, 10, 50-3]) rotate([0, 90, 0]) cylinder(r=1.5, h=6);

        }
    }

}

module 30mmFan(){
    translate([2, 2, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([26.5, 2, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([2, 24.5, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([26.5, 24.5, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([25.03/2, 25.03/2, 0])cylinder(r=25.03/2, h=5);//
}

module 25mmFan(){
    translate([2, 2, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([22, 2, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([2, 22.5, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([22, 22, 0])cylinder(r=1.5, h=5);// fan screw holes
    translate([12, 12, 0])cylinder(r=11.5, h=5);//
}


