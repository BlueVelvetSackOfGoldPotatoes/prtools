%DISNORM Normalisation of dissimilarity matrix
%
%	D = disnorm(D)
%
% Maximum dissimilarity is set to 1 by global rescaling.

% $Id: disnorm.m,v 1.2 2001/07/10 16:36:32 pavel Exp $

function d = disnorm(d)
m = max(max(d));
d = d./m;
