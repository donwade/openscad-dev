$fn=150;

difference()
{
    union()
    {
        difference()
        {
            rotate([ 0, 30, 0])
            difference()
            {
                resize(newsize=[50,150,10]) sphere(r=10);
                rotate([ 0, 10, 0])
                translate([ 0, 0, 4])
                resize(newsize=[50,150,10]) sphere(r=10);
            }
            
            translate([-10, 0, 0])
            rotate([0, 90, 0])
            cube([30,150, 20], center = true);
        }
        
        translate([-10, 0, 0])
        rotate([0, 90, 0])
        cube([30,150, 20], center = true);
    }

    
    translate([-15, 0, 0])
    rotate([0, 95, 0])
    cube([39,159, 29], center = true);

}