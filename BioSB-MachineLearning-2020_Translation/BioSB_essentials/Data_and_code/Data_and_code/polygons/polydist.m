%POLYDIST Distances between polygons
%
%    D = polydist(c1,c2,method)
%
% A distance matrix is computed between all polygons stored in the
% two sets of polygon cell arrays c1 and c2.
% method = 'nnd': sum of nearest neighbor distances
%          of all vertices. (default)
% method = 'snnd': like 'nnd' but including a shift to a common
%          mean which makes this method translation independent.
% method = 'ssnnd': like 'snnd' but including scale
%          normalization.
% Note: the accuracy can be increased, at the cost of computing time,
% by increasing the number of polygons points by POLYINT
%
% The resulting distance matrix D has a size (n1,n2) in
% which n1 is the number of polygons stored in c1 and n2
% the number of polygons stored in c2. 

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function d = polydist(c1,c2,method,par);

if nargin < 3, method = 'nnd'; end

for j1 = 1:length(c1);
	p1 = c1{j1}';
	n1 = size(p1,2);
	if strcmp(method,'nnd')
		;
	elseif strcmp(method,'snnd')
		p1 = p1 - repmat(mean(p1')',1,n1);
	elseif strcmp(method,'ssnnd')
		p1 = p1 - repmat(mean(p1')',1,n1);
		p1 = p1./mean(std(p1'));
	else
		error('Unknown method')
	end
	c1{j1} = p1;
end

for j2 = 1:length(c2);
	p2 = c2{j2}';
	n2 = size(p2,2);
	if strcmp(method,'nnd')
		;
	elseif strcmp(method,'snnd')
		size(repmat(mean(p2')',1,n2))
		p2 = p2 - repmat(mean(p2')',1,n2);
	elseif strcmp(method,'ssnnd')
		p2 = p2 - repmat(mean(p2')',1,n2);
		p2 = p2./mean(std(p2'));
	else
		error('Unknown method')
	end
	c2{j2} = p2;
end

d = zeros(length(c1),length(c2));
for j1=1:length(c1)
	p1 = c1{j1};
	n1 = length(p1);
	for j2=1:length(c2)
		p2 = c2{j2};
		n2 = length(p2);
		D = ones(n1,1)*sum(p2.*p2,1);
		D = D + sum(p1.*p1,1)'*ones(1,n2);
		D = D - 2 .* (p1')*(p2);
		D = sqrt(D);
		d(j1,j2) = sum(min(D)) + sum(min(D'));
	end
end


