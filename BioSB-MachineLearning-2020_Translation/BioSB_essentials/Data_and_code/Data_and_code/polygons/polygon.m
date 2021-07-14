%POLYGON Define polygon from contour
%
%	P = POLYGON(C)
%
% If C is a Matlab defined contour as produced by CONTOUR and IMCONTOUR
% (see CONTOURC) then P is converted to a (n+1) x 2 array storing all
% coordinates of the contour. The first and the last coordinates are equal.
% If C contains more than a single contour, P is a cell array in which
% each cell contains a single polygon.
%
% Alternatively C may be a n*2 matrix of coordinates or a file.
% Lines starting by '#' or '%' will be neglected. Contours are closed before
% they are stored as a polygon.
%
% See CONTOUR, IMCONTOUR, CONTOURC

% Copyright: R.P.W. Duin, r.p.w.duin@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands

function p = polygon(c)
	
	if isstr(c)
		
		if exist(c) ~= 2
			error('File not found')
		end
			
		[pp,nn,ee] = fileparts(c);
		if strcmp(ee,'.mat')
			p = load(c);
		else
			fid = fopen(c);
			if fid < 0
				error(['Cann''t open ' file])
			end
			p = [];
			while 1
				line = fgetl(fid);
				if ~isstr(line), break, end
				if line(1) ~= '%' & line(1) ~= '#'
					p = [p; sscanf(line,'%f')'];
				end
			end
			fclose(fid);
		end
		p = polyclose(p);
		
	else
		
		if size(c,2) == 2
			p = polyclose(c);
		elseif size(c,1) == 2
			p = {};
			while ~isempty(c)
				d = polyclose(c(:,2:c(2,1)+1)');
				p = {p{:},d};
				c(:,1:c(2,1)+1) = [];
			end
			if length(p) == 1
				p = p{1};
			end
		else
			error('Input cannot be converted to polygon')
		end
	
	end


