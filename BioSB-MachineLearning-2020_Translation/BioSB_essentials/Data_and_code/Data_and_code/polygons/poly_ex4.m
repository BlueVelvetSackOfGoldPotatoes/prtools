%POLY_EX4 Polygon normalisation

     % clear figure, load image
delfigs;
load kimia.mat
fsize = 14;

q = p(1:12:end)
figure(1); showpoly(q);
title('Part of the Kimia database')
fontsize(fsize);

q = polynorm(q);
figure(2); showpoly(q);
title('polynorm: normalisation on orientation and size')
fontsize(fsize);

q = p(1:12)
figure(3); showpoly(q);
title('Other part of the Kimia database')
fontsize(fsize);

q = polynorm(q);
figure(4); showpoly(q);
title('polynorm: normalisation on orientation and size')
fontsize(fsize);

showfigs