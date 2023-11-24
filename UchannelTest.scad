fatty =  29.5;  //35.64 - 5.5 ; //52.17 -11.68 - 2.85;

MAX_ROW = 3;
MAX_COL = 4;
tweak = 0;

for ( row = [ 0: 1: MAX_ROW ])
{
    echo ("row = ", row , "--------------------------");
    for (across = [ 0: 1: MAX_COL ])
    {
        tweak =  (across + row * MAX_COL)/5;  //(row * MAX_COL + across)/6;
        //echo ("tweak = ", tweak);
        translate([ across * 50, row * 50 ,  0])
        cube( [ fatty + tweak, fatty + tweak , .5]);
        echo ("block = ",  fatty + tweak);
    }
    
}
answer=32.64 ....  32.30