%CAR 1728 objects with 6 features in 4 classes
%
%  A = CAR
%
% The Car Evaluation Database was derived from a simple hierarchical
% decision model originally developed for the demonstration of DEX (M.
% Bohanec, V. Rajkovic: Expert system for decision making. Sistemica
% 1(1), pp. 145-157, 1990.). All 6 features are nominal.
% The instances completely cover the attribute space.
function x = car;

user.desc = 'Car Evaluation Database was derived from a simple hierarchical decision model originally developed for the demonstration of DEX (M. Bohanec, V. Rajkovic: Expert system for decision making. Sistemica 1(1), pp. 145-157, 1990.).';
fl = {'buying price' 'maintenance price' 'nr of doors' 'nr of persons' 'luggage boot' 'safety'};

[a,strvals] = readdataset('car.data',ones(7,1));
labs = strvals{end}(a(:,end));
for i=1:6
	featdom{i} = strvcat(strvals{i}');
end
x = dataset(a(:,1:(end-1)), labs);
x = setfeatlab(x,fl);
x = setfeatdom(x,featdom);
x = setuser(x,user);
x = setname(x,'Car');

return
