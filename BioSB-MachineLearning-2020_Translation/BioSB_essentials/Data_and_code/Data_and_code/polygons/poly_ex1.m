%POLY_EX1 Intro polygons

delfigs
fsize = 14;
lwidth = 2;

% generate and display open polygon
p = [1 2; 2 3; 3 2; 4 2; 2 1];
figure(1); plotpoly(p);
title('p = [1 2; 2 3; 3 2; 4 2; 2 1]; plotpoly(p)');
fontsize(fsize); linewidth(lwidth);

% close polygon (standard)
q = polyclose(p);
figure(2); plotpoly(q); hold on
title('q = polyclose(p); plotpoly(q)');
fontsize(fsize); linewidth(lwidth);
[x10,y10] = meshgrid(1:0.1:4,1:0.1:3); 
h10 = plot(x10(:),y10(:),'r.'); set(h10,'markersize',7);
[x1,y1] = meshgrid(1:4,1:3); 
h1 = plot(x1(:),y1(:),'b.');  set(h1,'markersize',25);

% convert polygon to image
im = poly2im(q);
figure(3); imagesc(im); colormap gray
title('polygon to image by poly2im(q)')
fontsize(fsize);

% multiply all polygon coordinates by 10
im = poly2im(q*10);
figure(4); imagesc(im); colormap gray
title('enlarge polygon first, poly2im(q*10)')
fontsize(fsize);

showfigs



