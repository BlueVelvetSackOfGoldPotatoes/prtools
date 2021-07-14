%% function for 2.1(b)
function [data] = extractClass(data,class)
 lab = getlab(data);
 I = find(lab==class);
 data = +data(I,:);