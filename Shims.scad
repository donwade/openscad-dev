use <myTools.scad>

module emboss (string = "DEV", height = 10)
{
    font = "DejaVu Sans:style=Bold";
    letter_size = 3;

    textlen = len(string);

    // figure out the size of all the text string 
    box_width = letter_size*textlen*1.1;
    box_height = letter_size*1.5;

    difference() 
    {
        // make a box to contain the string
        linear_extrude(height) {
            square([box_width, box_height], center = true);
        }

        // etch out the text
        linear_extrude(height) {
            text(string, size = letter_size, font = font, halign = "center", valign = "center", $fn = 64);
        }
    }
}


punch = $preview ? 2: 0;

x = 10;
y = 10;

wall = +2;

max_across = 3;//4;
max_down = 3;  //3;

for (down = [0: 1: max_down])
for (across = [0: 1: max_across])
{
    z =  across/2 + (down /2) * 4;
    echo ("z= ", z);
    translate([ (across * (x + 3)), (down * (y + 3)) , 0])
    difference()
    {
        cube ([x, y, z], false);
        translate( [x/2, y/2, z -.3])
        emboss(string =str(z), height = .3);
    }
}