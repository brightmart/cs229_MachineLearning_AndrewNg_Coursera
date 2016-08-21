function [X_poly] = bright_polyFeatures(X)
%POLYFEATURES Maps X (1D vector) into the p-th power
%   [X_poly] = POLYFEATURES(X, p) takes a data matrix X (size m x 1) and
%   maps each example into its polynomial features where
%   X_poly(i, :) = [X(i) X(i).^2 X(i).^3 ...  X(i).^p];
%% You need to return the following variables correctly.
% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power. 
columnsOfX=size(X,2)
rowsOfX=size(X,1)
X_poly=zeros(rowsOfX,columnsOfX*(columnsOfX+1));
X2=[ones(size(X,1),1) X];
index=1;
for i=1:columnsOfX+1;
    for j=1:columnsOfX;
     X_poly(:,index)=X2(:,i).*X(:,j);
     index=index+1;
    end;
end;
X_poly
% =========================================================================
end


