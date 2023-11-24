
//  somewhat rough OpenSCAD lithophane - scruss, 2019-10
// infile  = "479px-Muhammad_Ali_NYWTS.png";    // input image, PNG greyscale best
// infile  = "479px-Muhammad_Ali_NYWTS.png";    // input image, PNG greyscale best
// infile = "640x493-bw-brianna.png";
//infile = "640x480-bw-BriAndJon.png";
//infile = "320x240-bw-BriAndJon.png";
//infile = "640x853-bw-BriAlone.png";
//infile = "512x683-bw-BriAlone.png";
//infile = "480x640-bw-BriAlone.png";
infile = "640x493-bw-GRADE10.png";

 x_px    = 640;  // input image width,  pixels
 y_px    = 493;  // input image height, pixels
 z_min   = 0.8;  // minimum output thickness, mm
 z_max   = 3;    // maximum output thickness, mm
 y_size  = 50;   // output image height, mm
 // don't need to modify anything below here
 echo ("\n\nnumber of bits ", x_px, "x", y_px, " = ", x_px*y_px / 1000, "K bytes\n\n");
 translate([0, 0, z_max])
 scale([y_size / y_px, y_size / y_px, (z_max - z_min)/100])
 surface(file = infile, invert = true);
 cube([x_px * y_size / y_px, y_size, z_min]);