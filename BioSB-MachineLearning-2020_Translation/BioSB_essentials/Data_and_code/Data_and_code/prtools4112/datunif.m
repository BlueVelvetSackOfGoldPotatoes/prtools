%DATUNIF Apply uniform filter on images in a dataset 
%
%		B = DATUNIF(A,NX,NY)
%
% INPUT
%		A        Dataset containing images
%		NX,NY    Filtersize in X- and Y-direction (default: NY = NX)
%
%	OUTPUT
%		B        Dataset with filtered images
%
% DESCRIPTION	
% All images stored as objects (rows) or as features (columns) of
% dataset A are filtered with an NX*NY uniform filter and stored in
% dataset B.  Image borders are mirrored before filtering. 
%
% SEE ALSO
% DATASETS, DATAIM, IM2OBJ, IM2FEAT, DATGAUSS, DATFILT

% Copyright: R.P.W. Duin, duin@ph.tn.tudelft.nl
% Faculty of Applied Sciences, Delft University of Technology
% P.O. Box 5046, 2600 GA Delft, The Netherlands

% $Id: datunif.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function a = datunif (a,nx,ny)

	prtrace(mfilename);

	% Check arguments.
	if (nargin < 2)
		error('Filter size should be specified.');
	end			
	if (nargin < 3)
		prwarning(4,'filter height (NY) not specified, assuming equal to NX');
		ny = nx; 
	end

	% Construct filter.
	bordersize = floor(max(nx,ny)/2); 				
	filter_x = ones(1,nx)/nx; filter_y = ones(1,ny)/ny;

	% Convert dataset to image or image array.
	im = data2im(a); [imheight,imwidth,nim] = size(im);

	% Process all images...
	for i = 1:nim
		out = bord(im(:,:,i),NaN,bordersize);        % Add mirrored border.
		out = conv2(filter_y,filter_x,out,'same');   % Convolve with filter.
		im(:,:,i) = resize(out,bordersize,imheight,imwidth);
                                                 % Crop back to original size.
	end

	% Place filtered images back in dataset.
	if (isfeatim(a))
		a = setdata(a,im2feat(im),getfeatlab(a));
	else
		a = setdata(a,im2obj(im),getfeatlab(a));
	end

return

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/datunif.m
 fn: datunif -------------
