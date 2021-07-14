if 1==0
	d=5;
	a=+gendats([50 50],2,d);
	g = [1 2 3 5 10 20 40 50 100];

	for r=1:10
		for i=1:length(g)
			[p,lab,ws(r,i)] = kmclust(a,g(i),0,0);
		end
		ws(r,:) = ws(r,:)/ws(r,1);
	end

	mws = mean(ws,1);
	sws = std(ws,[],1);
	errorbar(g,mws,sws);
end

load triclust;

