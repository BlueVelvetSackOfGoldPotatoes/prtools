%SOYBEAN2 Small soybean dataset 136 objects with 35 features in 4 classes
%
%	A = SOYBEAN2
%	A = SOYBEAN2(M,N)
%
% Load the dataset in A, select the objects and features according to the
% index vectors M and N. This is the small Soybean dataset from the UCI
% Machine Learning Repository, //www.ics.uci.edu/~mlearn/MLRepository.html.
%
% See also DATASETS, PRDATASETS, SOYBEAN1

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function a = soybean2(M,N);
if nargin < 2, N = []; end
if nargin < 1, M = []; end
a = prdataset('soybean2',M,N);
a = setname(a,'Small soybean dataset');
a = setlablist(a,str2mat(...
    'phytophthora rot',...
    'brown spot',...
    'alternarialeaf spot',...
    'frog eye leaf spot'));
a = setfeatlab(a,str2mat(...
    'date',...
    'plant stand',...
    'precipitation',...
    'temperature',...
    'hail',...
    'crop history',...
    'area damaged',...
    'severity',...
    'seed treatment',...
    'germination',...
    'plant growth',...
    'leaves',...
    'leafspots halo',...
    'leafspots marginal',...
    'leafspot size',...
    'leaf shread',...
    'leaf malfunction',...
    'leaf mildew',...
    'stem',...
    'lodging',...
    'stem cankers',...
    'canker lesion',...
    'fruiting bodies',...
    'external decay',...
    'mycelium',...
    'int discolor',...
    'sclerotia',...
    'fruit pods',...
    'fruit spots',...
    'seed',...
    'mold growth',...
    'seed discolor',...
    'seed size',...
    'shriveling',...
    'roots'));
    
