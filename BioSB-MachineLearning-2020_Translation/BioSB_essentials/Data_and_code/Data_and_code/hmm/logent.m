% logent takes care of log(0) and log(Inf)
% PM271108

function y = logent(x)
x(x==0)     = 1;
x(isinf(x)) = 1;
y = log2(x);
