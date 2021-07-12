%DISPLAY Display dataset information

% $Id: display.m,v 1.2 2006/03/08 22:06:58 duin Exp $

function display(a)
	prtrace(mfilename,2);

	if (isempty(a))
   disp('Empty dataset.')
	else
		[m,k,c] = getsize(a);
		if c == 1
			clas = ' class';
		else
			clas = ' classes';
		end
		m = num2str(m);
		k = num2str(k);
		c = num2str(c);
		if (~isempty(a.name))
			name = [a.name ', '];
		else
			name = '';
		end
		
		switch a.labtype
			case 'crisp'
				siz = num2str(classsizes(a));
				disp([name m ' by ' k ' dataset with ' c clas ': [' siz ']'])
			case 'soft'
				disp([name m ' by ' k ' dataset with ' c ' soft ' clas])
			case 'targets'
				disp([name m ' by ' k ' dataset with ' c ' targets'])
			end
		end
return;

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------

fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------
fp: /home/goncalo/Documents/RUG/TA_Positions/BioCS/BioSB/BioSB-MachineLearning-2020/website/Data_and_code/Data and code/prtools4112/@dataset/display.m
 fn: display -------------
