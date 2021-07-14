% score a sequence against a Markov chain using a sliding window
%
% PM271108

function mcslide(logliks,seq,filename);

index = findstr(filename,'.');
str = filename(1:(index-1));
str = strcat(str,'.results');
fid = fopen(str,'w');
  
winlength = 50;

% initialization
score = 0;
for j=2:(winlength+1),
   score = score + logliks(seq(j-1),seq(j));
end  
fprintf(fid,'%i %g\n',1,score);

for j=(winlength+2):length(seq),
   left  = logliks(seq(j-winlength-1),seq(j-winlength));
   right = logliks(seq(j-1),seq(j));
   score = score - left + right;
   fprintf(fid,'%i %g\n',j-winlength,score);
end       

fclose(fid);