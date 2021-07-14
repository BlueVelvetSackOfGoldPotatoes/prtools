% DICHINO - Ichino distance measure for categorical variables
%
%      out=dichino(data,proto,gamma,feat)
%
% in : data - categorical data
%      proto - categorical data (prototypes)
%      gamma - distance parameter (gama = <0,0.5>, opt, default=0)
%      feat - structure with feature information
%         .type - the type of features
%                 1 - real or integer value
%                 2 - ordinal value
%                 3 - nominal value
%         .norm - normalization factor
%         .w - feature weights
%      q - coefficient for Minkowski distance
% out: out - Ichino distance matrix
%
% $Id: dichino.m,v 1.1 2002/04/17 11:24:58 pavel Exp $

function out=dichino(data,proto,gamma,feat,q)

if ~exist('gamma','var'), gamma=0; end
if ~exist('q','var'), q=2; end

sc=size(data,1);
pc=size(proto,1);

% indices of feature types
freal=find(feat.type==1);
ford=find(feat.type==2);
fnom=find(feat.type==3);

if ~isfield(feat,'w')
  feat.w=ones(1,size(feat.type,2));
end

lab=renumlab(getlab(data)); % prototype labels
plab=renumlab(getlab(proto)); % prototype labels
data=+data;
proto=+proto;

out=zeros(sc,pc);

gamma=2*gamma;

for i=1:sc
  % real features
  if ~isempty(freal)
    t=repmat(proto(i,freal),sc,1);
    t=abs(data(:,freal)-t);
    out(i,:)=feat.w(freal).*(sum(t./repmat(feat.norm(freal),sc,1), 2)').^q;
  end
  
  % ordinal features
  if ~isempty(ford)
    t=repmat(proto(i,ford),sc,1);
    t2=data(:,ford)==t; % A_j == B_j
    t=1+abs(data(:,ford)-t) - t2 + gamma * t2 - gamma; 
    out(i,:)=out(i,:) + feat.w(ford).*(sum( t./repmat(feat.norm(ford),sc,1), 2 )').^q;
  end
  
  % nominal features
  if ~isempty(fnom)
    t=repmat(proto(i,fnom),sc,1);
    t2=data(:,fnom)==t; % A_j == B_j
    t=2*not(t2) + gamma * t2 - gamma;
    out(i,:)=out(i,:) + feat.w(fnom).*(sum( t./repmat(feat.norm(fnom),sc,1), 2 )').^q;
  end  
  
end
out=dataset(out.^(1/q),lab,plab);