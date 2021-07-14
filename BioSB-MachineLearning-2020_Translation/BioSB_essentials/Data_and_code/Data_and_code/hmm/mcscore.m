% score a set of sequences against a specific Markov chain 
%
% PM271108

function score = mcscore(logliks,seq,lengths);

nseq = size(seq,1);

score = zeros(nseq,1);
% can this be vectorized?
for i=1:nseq,
    for j=2:lengths(i),
       score(i)= score(i)+logliks(seq(i,j-1),seq(i,j));
    end       
    % normalize for length
    score(i) = score(i)/lengths(i);
end
