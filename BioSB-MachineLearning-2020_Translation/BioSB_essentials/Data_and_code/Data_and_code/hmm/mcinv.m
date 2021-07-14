% invariant distributions (normalized right eigenvector of the transition 
% probability matrix - see, e.g. p. 608 in (MacKay, 2003)) 
%
% trprob - transition probability matrix (columns are probability vectors)
% PM271108

function invdist = mcinv(trprob)
[a,b]= eig(trprob);
invdist  = a(:,1)./sum(a(:,1));