FONT="C059";
//FONT = "DejaVu Sans:style=Bold";
//FONT = "Neon:style=Normal";

FONT_SIZE = 74;
charSize = FONT_SIZE/36 * 25.4;   // one char height in MM

height = 10;
benchy_width = 5.50 * 25.4; // printer width
depth = 100;
PEN_THICK = 2.8;
echo ("benchy width = ", benchy_width, " mm");
//fm = fontmetrics(font=FONT, size=size);
//--------------------------------------------------------
module printWord(message)
{
    textlen = len(message);
    linear_extrude(height)
    {
        difference() {
            offset(r=PEN_THICK) {
                color("BLUE")
                text(message, size = FONT_SIZE, font = FONT, halign = "left", valign = "baseline", $fn = 100);
            }

            //offset(r=0) {
            //    text(message, size = FONT_SIZE, font = FONT, halign = "left", valign = "baseline", $fn = 100);
            //} 
        }
    }
}
//--------------------------------------------------------
module makeMesh(x,y)
{
    fat = .5;
    NUM_GRIDS = 7;
    echo ("x=", x , "y=", y);
    for (across = [ 0 : x/NUM_GRIDS: x ]) 
    {
        translate([ across, 0, 0 ])
            cube( [fat, y, fat]);
    }

    for (down = [ 0 : y/NUM_GRIDS: y ]) 
    {
        translate([ 0, down, 0 ])
            cube( [x, fat, fat]);
    }
}
//--------------------------------------------------------
module PrintChar(letter)
{
    valign = "baseline";
    halign = "left";
    f = "Freestyle Script";
    dir = "ltr";

    tm = textmetrics(letter, size=FONT_SIZE, valign=valign, halign=halign, font=FONT, direction=dir);
    echo("tm= ", tm);
    
    union()
    {
        printWord(letter);
       
        //translate([tm.position[0], tm.position[1], 0])
        //color("GREEN")
        
        //makeMesh(tm.size[0], tm.size[1]);
    }

}

//resize([ width/2, depth/2, height/2])  // test small print+
{
   
    // drop in the text
    translate( [ 0, FONT_SIZE/4 + 7 , 0])
    resize ([0, benchy_width, height], auto=true)
    {
        PrintChar("n");
    }
}


/*
difference() {
    linear_extrude(height) {
        square([box_width, box_height], center = true);
    }

    linear_extrude(height) {
        text(string, size = letter_size, font = font, halign = "center", valign = "center", $fn = 64);
    }
}
*/


/*
// rubber stamp (so it hast to look backwards
module mytext() {
    text(string, size = letter_size, font = font, halign = "center", valign = "center", $fn = 64);
}

module base() {
    linear_extrude(1) {
        square([box_width, box_height], center = true);
    }
}

module text_outline() {
    linear_extrude(height) {
        difference() {
            offset(r = -1) {
                mytext();
            }
            offset(r = -2) {
                mytext();
            }
        }
    } 
}


rotate([-180,0,0])
union() {   
    text_outline();
    translate([0,0,height])  base();
}
*/
