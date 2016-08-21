function idx = findClosestCentroids(X, centroids)

%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%
  %XSuperTemp=oneVector*Xtemp; ---->
    %[1.8421,4.6076]
    %[1.8421,4.6076]
    %.....
    %[1.8421,4.6076]
numberOfTrainingSet=size(X,1);
oneVector=ones(K,1);
for i=1:numberOfTrainingSet  
    Xtemp=X(i,:); % first X--->[1.8421,4.6076]
    XSuperTemp=oneVector*Xtemp;
    sumVector=sum((XSuperTemp-centroids).^2,2);
    [localMinValue,index]=min(sumVector);
    idx(i)=index;
end;
%Xtemp=zeros(1,m);
%for i=1:numberOfTrainingSet  
%    minDiff=100000;
 %   Xtemp=X(i,:) % first X--->[1.8421,4.6076]
%   for j=1:K
 %       centroid=centroids(j,:); % first centroid--->[3 3]
  %      diffBetweenXAndJ=sum(sum((Xtemp-centroid).^2));
  %     if  diffBetweenXAndJ<=minDiff;
   %        minDiff=diffBetweenXAndJ;
   %        idx(i)=j
  %     end;
 %   end;
%end;


% =============================================================

end

