a = nist16;
b = data2im(a);
		% plot digit
c = b(:,:,650);
p = im2poly(c);
plotpoly(p)
figure(2)
plotblob(p,'r')
		% plot digits 0-9
c = [b(:,:,50) b(:,:,250) b(:,:,450) b(:,:,650) b(:,:,850)];
c = [c; zeros(2,80)];
c = [c;b(:,:,1050) b(:,:,1250) b(:,:,1450) b(:,:,1650) b(:,:,1850)];
figure(1)
p = im2poly(c);
plotpoly(p)
figure(2)
plotblob(p,'r')
		% interpolation 
disp('Increase resolution by polyint')
for n = 5:5:100
	plotblob(polyint(p,n));
	drawnow
	disp([num2str(n) ' ... waiting for ''return'''])
	pause
end
		% simplification
disp('Decrease simplification by polyopt')
c = b(:,:,650);
p = im2poly(c);
for n = 5:5:100
	plotblob(polyopt(p,n));
	drawnow
	disp([num2str(n) ' ... waiting for ''return'''])
	pause
end
		% image to polygon and back
c = b(:,:,650);
p = im2poly(c);
d = poly2im(p);
figure(1); imagesc(c);
hold on; plotpoly(p,'r'); hold off
figure(2); imagesc(d)
		% binary image
d = c > 100;
p = im2poly(d);
figure(1); imagesc(d);
hold on; plotpoly(p,'r'); hold off
		% length and area
disp('Compute perimeter and area of equilateral polygons')
for n = [3,4,10,25,50,100];
	p = polygen(n);
	plotpoly(p);
	len = polylength(p);
	opp = polyarea(p);
	disp([num2str([n,len,opp]) ' ... waiting for ''return'''])
	pause
end

