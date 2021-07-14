% find stretches of positive log-odds in an
% unannotated sequence
%
% PM271108

warning('off');
load 'seq_a.results'
  
toto = find(seq_a(:,2)>0);
% find stretches
length = 1;
for i=1:(size(toto,1)-1)
  if ((toto(i)+1)==toto(i+1))
    length = length + 1;
  else
    if length > 100
      str=sprintf('Stretch from position %d to position %d.\n',toto(i)-length+1,toto(i)); 
      disp(str);
    end
    length = 1;
  end
end