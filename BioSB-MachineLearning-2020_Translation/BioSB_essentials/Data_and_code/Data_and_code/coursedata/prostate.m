%PROSTATE Load prostate data
%
%    X = PROSTATE
%
function x = prostate

load prostate;
a = +a;
y = a(:,end);
x = gendatr(a(:,1:(end-1)),y);

fl = {'lcoval' 'lweight' 'age' 'lbph' 'svi' 'lcp' 'gleason' 'pgg45'};
x = setfeatlab(x,fl);

return
