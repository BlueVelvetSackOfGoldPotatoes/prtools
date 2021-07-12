%IRIS 150 objects with 4 features in 3 classes
%
%  A = IRIS
%
% Iris plants dataset by R.A.Fisher, 150 objects, 4 features, 3
% classes.
function x = iris;

user.desc = 'Iris Plant database from UCI. A classic dataset in the pattern recognition literature.  The original dataset is a multiclass classification problem, introduced by R.A. Fisher, The use of multiple measurements in taxonomic problems. Ann Eugenics, 7:179--188, 1936.';
user.link = 'ftp://ftp.ics.uci.edu/pub/machine-learning-databases/iris/';
cl = {'Iris-setosa' 'Iris-versicolor' 'Iris-virginica'};
fl = {'sepal length' 'sepal width' 'petal length' 'petal width'};

a = load('iris.dat');
x = dataset(a(:,1:(end-1)), cl(a(:,end)));
x = setfeatlab(x,fl);
x = setuser(x,user);
x = setname(x,'Iris');

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prdatasets/iris.m
 fn: iris -------------
