function []=bright_reg_learnCurve(Xreg, yreg, XregCV, yregCV, lambda)
% learn curve shows out the relationship between number of tranning and
% cost function(both training set and cross validation)

%% =========== Part 5: Learning Curve for Linear Regression =============
%  Next, you should implement the learningCurve function. 
%
%  Write Up Note: Since the model is underfitting the data, we expect to
%                 see a graph with "high bias" -- slide 8 in ML-advice.pdf 
%
m = size(Xreg, 1);
X=Xreg;
y=yreg;
Xval=XregCV;
yval=yregCV;
lambda = 3;
[error_train, error_val] = ...
    learningCurve( X, y, ...
                  Xval, yval, ...
                  lambda);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
%axis([0 200 0 10])
save('bright_reg_error_train.mat','error_train');
save('bright_reg_error_val.mat','error_val');

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;