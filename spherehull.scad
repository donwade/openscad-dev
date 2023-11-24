$fn=100;


pipe_size = 1;

hull()
{
    sphere (d = pipe_size);
    translate( [ 10, 0, 0 ])
    sphere (d = pipe_size);
}

