%DATASET Dataset class constructor
%
%    A = DATASET(DATA,LABELS)
%
% INPUT
%   DATA    size [M,K]  a set of M datavectors (objects) of length K.
%                       a cell array of datasets will be concatenated. 
%   LABELS  size [M,N]  array with labels for the M datavectors.
%                       They should be either integers or character strings.
%                       Choose single characters for the fastest implementation.
%                       Numeric labels with value NaN or character labels
%                       with value CHAR(0) are interpreted as missing labels.
%
% OUTPUT
%    A      Dataset
%
% DESCRIPTION
% This command is the class constructor for datasets. In addition to the object labels  
% various other types of information can be stored in the fields of A.
% These fields are:
%
% DATA    size [M,K]  array (doubles) with M K-dimensional feature vectors (objects)
% FEATLAB size [K,F]  array with labels for the K features
% FEATDOM size [K]    cell array with domain description for the K features
% TARGETS size [M,C]  dataset with soft labels or targets
% PRIOR   size [C,1]  prior probabilities for each of the C classes
%                     - PRIOR = 0: all classes have equal probability 1/C
%                     - PRIOR = []: all datavectors are equally probable
% COST    size [C,C+1] Classification cost matrix. COST(I,J) are the costs
%                     of classifying an object from class I as class J.
%                     Column C+1 generates an alternative reject class and
%                     may be omitted, yielding a size of [C,C]. 
%                     An empty cost matrix, COST = [] (default) is interpreted
%                     as COST = ONES(C) - EYE(C) (identical costs of
%                     misclassification).
% LABLIST size [C,N]  class labels corresponding to the unique labels found
%                     in LABELS and thereby to the classes in the dataset.
%                     The order of the items in LABLIST corresponds to the
%                     apriori probablities stored in PRIOR. LABLIST should
%                     only be given explicitely if PRIOR is given and if it
%                     is not equal to 0 and not empty.
% LABTYPE             String defining the label type,
%                     'crisp' for defining classes by integers or strings
%                     'soft' for defining memberships to classes. In this
%                             case LABELS should be a MxC array with numbers
%                             between 0 and 1.
%                     'targets' for defining regression type target values.
%                             Labels should be a MxN numeric array for
%                             defining N targets per object.
% OBJSIZE             number of objects, or vector with its shape. This is
%                     useful if the set of objects can be interpreted as an
%                     image (objects are pixels).
% FEATSIZE            number of features, or vector with its shape. This is
%                     useful if the set of features can be interpreted as an
%                     image (features are pixels).
% IDENT  [M,1]        Cell array, identifier for objects. 
% NAME                String with dataset name
% USER                User definable variable
% VERSION             Date and PRTOOLS version at creation
%
% The fields LABLIST, OBJSIZE, FEATSIZE, IDENT and VERSION are preset by PRTOOLS. 
% The other fields can be set by the user by the below SET commands.
% All fields can be read by GET commands. By STRUCT(A) a dataset A can be
% converted to a structure. By DOUBLE(A) or +A the data can be retrieved.
% HELP DATASETS lists more information.
%
% SEE ALSO 
% DATASETS, MAPPINGS

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

% $Id: dataset.m,v 1.64 2010/06/10 22:36:13 duin Exp $

