%DATAFILE Datafile class constructor. This is an extension of DATASET.
%
%    A = DATAFILE(DIRECTORY,TYPE,READCMD,P1,P2,P3, ...)
%    A = DATAFILE(DIRECTORY,READCMD,P1,P2,P3, ...)
%
% INPUT
%   DIRECTORY - Data directory
%   TYPE      - Datafile type (default 'raw')
%   READCMD   - Command (m-file) for reading files in DIRECTORY
%   P1,P2,P3  - Optional parameters of READCMD
%
% OUTPUT
%   A         - Datafile
%
% DESCRIPTION
% Datafiles prepare and enable the handling of datasets distributed over
% multiple files, i.e. all files of DIRECTORY. Datafiles inherit all
% dataset fields. Consequently, most commands defined on datasets also
% operate on datafiles with the exception of a number of trainable
% mappings. There are four types of datafiles defined:
% TYPE='raw'     Every file is interpreted as a single object in the
%                dataset. All objects in the same sub-directory of
%                DIRECTORY receive the name of that sub-directory as class
%                label. Files may be preprocessed before conversion to
%                dataset by FILTM. At conversion time they should have the
%                same size (number of features).
% TYPE='cell'    All files in DIRECTORY should be mat-files containing just
%                a single variable being a cell array. Its elements are
%                interpreted as objects. The file names will be used as
%                labels during construction. This may be changed by the
%                user afterwards.
% TYPE='pre-cooked'  It is expected that READCMD outputs for all files a
%                dataset with the same label list and the same feature size.
% TYPE='half-baked'  All files in DIRECTORY should be mat-files,
%                containing a single dataset. All datasets should have the 
%                same label list and the same feature size.
% TYPE='mature'  This is a datafile directory constructed by SAVEDATAFILE. 
%                It executes all processing before creation.
% For all datafile types holds that execution of mappings (by FILTM or 
% otherwise and conversion to a dataset (by DATASET) is postponed as long as 
% possible. Commands are stored inside one of the datafile fields. 
% Consequently, errors might be detected at a later stage.
%
% The construction by DATAFILE still might be time consuming as for some types
% all files have to be checked. For that reason PRTools attempts to save a 
% mat-file with the DATAFILE definition in DIRECTORY. If it is encountered, it 
% is loaded avoiding a redefinition. 
%
% SEE ALSO
% DATAFILES, DATASETS, MAPPINGS, FILTM, SAVEDATAFILE, CREATEDATAFILE

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function b = datafile(datadir,type,readcmd,varargin)

	prtrace(mfilename,1);
	
	if nargin < 3, readcmd = 'imread'; end
	if nargin < 2, type = 'raw'; end
  
	b.files   = []; % file names
	b.rootpath= []; % rootpath
	b.type    = []; % datafile type
	b.preproc = []; % desired preprocessing
	b.postproc= mapping([]); % stored mappings for postprocessing
	
	b = class(b,'datafile',dataset);
	superiorto('double','dataset');
	
	if nargin == 0 %return empty datafile in case of no input parameters
		return
	end

	b = set(b,'version',prtver);
	b.type = type;
	
	if isempty(datadir) % return empty datafile
		return
	elseif ~isstr(datadir)
	  error('Directory should be given in string')
	elseif exist(datadir) == 7
		; % OK
	else
		if exist(datadir) == 0
			error('Directory not found')
		else
			error('Input is confusing (e.g. a Matlab command). Give full path or rename directory')
		end
	end
	
%	if isempty(strmatch(type,strvcat('raw','pre-cooked','half-baked','mature'),'exact'))
%		error('Non-existing datafile type supplied')
%	end
		
	% make sure datadir contains full path
	if (datadir(end) == filesep) | (datadir(end) == '/')
		datadir(end) = [];
	end
	dirinfo = what(datadir);
	[rpath,name,ext] = fileparts(dirinfo(end).path);
	rootpath = dirinfo(end).path;
	b.rootpath = rootpath;
	%b.rootpath = fullfile(rootpath,name);
	
	dirname = [name ext];
	%datadir= fullfile(rootpath,dirname);
	
  matname = fullfile(datadir,[dirname '.mat']);
	if exist(matname,'file') & ~strcmp(type,'patch') % pre-defined datafiles expected here
		% datafile already created and available as mat-file?
	  s = load(fullfile(datadir,[dirname '.mat']));  % yes, load it
		f = fieldnames(s);
		b = s.(f{1});
		b = setident(b); % convert old ident structures
		b.rootpath = rootpath;
	elseif strcmp(type,'raw')
		lablist = dirlist(datadir); % subdirs in datadir become labels
    b = setfiles(b,lablist); % in setfiles the real work is done
		if isempty(b.dataset.ident)
			error('No proper (non-mat) files found in directory. Impossible to construct raw datafile.')
		end
		b = setpreproc(b,readcmd,varargin);
    b.dataset = setlablist(b.dataset,lablist);
		nlab = getident(b,'file_index');
		nlab = nlab(:,1) - 1;
    b.dataset = setnlab(b.dataset,nlab);
    b.dataset = setobjsize(b.dataset,length(nlab));
		b = set(b,'name',dirname);
		savemat(matname,b);
  elseif strcmp(type,'cell')
    b = setfiles(b,datadir);
    lablist = getfiles(b);
    for j=1:length(lablist)
      [pp,name,ext] = fileparts(lablist{j});
      lablist{j} = name;
    end
    b.dataset = setlablist(b.dataset,lablist);
    nlab = getident(b,'file_index');
    nlab = nlab(:,1);
    b.dataset = setnlab(b.dataset,nlab);
    b.dataset = setobjsize( b.dataset,length(nlab));
    b = set(b,'name',dirname);
		savemat(matname,b);
  elseif strcmp(type,'patch') % is this really used somewhere?
		if isempty(varargin) | length(varargin) < 3
			error('No or insufficient patch parameters found') 
		elseif length(varargin) == 3
			b.preproc(1).preproc = readcmd;
			b.preproc(1).pars = [];
			b.preproc(2).preproc = 'im_patch';
			b.preproc(2).pars = varargin;
		else
			b.preproc(1).preproc = readcmd;
			b.preproc(1).pars = varargin(1:end-3);
			b.preproc(2).preproc = 'im_patch';
			b.preproc(2).pars = varargin(end-2:end);
		end
    b = setfiles(b,datadir);
    lablist = getfiles(b);
    for j=1:length(lablist)
      [pp,name,ext] = fileparts(lablist{j});
      lablist{j} = name;
    end
    b.dataset = setlablist(b.dataset,lablist);
    nlab = getident(b,'file_index');
    nlab = nlab(:,1);
    b.dataset = setnlab(b.dataset,nlab);
    b.dataset = setobjsize( b.dataset,length(nlab));
		b.dataset = setfeatsize(b.dataset,getfeatsize(b));
    b = set(b,'name',dirname);
		%savemat(matname,b);      % better not to save as same dir may be used
		                          % for other datafiles
	elseif strcmp(type,'half-baked') % combine all mat-files, expect datasets
		b = setfiles(b,datadir);
		b = set(b,'name',dirname);
		L = getident(b);  % rank objects according to idents
		[LL,J] = sort(L); % this is relevant for dissimilarity matrices
		%b = b(J,:)       % I want this, but ...
		data = b.dataset; % Matlab forces me to do it like this
		data = data(J,:);
		b.dataset = data;
		savemat(matname,b);
	elseif strcmp(type,'pre-cooked')
		b.preproc.preproc = readcmd;
		b.preproc.pars = varargin;
		b = setfiles(b,datadir);
		b = set(b,'name',dirname);
		savemat(matname,b);
	elseif strcmp(type,'mature')
    % mature file with missing mat-file
    error('No proper mat-file found')
  elseif nargin > 1
    % second parameter is not a proper type
    % may be it is a read-command for raw datafiles, try it
		try
			if nargin == 2
				b = datafile(datadir,'raw',type);
			elseif nargin == 3
				b = datafile(datadir,'raw',type,readcmd);
			else
				b = datafile(datadir,'raw',type,{readcmd varargin{:}});
			end
		catch
			error('Unparsable arument list in call to datafile()')
		end
  else
    error('Data directory not found or wrong')
  end
        
	% We are done, return datafile.
	
return

function names = dirlist(dirpath)
% directory name and path from root
		dirpath = deblank(dirpath);
		ss = what(dirpath);
		[rootpath,name,ext] = fileparts(ss(end).path);
		dirname = [name ext];
		
	% remove all .-files / dirs
		ddir = dir(dirpath);
		names = {ddir(:).name};
		cnames = char(names);
	% remove all .-files / dirs
		J = find(cnames(:,1) == '.');
		names(J) = [];
		cnames(J,:) = [];
	% get rid of Windows db files
		J = strmatch('Thumbs.db',cnames,'exact');
		names(J) = [];
	% we now have all filenames and dirnames in dirpath
	% find out whether they are proper
	% and what are the files and what the directories
    ftype = zeros(length(names),1);
    for j=1:length(names)
      ftype(j) = exist(fullfile(rootpath,dirname,names{j}));
    end
    if ~all(ftype == 2 | ftype == 7)
      error('Files should be ordinary data files or directories')
    end
		J = find(ftype == 7);
    names = names(J);

		function savemat(matname,b)
		try
    	save(matname,'b');
		catch
			prwarning(1,'Datafile could not be saved');
		end
		
		