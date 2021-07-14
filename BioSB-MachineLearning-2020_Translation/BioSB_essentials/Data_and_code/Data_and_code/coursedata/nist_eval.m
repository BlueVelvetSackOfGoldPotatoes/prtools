%NIST_EVAL Evaluation of NIST digits classifier
%
%		E = NIST_EVAL(DIG2DATA,W,N)
%
% INPUT
%   DIG2DATA  M-File to convert digits images into a dataset
%   W         Classifier
%   N         Number of digits per class to be used (default 100);
%
% OUTPUT
%   E         Estimate of classification error
%
% DESCRIPTION
%   This routine reads N digits per class (0:9) into a datafile.
%   DIG2DATA is used to convert them into a dataset.  DIG2DATA should
%   be given by the name (string) of an m-file in the search path. The
%   resulting dataset is given to the classifier W to test it.

