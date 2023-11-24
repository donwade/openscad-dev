//Parametric Pipe Connector
//Version 1.2, By DanielDC88

// Basic Parameters
First_pipe_outer_diameter = 20;
First_pipe_inner_diameter = 16;
Second_pipe_outer_diameter = 30;
Second_pipe_inner_diameter = 24;

// Advanced Parameters
Minimum_wall_thickness = 2; // The minimum thickness wall your printer can do.
Printer_x_y_tolerance = 0.00; // Tolerance space on either side for the tube
Extra_inner_length = 5; // Distance the inside of the tube adapter extends so you can tie something around the pipe to keep it on.
Seperation = 0; // Zero means twice the minimum width
Quality = 5; // Proportional to the overall diameter of the object.

// Drawing Module
module draw (aro,ari,aol,ail,bro,bri,bol,bil,w,t,x,s,q,i,o) {
    
    fn = 5*(max(aro,bro)+w);
        
    if (i) {
        if (o) {
            color("Red")
                rotate_extrude($fn = fn)
                    polygon(points=[
                        [bri-w,0],
                        [bri-w,bil+w],
                        [ari-w,ail+bil+2*w+s],
                        [ari,ail+bil+2*w+s],
                        [ari,bil+2*w+s],
                        [aro,bil+2*w+s],
                        [aro,bil+aol+2*w+s],
                        [aro+w,bil+aol+2*w+s],
                        [aro+w,bil+2*w+s],
                        [bro+w,bil-bol],
                        [bro,bil-bol],
                        [bro,bil],
                        [bri,bil],
                        [bri,0]
                    ]);
        }
        else {
            color("Yellow")
                rotate_extrude($fn = fn)
                    polygon(points=[
                        [bri-w,0],
                        [ari-w,bil+w+s], //changed this for i
                        [ari-w,ail+bil+2*w+s],
                        [ari,ail+bil+2*w+s],
                        [ari,bil+2*w+s],
                        [aro,bil+2*w+s],
                        [aro,bil+aol+2*w+s],
                        [aro+w,bil+aol+2*w+s],
                        [aro+w,bil+2*w+s],
                        [bro+w,bil-bol],
                        [bro,bil-bol],
                        [bro,bil],
                        [bri,bil],
                        [bri,0]
                    ]);
        };
    }
    else {
        if (o) {
            color("Lime")
                rotate_extrude($fn = fn)
                    polygon(points=[
                        [bri-w,0],
                        [bri-w,bil+w],
                        [ari-w,ail+bil+2*w+s],
                        [ari,ail+bil+2*w+s],
                        [ari,bil+2*w+s],
                        [aro,bil+2*w+s],
                        [aro,bil+aol+2*w+s],
                        [aro+w,bil+aol+2*w+s],
                        [bro+w,bil], //changed this for o
                        [bro+w,bil-bol],
                        [bro,bil-bol],
                        [bro,bil],
                        [bri,bil],
                        [bri,0]
                    ]);
        }
        else {
            color("Blue")
                rotate_extrude($fn = fn)
                    polygon(points=[
                        [bri-w,0],
                        [ari-w,bil+w+s], //changed this for i
                        [ari-w,ail+bil+2*w+s],
                        [ari,ail+bil+2*w+s],
                        [ari,bil+2*w+s],
                        [aro,bil+2*w+s],
                        [aro,bil+aol+2*w+s],
                        [aro+w,bil+aol+2*w+s],
                        [bro+w,bil], //changed this for o
                        [bro+w,bil-bol],
                        [bro,bil-bol],
                        [bro,bil],
                        [bri,bil],
                        [bri,0]
                    ]);
        };
    };
    
};

// Internal Relationships
draw(
    Printer_x_y_tolerance+First_pipe_outer_diameter/2,
    -Printer_x_y_tolerance+First_pipe_inner_diameter/2,
    First_pipe_outer_diameter/2,
    First_pipe_outer_diameter/2+Extra_inner_length,
    Printer_x_y_tolerance+Second_pipe_outer_diameter/2,
    -Printer_x_y_tolerance+Second_pipe_inner_diameter/2,
    Second_pipe_outer_diameter/2,
    Second_pipe_outer_diameter/2+Extra_inner_length,
    Minimum_wall_thickness,
    Printer_x_y_tolerance,
    Extra_inner_length,
    Seperation,
    Quality,
    First_pipe_outer_diameter>=Second_pipe_outer_diameter,
    First_pipe_inner_diameter>=Second_pipe_inner_diameter
);