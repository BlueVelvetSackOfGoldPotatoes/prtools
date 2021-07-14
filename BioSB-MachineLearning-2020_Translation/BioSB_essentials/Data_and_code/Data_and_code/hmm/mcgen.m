% generate sequence from a Markov chain
%
% PM271108

function seq = mcgen(trprob,nseq,lengths,invdist);

seq = zeros(nseq,max(lengths));

toto  = cumsum(trprob,2);
for i=1:nseq,
    % initial state
    seq(i,1) = min(find(cumsum(invdist)>rand)); 
    for j=2:lengths(i),
        seq(i,j) = min(find(toto(seq(i,j-1),:)>rand));
    end
end 