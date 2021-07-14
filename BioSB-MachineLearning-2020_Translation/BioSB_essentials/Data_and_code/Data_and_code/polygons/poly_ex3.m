%POLY_EX3 Generate polygons

     % clear figure, load image
delfigs;
fsize = 14;

p = cell(1,16);
for j=3:18
	p{j-2} = polygen(j);
end
figure(1); showpoly(p);
title('polygen(n): regular polygons ')
fontsize(fsize);

p = polygen(4,0.3,16);
figure(2); showpoly(p);
title('polygen(4,0.3,16) irregular polygons')
fontsize(fsize);

p = polygen(7,0.2,16);
figure(3); showpoly(p);
title('polygen(7,0.2,16) irregular polygons')
fontsize(fsize);

p = polygen(12,0.1,16);
figure(4); showpoly(p);
title('polygen(12,0.1,16) irregular polygons')
fontsize(fsize);

showfigs