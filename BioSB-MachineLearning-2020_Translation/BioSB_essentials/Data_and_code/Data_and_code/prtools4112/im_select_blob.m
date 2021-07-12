%IM_SELECT_BLOB Select largest blob in binary images in dataset (DIP_Image)
%
%       B = IM_SELECT_BLOB(IM)
%
% Just the largest object in the image is returned.
%
% SEE ALSO
% DATASETS, DATAFILES, DIP_IMAGE

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function b = im_select_blob(a)

	prtrace(mfilename);
	
  if nargin < 1 | isempty(a)
    b = mapping(mfilename,'fixed');
    b = setname(b,'Select largest blob');
	elseif isa(a,'dataset') % allows datafiles too
		isobjim(a);
    b = filtim(a,mfilename);
		b = setfeatsize(b,getfeatsize(a));
  elseif isa(a,'double') | isa(a,'dip_image') % here we have a single image
    if ~isa(a,'dip_image')
			a = dip_image(a,'bin');
		end;
		labim = label(a);
		c = measure(labim,labim,{'size','mean'});
		c = double(c);
		[cc,ind] = max(c(:,1));
		b = a.*(labim==round(c(ind,2)));
	end

return
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/im_select_blob.m
 fn: im_select_blob -------------