function varargout = dataset(a,labels,varargin)

	prtrace(mfilename,1);

 	persistent PRTOOLS_START
 	mlock;

	if isempty(PRTOOLS_START)
		PRTOOLS_START = 1;
		it_was = 734488; % ## expiring ##
		it__is = datenum(date);
		nexpd = 25 + 6 - it__is + it_was;
		z = prtver; z = z{1};
		disp([newline '    Welcome to PRTools, version ' z.Version ...
                       ' (' z.Date ').'])
		disp('    This version of PRTools is valid for non-commercial academic use only.')
		disp([prtools_news newline])
		
		if 0 							 % check expiring
			if nexpd > 0
				disp(['    This version of PRTools will expire in ' num2str(nexpd) ' days.' newline])
			elseif nexpd == 0
				warn_now;
			elseif nexpd < 0
				get_new;
				error(' ')
			end
		end
	end

	b.data    = []; % data
	b.lablist = []; % labels of the classes
	b.nlab    = []; % nummeric labels, index in lablist
	b.labtype = 'crisp'; % label type: 'crisp','soft' or 'targets'
	b.targets = []; % dataset with soft labels or targets
	b.featlab = []; % feature labels
	b.featdom = {}; % feature domains
	b.prior   = []; % prior probabilities
	b.cost    = []; % cost matrix
	b.objsize = []; % number of objects or vector with its shape
	b.featsize= []; % number of features or vector with its shape
	b.ident   = []; % indentifier for objects
	b.version = []; % PRTools version
	b.name    = []; % string with name of the dataset
	b.user    = []; % user field

	b = class(b,'dataset');
	superiorto('double');

	if nargin == 0 %return empty dataset in case of no input parameters
		varargout = {b};
		return
	end

	% remove these lines if everybody knows. They enable the
	% usage of the old dataset definition
	if isdataset(a) & nargin == 1 & nargout > 1
		varargout = dataset_old(a,nargout);
		return
	end

	b.version = prtver;

	if isempty(a) % return empty dataset
		varargout = {b};
		return
	end
	% default: empty labels
	if nargin < 2, labels = [];  end

	if isa(a,'cell')
		aa = [];
		for j=1:length(a)
			aa = [aa a{j}];
		end
		a = aa;
	end

	if isa(a,'struct') % convert from old dataset definition
		
		b=primport(a);
		
	       
	elseif isa(a,'measurement') % convert from measurement class
		b.data = +a;
		labs = getlab(a);
		if iscell(labs)
			labs = [labs{:}]';
		end
		[b.nlab,lablist] = renumlab(labs);
		b = setlablist(b,lablist);
		[b.objsize,b.featsize] = size(b.data);
		%   retrieve image sizes.
		if (min(size(a{1})) > 1)
			b.featsize = size(a{1});
		end;
	elseif isa(a,'datafile') % convert from datafile class
		testdatasize(a);
		if isa(a,'dip_image')
			a	 = doublem(a);  % get rid of dip_image problems
		end
		next0 = 1;
		size_old = 0;
		L = [];
		while next0 > 0
			try
				[c,next1,J] = readdatafile(a,next0,1,0);
			catch
				ss = lasterror;
				if strcmp(ss.identifier,'FeatSize')
					% objects are of different size after preprocessing
					% perhaps postprocessing makes this OK. Try one by one.
					c = readdatafile(a(1,:));
					J = 1;
					next0 = 1;
					next1 = 0;
				else
					rethrow(ss);
				end
			end
			L = [L;J];
			if next0 == 1
        b = get(a,'dataset');
        b.data = zeros(size(a,1),size(c,2));
        if ~isempty(c.targets)
          b.targets = zeros(size(a,1),size(c.targets,2));
        end
        b.featsize = c.featsize;
      elseif (size(b.data,2) ~= size(c.data,2))
				if (size(b.data,2)/size(c.data,2) == 3)
					c = [c c c]; % correct for color images, better not to ...?
				else
					error('Feature sizes of objects differ, conversion to dataset not posible');
				end
			end
			if next1 == 0
				% continue conversion one by one until the end, as long as it works
				m = size(a,1);
				waittext = sprintf('Processing %i objects: ',m);
				prwaitbar(m,waittext);
				prwaitbar(m,1,[waittext '1']);
				for j=2:size(a,1)
					c = readdatafile(a(j,:));
					b.data(j,:) = +c;
					if ~isempty(b.targets)
						b.targets(j,:) = c.targets;
					end
					prwaitbar(m,j,[waittext int2str(j)]);
				end
				prwaitbar(0);
				next0 =0;
				L = [1:m]';
			else % normal datafile conversion
				size_new = size_old + size(c,1);
				next0 = next1;
				b.data(size_old+1:size_new,:) = c.data;
				if ~isempty(b.targets)
					b.targets(size_old+1:size_new,:) = c.targets;
				end
				size_old = size_new;
			end
		end
		b.ident = rmfield(b.ident,'file_index');
		b.data(L,:) = b.data;
		b = setfeatlab(b,getfeatlab(c));
		b = setfeatdom(b,getfeatdom(c));
	elseif isa(a,'dataset') % dataset in, dataset out
		b = addlablist(a);    % trick to convert to multilabels if needed
		b = setident(b);      % make ident field structure
	elseif isa(a,'double')  % conversion of double to dataset
		b.data = a;
		b = addlablist(b);
	else
		error('Illegal datatype')
	end

	% definition of other fields
	
	[m,k] = size(b.data);   % retrieve dataset sizes
	
	if isempty(b.objsize)   % if objsize not yet set, do it now
		b.objsize = m;
	end
	
	if isempty(b.featsize)  % if featsize not yet set, do it now
		b.featsize = k;
	end
	
	if isempty(b.nlab)      % length of numeric label array equals no. of objects
		b.nlab = zeros(m,1);
	end
	
	if isempty(b.ident)     % give each object its identifier 
    b = setident(b,[1:m]');
	end

	if isempty(b.labtype)   % if labtype not yet set, do it now
		if isempty(labels)    % dataset without labels and targets, make crisp
			b.labtype = 'crisp';
		elseif (size(labels,2) == 1 & ~isa(labels,'dataset')) | isstr(labels)
			b.labtype = 'crisp'; % choose for crisp labels
					     % to be reset by user if incorrect
		else
			b.labtype = 'soft';  % choose for soft labels		
					     % to be reset by user if incorrect
		end
	end

	if ~isempty(labels)    % if labels are supplied, set them
		b = setlabels(b,labels);
		%elseif isa(a,'double') % if not, make them all 1
		%	b = setlabels(b,ones(m,1));
	end
	%if isempty(b.featlab)  % set default feature labels
	%	b = setfeatlab(b,[1:k]');
	%end
	%if isempty(b.featdom)  % set default feature domain
	%	b = setfeatdom(b,cell(1,k));
	%end
	if ~isempty(varargin)  % if additional arguments are given, set them
		if 2*floor(length(varargin)/2) ~= length(varargin)
			error('Wrong argument list')
		end
		b = set(b,varargin{:});
	end
	% We are done, return dataset.
	% The varargout construct is needed to facilitate the
	% use of the old dataset definition above (dataset_old)
	varargout = {b};

function v = dataset_old(a,n);
% 
% This serves compatibility with old dataset calls to retrieve data
%

%RD Change 'global' into 'persistent' when everything is done
	persistent OLD_DATA_CONSTRUCT

	if isempty(OLD_DATA_CONSTRUCT)
		OLD_DATA_CONSTRUCT = 1;
		warning(['Data retrieval by DATASET will not be supported in future versions.', ...
			 newline,'         Use GET instead.',newline])
	end

	[m,k,c] = getsize(a);
	v = {a.nlab,a.lablist,m,k,c,a.prior,a.featlab,0};

function warn_now
%
% Produce some warning in case the license will expire
%
	disp(' ')
	disp('   Your license for PRTools expires today')
	disp('   You may get a new PRTools version from http://prtools.org')
	disp(' ')

function get_new
%
% Produce an error message in case the license has been expired
%
	disp(' ')
	disp('   Your license for PRTools has been expired')
	disp('   You may get a new PRTools version from http://prtools.org/')
	disp(' ')
