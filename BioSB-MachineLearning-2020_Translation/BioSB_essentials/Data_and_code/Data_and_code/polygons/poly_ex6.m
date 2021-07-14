%POLY_EX6 Digit recognition

     % clear figure, load image
delfigs;
a = imread('digits.jpg','jpg');
a = mean(a,3);
fsize = 14;

figure(1); imagesc(a); colormap gray
title('Digits')
fontsize(fsize);

b = a > 128;
b = bwmorph(b,'erode',2);
b = bwmorph(b,'dilate',2);
figure(2); imagesc(b); colormap gray
title('Digits thresholded and morphologically closed')
fontsize(fsize);

b = ~imfill(~b,'holes');
figure(3); imagesc(b); colormap gray
title('Digits filled')
fontsize(fsize);

p = im2poly(b);
figure(4); plotpoly(p);
title('im2poly: polygons ready for feature extraction')
fontsize(fsize);

showfigs