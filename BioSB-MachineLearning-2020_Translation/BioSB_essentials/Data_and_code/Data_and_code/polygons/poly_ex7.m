%POLY_EX7 Freeman string code conversion

     % clear figure, load image
delfigs
load kimia.mat
fsize = 14;

q = p{4};
figure(1); plotpoly(q);
title('Polygon')
fontsize(fsize);

f = poly2fc(q,4); % Convert to 4-connected FC
r = fc2poly(f);   % convert back
figure(2); plotpoly(r);
title('Convert to FC4, and back')

fontsize(fsize);
f = poly2fc(q/4,4); % Scale, Convert to 4-connected FC
r = fc2poly(f);     % convert back
figure(3); plotpoly(r);
title('Scale, convert to FC4, and back')

fontsize(fsize);
f = poly2fc(q/4); % Convert to 8-connected FC
r = fc2poly(f);   % convert back
figure(4); plotpoly(r);
title('Scale, convert to FC8, and back')
fontsize(fsize);

showfigs