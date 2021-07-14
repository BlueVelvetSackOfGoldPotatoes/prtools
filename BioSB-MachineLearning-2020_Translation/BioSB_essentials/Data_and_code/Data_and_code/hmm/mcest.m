% estimate transition probabilities of Markov chain
% from sequences 'seq'
%
% PM271108

function trprob = mcest(seq,lengths)

n = max(max(seq));

seq=seq';
size(seq)
for i=1:n,
 for j=1:n,
  index = find(seq==i);
  trprob(i,j) = length(find(seq((index+1))==j));
 end        
end

% normalize
toto = sum(trprob,2);
trprob = trprob ./toto(:,ones(1,n));

