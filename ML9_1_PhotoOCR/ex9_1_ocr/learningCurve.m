function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).
%
%   In this function, you will compute the train and test errors for
%   dataset sizes from 1 up to m. In practice, when working with larger
%   datasets, you might want to do this in larger intervals.
%

% Number of training examples
m = size(X, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);
error_test   = zeros(m, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the cross validation errors in error_val. 
%               i.e., error_train(i) and 
%               error_val(i) should give you the errors
%               obtained after training on i examples.
%
% Note: You should evaluate the training error on the first i training
%       examples (i.e., X(1:i, :) and y(1:i)).
%
%       For the cross-validation error, you should instead evaluate on
%       the _entire_ cross validation set (Xval and yval).
%
% Note: If you are using your cost function (linearRegCostFunction)
%       to compute the training and cross validation error, you should 
%       call the function with the lambda argument set to 0. 
%       Do note that you will still need to use lambda when running
%       the training to obtain the theta parameters.
%
% Hint: You can loop over the examples with the following:
%
%       for i = 1:m
%           % Compute train/cross validation errors using training examples 
%           % X(1:i, :) and y(1:i), storing the result in 
%           % error_train(i) and error_val(i)
%           ....
%           
%       end
%


% ---------------------- Sample Solution ----------------------
input_layer_size=2030;
hidden_layer_size=70;
num_labels=37;
lambdaForJtrainAndVal=lambda;
 for i=1:m
 xi=X(1:i, :);
 yi=y(1:i); 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 options = optimset('MaxIter',100);   
 costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                  num_labels,xi, yi, lambda);
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
 [J_train gradTrain] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size,  num_labels, xi, yi, 0); 
 [J_val gradVal] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size,  num_labels, Xval, yval, 0);  

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %利用X(1:i,:),y(1:i),trainLinearReg(),来训练参数theta
 %theta=trainLinearReg(xi, yi, lambda);
  %训练误差计算只用X(1:i,:), y(1:i)
 %[J_train, gradTraing] = linearRegCostFunction(xi, yi, theta, 0);
  %交叉验证用上所有的验证集，即Xval, yval
% [J_val, gradCV] = linearRegCostFunction(Xval, yval, theta, 0);
 error_train(i)=J_train;
 error_val(i)=J_val;
 end;

% =========================================================================

end







