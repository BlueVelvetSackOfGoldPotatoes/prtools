%SHOW Object display, as images or functions
%
%       H = SHOW(A,N,BACKGROUND)
%
% Displays all objects stored in the datafile A. If the objects
% are images the standard Matlab imagesc-command is used for
% automatic scaling. If the features are images, they are 
% displayed. In case no images are stored in A all objects are
% plotted as functions using PLOTO.
% The number of horizontal figures is determined by N. If N is not
% given an approximately square window is generated.
% Borders between images and empty images are given the value 
% BACKGROUND (default: gray (0.5));
%
% Note that A should be defined by the dataset command, such that
% OBJSIZE or FEATSIZE contains the image size in order to detect 
% and reconstruct the images.
%
% SEE ALSO
% DATASETS, DATA2IM, IMAGE, PLOTO.

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: show.m,v 1.11 2009/02/19 12:34:02 duin Exp $

function h = show(a,nx,background)
		prtrace(mfilename,2);
%isobjim(a); let us assume that we have images
s = get(0,'screensize');

if nargin < 3, background = 0.5; end
if nargin < 2, nx = []; end
clf;
cla;
m = size(a,1);
if isempty(nx)
	nx = ceil(sqrt(m));
end
n1 = round(s(4)/(m/nx)); % about the linear size of a single image
n2 = round(s(3)/(nx)); % about the linear size of a single image
n = min(n1,n2);
[y,x,z] = getfeatsize(a);
if z ~= 3
	n = round(n/sqrt(z)); % multi-band-no-color images will be diplayed separately
end
a = im_fill_norm(a,n,background);
hh = show(dataset(a),nx,background);
if nargout > 0, h = hh; end
return


fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@datafile/show.m
 fn: show -------------