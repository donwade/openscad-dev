$fn=100;
sides = 6;;
spacing = 4;


hi=1;
rad=1;
dia=10;

module makeGrating(width, length, percent)
{
    choles = width  * percent/ 100;
    rholes = length * percent/ 100;
    dia = choles * 90 /100;
     echo ("xxxxxx", choles = choles, rholes = rholes, dia = dia);

    oneColumn = width * percent/100;
    oneRow = length * percent /100;
    
    // do not print row or column 0... fence post algorithm
    translate ([-dia/2, -dia/2, 0])
    {
        for (kolumn = [0: 1: choles])
        {
    
            if (kolumn)
            {
                column = kolumn *  oneColumn;;
                {
                    for (crow = [0: 1 : rholes])
                    {
                        row = crow * oneRow;
                        if (crow)
                        {
                            echo (kolumn = kolumn, column = column, crow = crow, row = row);
                            y = crow % 2 ? row : row;
                            x = kolumn % 2 ? column : column;

                            color( crow % 2 ? "RED" : "GREEN")
                            
                            //translate([kolumn % 2 ? column : column - oneColumn/2, crow % 2 ? row : row + oneRow/2, 0 ])
                            translate([x, y, 0 ])
                            //translate ( [ column, row, 0 ])
                            //rotate([0,0, ((kolumn + crow) % 2) ? 0 : 180/sides])
                            cylinder(hi, d=dia, true, $fn=sides);
                        }
                    }
                }
            }
        }
    }
     echo ( choles = choles, rholes = rholes, dia = dia);
   
}

makeGrating(30, 30, 30);
