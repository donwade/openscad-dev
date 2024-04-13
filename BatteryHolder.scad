/* not used... but interesting
https://math.stackexchange.com/questions/2845543/z-intersection-of-cylinder-and-plane-base-on-angle-around-cylinder
*/

// pick one from below
BATTERY_TYPE = "AA"; // [ AAAA, AAA, AA, A, B, C, Sub-C, D, F, N, A23, A27, BA5800, 4SR44, 9V ]


NUM_ACROSS = 2;
NUM_DOWN = 1;
BATTERY_TILT = 30;
XRAY_ENABLED = false;


/* [Hidden] */
$fn=50;
DIAMETER_TWEAK_mm=1; // spec says 1mm deviation.

BATTERY_DIMENSIONS = [
["AAAA",    [8.3 ,  42.5,   0]],
["AAA",     [10.5 , 44.5,   0]],
["AA",      [14.5 , 50.5,   0]],
["A",       [17 ,   50,     0]],
["B",       [21.5 , 60,     0]],
["C",       [26.2 , 50,     0]],
["Sub-C",   [22.2 , 42.9,   0]],
["D",       [34.2 , 61.5,   0]],
["F",       [33 ,   91,     0]],
["N",       [12 ,   30.2,   0]],
["A23",     [10.3 , 28.5,   0]],
["A27",     [8.0 ,  28.2,   0]],
["BA5800",  [35.5 , 128.5,  0]],
["4SR44",   [13 ,   25.2,   0]],
["9V",      [26.5,  48.5,17.5]]    
];

//D: 48.5
//L: 26.5
//W: 17.5

SPACE_BETWEEN_BATTERIES = 2;
AWAY_FROM_WALL = SPACE_BETWEEN_BATTERIES * 2;

XRAY_ON = XRAY_ENABLED ?  1 : 0;

// a circle on an angle is an elipse. This will determine where the circle first
// touches the plane compared to where a vertical cyclinder whould touch the plane.
function ELIPTICAL_DIA (DIA) =   DIA  / cos(BATTERY_TILT);

//-------------------------------------------------------------------------
//https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Other_Language_Features#Index_values_return_as_list

// modules vs function
// modules cannot return values.
// modules may have multiple lines
// functions cannot have multiple lines
// functions have an "=" instead of "{}" like modules do
// functions are "one liners"
// test function behaviour by writing a module first.

// search for name in BATTERY_DIMENSIONS, name will be found in field 0 ",0"
// return the pair found '[0][0]'
// only interested in [1], (the right hand side of a pair)

module testSearchTable( name)
{
    // search(name) will FAIL !!!!!, it will take name, and search for each LETTER in name. UGH
    
    // use "search([name]  search(name)
    
    // search[name] treats name as a string  and searches for WORD 'name'
    
    echo (BATTERY_DIMENSIONS[search([name], BATTERY_DIMENSIONS,0)[0][0]]);
    foo = (BATTERY_DIMENSIONS[search([name], BATTERY_DIMENSIONS,0)[0][0]]);
    echo (" >>>>>>>> testSearchTable =",foo);
}
//-------------------------------------------------------------------------

function getBatteryDimensions( name) = 
    (BATTERY_DIMENSIONS[search([name], BATTERY_DIMENSIONS,0)[0][0]])[1];

function is9VBattery( name) = getBatteryDimensions(name)[2];
    
//==========================================================

module makeAbattery( name )
{
    data = getBatteryDimensions(name);
    is9V = is9VBattery(name);
    batteryLength = data[1];
    batteryDiameter = data[0];
    
    echo("makeAbattery ", name, "batteryLength =", batteryLength, "batteryDiameter =", batteryDiameter, "batteryExtra = ", is9V);
    testSearchTable(name);
    
    translate ( [ 0, 0, -batteryLength])
    {
        color("RED")
        if (is9V)
            cube( [(batteryDiameter + DIAMETER_TWEAK_mm), 
                  (is9V + DIAMETER_TWEAK_mm), 
                  batteryLength]);
        else
            cylinder(d = batteryDiameter + DIAMETER_TWEAK_mm, h = batteryLength);
        
    }
}
//==========================================================

module makeBank( type)
{

    echo ("search in table ", getBatteryDimensions(type));
    DIAMETER = getBatteryDimensions(type)[0] + DIAMETER_TWEAK_mm;
    is9V = is9VBattery(type);
    
    
    if (is9V) 
    {
        translate([AWAY_FROM_WALL, AWAY_FROM_WALL , 0]) 

        for (down = [ 0 : NUM_DOWN -1])
        {
            y = down * ELIPTICAL_DIA(DIAMETER + SPACE_BETWEEN_BATTERIES);
            
            translate([0, y, 0])
            for (across = [ 0 : NUM_ACROSS - 1 ])
            {
                x = across * (DIAMETER + SPACE_BETWEEN_BATTERIES) ;

                translate ( [ x, 0, 0 ])
                rotate([ BATTERY_TILT, 0, 0 ])
                makeAbattery(type);
            }
            
        }
    }
    else
    {
        translate([AWAY_FROM_WALL + DIAMETER/2, AWAY_FROM_WALL + DIAMETER/2, 0]) 

        for (down = [ 0 : NUM_DOWN -1])
        {
            y = down * ELIPTICAL_DIA(DIAMETER + SPACE_BETWEEN_BATTERIES);
            
            translate([0, y, 0])
            for (across = [ 0 : NUM_ACROSS - 1 ])
            {
                x = across * (DIAMETER + SPACE_BETWEEN_BATTERIES) ;

                translate ( [ x, 0, 0 ])
                rotate([ BATTERY_TILT, 0, 0 ])
                makeAbattery(type);
            }
            
        }
    }
    //echo (">>>>>>>>>>>>>>>>  DIA = ", DIAMETER, " ELIPTICAL_DIA = ", ELIPTICAL_DIA(DIAMETER));
    
}
//==========================================================

difference()
{

    BAT_DIA = getBatteryDimensions(BATTERY_TYPE)[0] ;
    BAT_LEN = getBatteryDimensions(BATTERY_TYPE)[1];
    BAT_9V = getBatteryDimensions(BATTERY_TYPE)[2];
    
    
    Xbox = BAT_9V ?
        (2 - XRAY_ON) * AWAY_FROM_WALL  + (NUM_ACROSS - XRAY_ON * .5) * (BAT_DIA + DIAMETER_TWEAK_mm +  SPACE_BETWEEN_BATTERIES ) :
        (2 - XRAY_ON) * AWAY_FROM_WALL  + (NUM_ACROSS - XRAY_ON * .5) * (BAT_DIA + DIAMETER_TWEAK_mm +  SPACE_BETWEEN_BATTERIES );
        
    Ybox =  BAT_9V ?
        2 * AWAY_FROM_WALL + (NUM_DOWN) * (BAT_DIA + SPACE_BETWEEN_BATTERIES + DIAMETER_TWEAK_mm ) + BAT_LEN * sin(BATTERY_TILT):
        2 * AWAY_FROM_WALL + (NUM_DOWN) * (BAT_DIA + SPACE_BETWEEN_BATTERIES + DIAMETER_TWEAK_mm ) + BAT_LEN * sin(BATTERY_TILT) ;
    
    echo ("X box = ", Xbox);
    echo ("Y box = ", Ybox);
    
    BOX_DEPTH = BAT_LEN * 1.05 * cos(BATTERY_TILT);
    
    translate ([ 0, 0, -BOX_DEPTH -7])
    color("GREEN", .3)
    cube( [ Xbox, Ybox , BOX_DEPTH-10]);

    makeBank(BATTERY_TYPE);
}
