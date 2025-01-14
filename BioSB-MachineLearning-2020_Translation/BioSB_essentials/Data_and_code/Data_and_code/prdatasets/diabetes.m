%DIABETES 768 objects with 8 features in 2 classes
%
%        X = DIABETES
%
% Pima-indians diabetes database from National Institute of Diabetes and
% Digestive and Kidney Diseases.
function x = diabetes

user.desc='The Pima Indians Diabetes Database from UCI.';
user.link = 'ftp://ftp.ics.uci.edu/pub/machine-learning-databases/pima-indians-diabetes/';
cl = {'present' 'absent'};
fl = {'NumPregnancies' 'plasmaGlucose' 'diastolicBloodPr' ...
'tricepsSkinfold' '2hrSerumInsulin' 'BodyMassIndex' ...
'DiabetesPedigreeFn' 'Age'};

a = load('diabetes.dat');
x = dataset(a(:,1:(end-1)),cl(a(:,end)+1));
x = setfeatlab(x,fl);
x = setname(x,'Diabetes');
x = setuser(x,user);

return
