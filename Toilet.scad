use</home/dwade/openscad-dev/newMath.scad>;
$fn=100;
width = 25;
length = 50;

for(step =[0: 1 : 3])
{
    echo("step ", step);
    translate([(width +5) * step , 0, 0]) 
    SHIM(width, length, 2);
}

