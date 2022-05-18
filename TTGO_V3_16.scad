use </home/dwade/openscad-dev/newMath.scad>
$fn=100;
length = 64.68;
width = 27.21;
thick = 1.27;
mount_hole_center_x = 2.40;
mount_hold_center_y = 3.25;
mount_hole_diameter = 1.87;
punch_out = 30;

antenna_center_x = 14.34 - 1.53 ;
antenna_box_x = 11.60;
antenna_box_width = 6.19;
sma_male_dia_AF = 9;

small_adj = 1;

SD_card_thickness = 1.5; //1.2;
SD_card_width = 11.13;

SD_carrier_y = 2.18;
SD_carrier_width = 11.4;

SD_carrier_thickness = 3.21; //2.83;
SD_carrier_depth = 6.45;

SD_carrier2usb_y = 2.58;

//usb the part
USB_width = 7.7;
USB_thickness = 3.04;
USB_length = 5.74;
USB_y = width - 3.19 - USB_width;
USB_x = 0;  // on edge of board 

echo(USB_y);

USB_Adapter_width= 10.5 + 1;
USB_Adapter_thickness= 5.79 +1;
USB_Adapter_length = 20;

LCD_base_width = 33.27;
LCD_base_left = length - 9.78 - LCD_base_width ;
LCD_base_up = 4.35;
LCD_base_height = 18.48;
LCD_base_thick = 2.42;

LCD_across = 24.71;
LCD_left = length - 14.86 - LCD_across ;
LCD_height = 16.87;
LCD_bottom = 4.13 ;
LCD_thick = 3.91;


//88888888888888888888888888888888888888888888888888888888888
//makeTTGO(10,10,10, 0,90,0);
makeTTGO(0,0,0, 0,0,0);
//88888888888888888888888888888888888888888888888888888888888
//-----------------------------------------------------------------------

module makeTTGO( x, y, z, rx, ry, rz)
{
    rotate([rx, ry, rz])
    difference()
    {
        union()
        {
            translate([x,y,z])
            cube([length, width, thick], center = false);
            
            // the rectangular box the antenna sits on
            color("GREY")
            translate([x + antenna_box_x , y, z -6.0])
            cube([antenna_box_width, antenna_box_width, 6.0], center = false);

            // the cylinder that comes out of the box
            board_to_thread = 2.4;
            translate([x + antenna_box_x + antenna_box_width/2, y - antenna_box_width , z - board_to_thread - sma_male_dia_AF/2])
            rotate([90,0,0])
            CYLINDER(height=punch_out, radius = sma_male_dia_AF/2 , center = true);
            
            // SD card carrier
            translate([x, y + SD_carrier_y, z + thick ])
            CUBE([6.45, SD_carrier_width, SD_carrier_thickness], center = false);
     
            // USB carrier
            color("VIOLET", .5)
            translate([x + USB_x, y + USB_y, z+thick])
            CUBE([USB_length, USB_width, USB_thickness], center = false);
            
            // LCD_base 
            translate([x + LCD_base_left, y + LCD_base_up, z +thick]) // sit on board
            CUBE([LCD_base_width, LCD_base_height, LCD_base_thick], center = false); 

            // LCD 
            translate([x + LCD_left, y + LCD_bottom, z +thick + LCD_base_thick])  // lcd sits on base
            CUBE([LCD_across, LCD_height, LCD_thick], center = false); 

            // LCD punch
            color("GREEN",.5)
            translate([x + LCD_left, y + LCD_bottom, z +thick + LCD_base_thick + LCD_thick])  // punch sits on lcd that sits on base
            CUBE([LCD_across, LCD_height, LCD_thick * 4], center = false); 

            //virtual punch out reset button 
            color("Purple", 1)
            translate([x + 22.43, y + width- 3, z - 1.8/2])
            rotate([-90, 0, 0])
            cylinder(h=punch_out *2, d= mount_hole_diameter, center = false); 

            // virtual SD card 
            tweek = .2; // card does NOT plug into metal edge
            virtcard_length = 10.1;
            virtcard_width = 11.2;
            color("Fuchsia",.5 )
            translate([x -virtcard_length, y + SD_carrier_y, z +thick + SD_carrier_thickness - SD_card_thickness - tweek])  // SD card sits below top of carrier
            cube([virtcard_length, virtcard_width, SD_card_thickness], center = false);
            
            // virtual USB power adapter
            color("Cyan",.25)
            translate([x - USB_Adapter_length, y + USB_y + USB_width/2 - USB_Adapter_width/2, z+  -thick/2 - USB_width/2+ USB_Adapter_thickness/2])
            CUBE([USB_Adapter_length, USB_Adapter_width, USB_Adapter_thickness], center = false);

        }
        
        union()
        {
            //drilled holes
            translate([x + 61.72, y + 3.47, z -.001])
            cylinder(h=(thick + small_adj), d= mount_hole_diameter, center = false); 
      
            //drilled holes
            translate([x + 61.72, y + 25.4, z -.001])
            cylinder(h=(thick + small_adj), d= mount_hole_diameter, center = false); 
            

        }
    }
}
//fake out reset button 
//#translate([x + 22.83, y + width, z - 2.10/2])
//#rotate([90, 0, 0])
//#cube([-4.68, -2.56, -1], center = true);}
