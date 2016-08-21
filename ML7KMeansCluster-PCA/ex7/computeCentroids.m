function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returs the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);
% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%
%Compute using vectorization(without sub loop)
oneVector=ones(1,n);
for i=1:K 
    centroid=zeros(1,n);
    v=idx==i; %O.K.[0 1 1 ...0 1]'
    countt=sum(v);
    superV=v*oneVector; %O.K.[0 1 1 ...0 1;0 1 1 ...0 1]'
    centroid=superV.*X; %  --->[2 0 0 3 0 5...; 3 0 0 7 0 4...]'
    centroid=sum(centroid)/countt;
    centroids(i,:)=centroid;
end;


%Compute using loop
%for i=1:K 
%    centroid=zeros(1,n);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    countt=0;
%    for j=1:length(idx) %
%      if idx(j)==i %
%         centroid=centroid+X(j,:); %
%         countt=countt+1; %
%      end; %
%   end; %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %   centroid=centroid/countt;
 %   centroids(i,:)=centroid;
%end;






% =============================================================


end

