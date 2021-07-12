%READLINKS Read links stored for PRTools distribution

function [links,mod] = readlinks

	try
		s = urlread('http://prtools.org/files/prtoolslinks.txt');
	catch
		links = [];
		mod = '';
		return
		%error('Error in reaching PRTools web links');
	end

	s = strrep(s,char([10 13]),newline);
	s = strrep(s,char([13 10]),newline);
	s = strrep(s,char([10]),newline);
	s = strrep(s,char([13]),newline);
	K = strfind(s,'link:');
	n = length(K);
	K(n+1) = length(s);
	links = cell(1,n);
	for j=1:n
		t = s(K(j):K(j+1)-1);
		h1 = strfind(t,'http');
		if isempty(h1)
			error('No links found');
		end
		h2 = strfind(t,newline);
		if isempty(h2), h2 = inf; end
		if isinf(h2), t = t(h1:end); mod = [];
		else	mod = t(h2+2:end); t = t(h1:h2-1); end
		links{j} = t;
	end
	
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/private/readlinks.m
 fn: readlinks -------------
