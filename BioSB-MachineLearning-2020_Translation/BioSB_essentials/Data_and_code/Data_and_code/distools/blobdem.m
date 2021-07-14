addph prtools3.1.2 % just needed for display purposes

addph phtools      % just needed for reading NIST

a = readnist([3 8],5);
figure(1);
clf
imagesc(im2feat(a),5);
b = blobbox(a,16);
figure(2);
imagesc(im2feat(b),5);
b = blobbox(a,32);
figure(3);
imagesc(im2feat(b),5);



