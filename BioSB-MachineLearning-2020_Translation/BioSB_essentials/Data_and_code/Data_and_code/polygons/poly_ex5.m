%POLY_EX5 Polygon interpolation and smoothing

     % clear figure, load image
delfigs;
load kimia.mat
fsize = 14;

q = p(122);
figure(1); showpoly(q);
title('Object of the Kimia database')
fontsize(fsize);

r = cell(1,16);
for j = 1:16
	r{j} = polyint(q,4*j);
end
figure(2); showpoly(r);
title('polyint: polygon equidstant interpolation')
fontsize(fsize);

r = cell(1,16);
for j = 1:16
	r{j} = polyopt(q,4*j);
end
figure(3); showpoly(r);
title('polyopt: polygon optimised interpolation')
fontsize(fsize);

r = cell(1,9);
q = poly2rad(q,128);
for j = 1:9
	s = rad2rad(q,j-1);
	r{j} = rad2poly(s);
end
figure(4); showpoly(r);
title('poly2rad, rad2rad, rad2poly: polygon smoothing')
fontsize(fsize);

showfigs