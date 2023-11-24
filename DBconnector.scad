// https://content.norcomp.net/rohspdfs/Connectors/PanelCutOuts/Panel_Cutout_D-Sub-Single.pdf

$fn=100;
//                A      B      C      D      E      F      G      H      I
FM_DB09_15HD = [ 24.99, 20.70, 15.70, 12.50, 13.47, 11.68,  5.84,  6.88, 2.40];
FM_DB15_26HD = [ 33.32, 29.00, 24.20, 16.66, 21.77, 11.68,  5.84,  6.88, 2.40];
FM_DB25_44HD = [ 47.04, 42.90, 38.00, 23.52, 35.57, 11.68,  5.84,  6.88, 2.40];
FM_DB37_62HD = [ 63.50, 59.90, 54.40, 31.75, 51.97, 11.68,  5.84,  6.88, 2.40];
FM_DB50_78HD = [ 61.11, 56.80, 52.00, 40,54, 48.66, 14.28,  7.14,  9.48, 2.40];

//                 A      B      C      D      E      F      G      H      I
BM_DB09_15HD = [ 24.99, 20.47, 15.46, 12.50, 13.46, 10.67,  5.33,  5.66 , 2.51];
BM_DB15_26HD = [ 33.32, 28.80, 23.79, 16.66, 21.79, 10.67,  5.33,  5.66 , 2.51];
BM_DB25_44HD = [ 47.04, 45.52, 37.51, 23.52, 35.51, 10.67,  5.33,  5.66 , 2.51];
BM_DB37_62HD = [ 63.50, 59.08, 54.07, 31.75, 52.07, 10.67,  5.33,  5.66 , 2.51];
BM_DB50_78HD = [ 61.11, 56.34, 51.32, 40.54, 48.12, 14.10,  7.05,  9.08 , 2.51];


PUNCH=10;
EAR_HOLE=3.05;

module makeDB ( array)
{
    A = array[0];
    B = array[1];
    C = array[2];
    D = array[3];
    E = array[4];
    F = array[5];
    G = array[6];
    H = array[7];
    R = array[8];
    
    union ()
    {
        translate( [  -D,   0, 0] ) cylinder(PUNCH, d=EAR_HOLE);
        translate( [  +D,   0, 0] ) cylinder(PUNCH, d=EAR_HOLE);
        hull()
        {
            translate( [  -C/2, +H/2, 0]) cylinder(PUNCH, r = R);
            translate( [  +C/2, +H/2, 0]) cylinder(PUNCH, r = R);
            translate( [  -E/2, -H/2, 0]) cylinder(PUNCH, r = R);
            translate( [  +E/2, -H/2, 0]) cylinder(PUNCH, r = R);
        }
    }
}
translate ( [ 0, 20 , 0 ])  makeDB(FM_DB09_15HD);
translate ( [ 0, 40 , 0 ])  makeDB(FM_DB15_26HD);
translate ( [ 0, 60 , 0 ])  makeDB(FM_DB25_44HD);
translate ( [ 0, 80 , 0 ])  makeDB(FM_DB37_62HD);
translate ( [ 0, 105, 0 ])  makeDB(FM_DB50_78HD);

translate ( [ 0, -20 , 0 ])  makeDB(BM_DB09_15HD);
translate ( [ 0, -40 , 0 ])  makeDB(BM_DB15_26HD);
translate ( [ 0, -60 , 0 ])  makeDB(BM_DB25_44HD);
translate ( [ 0, -80 , 0 ])  makeDB(BM_DB37_62HD);
translate ( [ 0, -105, 0 ])  makeDB(BM_DB50_78HD);
