% Viterbi algorithm for the (profile) HMM example in the lecture notes
%
% Requires Kevin Murphy's toolboxes (HMM, KPMtools, and KPMstats)
% on your path, executing startup.m should take care of this.
%
% PM281108

close all;
clear all; 
clc;
echo on;

% 7 states, 4 symbols
prior    = [1 0 0 0 0 0 0];
transmat = [0 1 0 0 0 0 0;0 0 1 0 0 0 0;0 0 0 0.6 0.4 0 0;0 0 0  ...
	    0.4 0.6 0 0;0 0 0 0 0 1 0;0 0 0 0 0 0 1;0 0 0 0 0 0 0];
obsmat   = [0.8 0 0 0.2;0 0.8 0.2 0; 0.8 0.2 0 0;0.2 0.4 0.2 0.2;1 ...
	    0 0 0;0 0 0.2 0.8;0 0.8 0.2 0];

% the consensus sequence ACACATC
B = multinomial_prob([1 2 1 2 1 4 2], obsmat);

[a,b,g,loglik] = fwdback(prior, transmat, B,'fwd_only',1);
loglik
% and indeed loglik = log(0.8^5*0.6^2*0.4 + 0.8^3*0.6*0.4^5*0.2^2) 
pause; % press a key to continue 

[path,loglik] = viterbi_path(prior, transmat, B);
loglik
path
% and indeed loglik = log(0.8^5*0.6^2*0.4)=log(0.047) and path = [1
% 2 3 4 5 6 7] 
echo off;