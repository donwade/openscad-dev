s = "Hello World!";
valign = "baseline";
halign = "left";
f = "Freestyle Script";
dir = "ltr";
size = 20;

tm = textmetrics(s, size=size, valign=valign, halign=halign, font=f, direction=dir);
translate(tm[0]) cube(concat(tm[1],1));
color("lightgreen") linear_extrude(height=2) text(s, size=size, valign=valign, halign=halign, font=f, direction=dir);

txt=ABC();
font=undef;//"arial";
size=100;
function ABC(i=26)=i?str(ABC(i-1),chr(i +64)):"";

tm=textmetrics(txt,size=size,font=font);
fm=fontmetrics(size=size,font=font);
echo(height=tm.ascent,tm,fm);
text(txt,size=size,font=font);