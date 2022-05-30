$fn=100;

// constants for hex lifeforms
hex_sides = 6;
degrees_per_side = 360/hex_sides;
//echo ("degress_per_side  =", degrees_per_side);

function ac_flat(flat2corner) = (flat2corner/2 * cos(degrees_per_side/2)) * 2;
function flat2corner(af) =  (af) / cos(degrees_per_side/2); 



// test 
across_corners = 7/16;
across_flats = ac_flat(across_corners);

ax_flat = 1/2;
echo ("ax_flat = ", ax_flat);
echo ("ax_corn = ", flat2corner(ax_flat));


// across flats, across corners, driver size 
nut_head = [[ 3/16, flat2corner(3/6)],
            [ 1/4, flat2corner(1/4), 7/16],
            [ 5/16, flat2corner(5/16), 1/2],
            [ 3/8,  flat2corner(3/8), 37/64 ]
           ];
           
neck_dia=1;
xacross_flats=2;
xacross_corners = 3; 
xhead_height=4;
xthread_length=5;

//https://www.aftfasteners.com/hex-cap-screws-head-thread-dimensions-performance-mechanical-specs/
nut_head2 = [
// NECK     FLAT    CORNER               HEAD(h) THREAD(l)
  [1/4,	    7/16,	flat2corner(7/16),	 5/32,	1.000],
  [5/16,	1/2,	flat2corner(1/2 ),	 13/64,	1.125],
  [3/8,	    9/16,	flat2corner(9/16),	 15/64,	1.250],
  [7/16,	5/8,	flat2corner(5/8),	 9/32,	1.375],
  
  [1/2,	    3/4,	flat2corner(3/4),	 5/16,	1.500],
  [9/16,	13/16,	flat2corner(13/16),	 23/64,	1.625],
  [5/8,	    15/16,	flat2corner(15/16),	 25/64,	1.750],
  [3/4,	    1+1/8,	flat2corner(1+1/8),	 15/32,	2.000],

  [7/8,	    1+5/16,	flat2corner(1+5/16), 35/64,	2.250],
  [1,	    1+1/2,	flat2corner(1+1/2),	 39/64,	2.500],
  [1+1/8,   1+11/16,flat2corner(1+11/16),11/16,	2.750],
  [1+1/4,   1+7/8,	flat2corner(1+7/8),	 25/32,	3.000],

  [1+1/2,   2+1/4,	flat2corner(2+1/4),	 1+5/16,3.500]  ];        
  

for (nut = [1: 1: 13])
{
   echo ("NECK = ", nut_head2[nut][neck_dia]);
}  
  