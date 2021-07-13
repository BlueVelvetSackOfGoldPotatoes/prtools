mex -c qldorg.c
if strcmp(computer,'PCWIN')
	mex qld.c qldorg.obj
else
	mex qld.c qldorg.o
end

