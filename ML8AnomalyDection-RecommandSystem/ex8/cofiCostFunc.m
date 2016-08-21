function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%
%sizeParams=size(params);
% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
%sizeX=size(X);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);
%sizeTheta=size(Theta);
%sizeY=size(Y);
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%22.224604 
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%
% cost function J
predict=X*Theta';
error=(predict-Y).*R;
squaredError=error.^2; %squared error
sumOfSquaredError=sum(sum(squaredError)); %sum of squared error.
J=(1/2)*sumOfSquaredError; %cost function value

% grad of X and Theta
X_grad=error*Theta; % X_grad
Theta_grad=error'*X;

% regularized cost function
squaredTheta=Theta.^2;
sumOfSqauredTheta=sum(sum(squaredTheta));
regularizedTermForTheta=(lambda/2)*sumOfSqauredTheta;
squaredX=X.^2;
sumOfSqauredX=sum(sum(squaredX));
regularizedTermForX=(lambda/2)*sumOfSqauredX;
J=J+regularizedTermForTheta+regularizedTermForX;

% regularized grad
regularizedTermForXOfGrad=lambda*X;
X_grad=X_grad+regularizedTermForXOfGrad;
regularizedTermForThetaOfGrad=lambda*Theta;
Theta_grad=Theta_grad+regularizedTermForThetaOfGrad;










% =============================================================

grad = [X_grad(:); Theta_grad(:)];

end
