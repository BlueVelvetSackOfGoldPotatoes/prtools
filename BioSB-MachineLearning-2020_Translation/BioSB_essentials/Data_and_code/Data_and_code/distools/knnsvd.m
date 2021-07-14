%KNNSVD KNN - SVC for dissimilarity data
%
%	[labs,labk] = knnsvd(A,R,k)
%
% R     is a square dissimilarity matrix.
% A     contains the dissimilarities of the test objects with the same
%       representation set as used in R.
% labs  are the labels assigned to A by the knnsvd procedure
% labk  are the labels assigned to A by the knn method
%
% If all k nearest neighbors belong to the same class labs equals labk.
% This holds always for k = 1.
%
% Two-class problems only
%
% $Id: knnsvd.m,v 1.2 2001/07/10 16:35:58 pavel Exp $

function [es,ek] = knnsvd(A,R,k)
if nargin < 3, k = 1; end
[m,kr] = size(R);
[nlab,lablist,n,ka,c,p,featlist] = dataset(A);
[clab,classlist] = renumlab(featlist);
if c > 2, error('Two-class problems only'); end
if kr ~= ka, error('Representation sets should be equal'); end

% to be included: test on labels

t = ceil(k/2);
[B,J] = sort(+A,2);
I1 = find(clab==1);
I2 = find(clab==2);
A1 = A(:,find(clab==1));
A2 = A(:,find(clab==2));
[B1,J1] = sort(+A1,2);
[B2,J2] = sort(+A2,2);
J = J(:,1:k);
J1 = I1(J1(:,1:k));
J2 = I2(J2(:,1:k));
JJ = [J1 J2];
N = sum(clab(J)==1,2);
nlabk = ones(n,1);
K = find(N < t);
nlabk(K) = 2*ones(length(K),1);
labk = classlist(nlabk,:);
labs = labk;
for i=1:n
	if N(i) < k & N(i) > 0 
%		D = R(J(i,:),J(i,:));
%		labs(i,:) = A(i,J(i,:))*svc(D,'p',2)*classd;
		D = R(JJ(i,:),JJ(i,:));
		labs(i,:) = A(i,JJ(i,:))*svc(D)*classd;
	end
end
es = nstrcmp(getlab(A),labs)/n;
ek = nstrcmp(getlab(A),labk)/n;


function [N,C] = nstrcmp(S1,S2)
[m,k] = size(S1);
[n,l] = size(S2);
if m~=n | k~=l
	error('Data sizes do not match')
end
C = all(S1'==S2',1)';
N = m - sum(C);
return
