
$fn=100;
length = 64.68;
width = 27.21;
thick = 1.27;
mount_hole_center_x = 2.40;
mount_hold_center_y = 3.25;
mount_hole_diameter = 1.87;
punch_out = 15;

antenna_center_x = 14.34;
antenna_box_x = 6.31;
sma_male_dia_AF = 9;

small_adj = 1;

SD_card_thickness = 1.2;
SD_card_width = 11.13;

SD_carrier_thickness = 2.83;

USB_width = 7.7;
USB_thickness = 3.04;
USB_length = 5.74;

LCD_left = 24.8;
LCD_col = 24.74;
LCD_row = 16.2;
LCD_up = 4.0;
LCD_thick = 3.91;

difference()
{
    union()
    {
        cube([length, width, thick], center = false);
        
        // the rectangular box the antenna sits on
        translate([antenna_center_x - antenna_box_x/2 , 0, -11.0])
        cube([6.32, 6.32, 11.0], center = false);

        // the cylinder that comes out of the box
        translate([antenna_center_x, 0, -7.56])
        rotate([90,0,0])
        #cylinder(punch_out, d=sma_male_dia_AF , center = false);
        
        // SD card carrier
        translate([0, 2.1, thick])
        cube([6.45, 11.3, SD_carrier_thickness], center = false);
 
        // USB carrier
        translate([0, 16.8, thick])
        cube([USB_length, USB_width, USB_thickness]);
        
        // LCD 
        translate([LCD_left, LCD_up, thick])
        cube([LCD_col, LCD_row, LCD_thick], center = false); 
    }
    
    union()
    {
        //drilled holes
        translate([61.72, 3.47, -.001])
        cylinder(h=(thick + small_adj), d= mount_hole_diameter, center = false); 
  
        //drilled holes
        translate([61.72, 25.4, -.001])
        cylinder(h=(thick + small_adj), d= mount_hole_diameter, center = false); 
        
        //punch out reset button 
        translate([22.83, width, -2.10/2])
        rotate([-90, 0, 0])
        #cylinder(h=punch_out, d= mount_hole_diameter, center = false); 

        // SD card 
        translate([-10.1, 1.91, thick + SD_carrier_thickness - SD_card_thickness])  // SD card sits below top of carrier
        #cube([10.1, 11.2, SD_card_thickness], center = false);

    }
}

    //fake out reset button 
    translate([22.83, width, -2.10/2])
    rotate([90, 0, 0])
    #cube([-4.68, -2.56, -1], center = true);