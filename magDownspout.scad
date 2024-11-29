$fn=100;

MM=25.4;
PCT = 3;

magnet= [60, 9.9, 2.75];

vertical_height = 40;


//midpoint of pipe. Should have the correct value 
target_vertical_x = 3.174 * MM;
target_vertical_y = 2.384 * MM;

vertical_bottom_x = target_vertical_x * ((100 - PCT)/100);
vertical_bottom_y = target_vertical_y * ((100 - PCT)/100);

vertical_top_x = target_vertical_x * (1 + PCT/100);
vertical_top_y = target_vertical_y * (1 + PCT/100);


echo ("x =", vertical_top_x, " < ", target_vertical_x, " < ", vertical_bottom_x);  
echo ("y =", vertical_top_y, " < ", target_vertical_y, " < ", vertical_bottom_y);  


module tapered_rectangle(fat = 0, bottom_tweak =1, top_tweak = 1)
{
    color("RED",.5)
    cube([ vertical_bottom_x + fat * bottom_tweak, vertical_bottom_y + fat * bottom_tweak, .1], true);

    
    //color("PINK")
    //translate([0, 0, vertical_height/2])
    //cube([ target_vertical_x + fat, target_vertical_y + fat, .1], true);

    
    color("GREEN")
    translate([0, 0, vertical_height])
    cube([ vertical_top_x + fat * top_tweak, vertical_bottom_y + fat * top_tweak, .1], true);


    color("YELLOW", .1)
    hull()
    {
        cube([ vertical_bottom_x + fat * bottom_tweak, vertical_bottom_y + fat * bottom_tweak, .1], true);
        translate([0, 0, vertical_height])
        cube([ vertical_top_x + fat * top_tweak, vertical_bottom_y + fat * top_tweak, .1], true);
    }
}

BURY = 1.25;
DRILL = 1/8 * MM;

difference()
{
    // top is thinner, no magnet
    tapered_rectangle(magnet.y * 3, top_tweak = .5);  // top is thin
    tapered_rectangle(bottom_tweak = 1.1);            // bottom is fat (magnet)

    translate([0, vertical_bottom_y/2 + magnet.y * 3/4 , 
                magnet.z/2 + BURY])
    #cube (magnet, true);

    translate([0, -(vertical_bottom_y/2 + magnet.y * 3/4) , 
        magnet.z/2 + BURY])
    #cube (magnet, true);

    // drill holes
    translate([ 0, 0, vertical_height * 3/4])
    {
        rotate([ 90, 0, 0])
        cylinder(h = 100, d= DRILL, center = true);
        rotate([ 0, 90, 0])
        cylinder(h = 150, d= DRILL, center = true);
    }
    
}
