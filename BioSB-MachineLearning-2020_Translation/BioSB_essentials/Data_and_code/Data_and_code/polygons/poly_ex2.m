%POLY_EX2 Image --> Polygons --> Image

     % clear figure, load image
delfigs;
load cermet
fsize = 14;
lwidth = 2;

     % display image
figure(1); imagesc(a); colormap gray
title('Cermet image')
fontsize(fsize);

     % construct polygons and display
p = im2poly(a);            % automatic threshold halfway!
figure(2); plotpoly(p);
x = polyposition(p);       % get polygon coordinates
text(x(:,1)-2,x(:,2),num2str([1:length(p)]')); % display polygon numbers
title('Polygons from contours')
fontsize(fsize); linewidth(lwidth);

     % reconstruct image from all polygons
b = poly2im(p);
figure(3); imagesc(b); colormap gray
title('Image from all polygons')
fontsize(fsize); 

     % reconstruct image from a few polygons
c = poly2im(p(20:30));
figure(4); imagesc(c); colormap gray
title('Image from a few polygons')
fontsize(fsize); 

     % proper display of results
showfigs
