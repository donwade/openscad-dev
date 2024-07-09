$fn=120;


MM=25.4;
DIA= 3 * MM;

CIRC_DIA= DIA * 2;
HEIGHT = 5/8 * MM;

//  ROOT  HEAD_DIA
SCREWS =[
    [0, 1/16, 	7/64  ],
    [1, 5/64,	9/64  ],
    [2, 3/32, 	5/32  ],
    [3, 3/32, 	3/16  ],
    [4, 7/64, 	13/64 ],
    [5, 1/8, 	15/64 ],
    [6, 9/64, 	17/64 ],
    [7, 5/32, 	9/32  ],
    [8, 5/32, 	5/16  ],
    [9, 11/64, 	11/32 ],
    [10,3/16, 	23/64 ]
];	

module Xcountersink(screw_number = 4, length_mm = 10)
{
    top_dia_mm = SCREWS[screw_number].z  * MM * 1.1;
    root_dia_mm = SCREWS[screw_number].y * MM;
    
    angle = 82; //iso
    angle2 = 180 -  angle/2  - 90;  // face to sink angle.
    
    deep_mm = (top_dia_mm /2) / tan(angle2);
    echo ("deep in = ", deep_mm, " ANGLE = ", angle2 );
    
    // face of screwhead level on plane [0,0,0]
    translate([ 0, 0, -deep_mm])
    {
        #cylinder(d2 = top_dia_mm, d1 = 0, h = deep_mm);
        echo ("**** root dia= ", SCREWS[screw_number]);
    }
     
    // if you sink it too far, make a nice hole above 
    #cylinder(d = top_dia_mm * 1.1,5);
    
    // make drill hole
    translate([ 0, 0, -length_mm])
    #cylinder(d = root_dia_mm * 1.1, h = length_mm);
}

difference()
{
    difference()
    {
        difference()
        {
            cylinder(h = HEIGHT, d = DIA, false);
         
            color("GREEN")
            translate([0, 0, + CIRC_DIA /2 + HEIGHT * 1/4  ])
            sphere(d = CIRC_DIA);
        }
        
        translate([0, 0,  2.5 ]) 
        {
            // tweak in place
            Xcountersink(10);
        }

        translate([2.5, -2.5,  4 ]) 
        {
            // tweak in place
            rotate([ 0, 1.4, 0])
            #cube([ DIA, 5, 20]);
        }
        
    }
    //cube ([DIA,DIA,DIA], false);
}