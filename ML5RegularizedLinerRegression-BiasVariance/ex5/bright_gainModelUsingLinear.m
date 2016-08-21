function [theta] =bright_gainModelUsingLinear(X,y)
sizeOfX=size(X)
sizeOfy=size(y)
recordsForTraining=130; %120 for training
recordsForCV=length(y)-recordsForTraining; % the rest, like 32 records for cross validation

%Xval=[ones(recordsForCV,1) Xval];
%predict=Xval*theta
%fprintf('New X.');
%plot(predict,yval);
%plot(1:recordsForCV, yval, 1:recordsForCV, predict);
%title('Predict mobile price using linear regression');
%legend('Real', 'Predicted');
%xlabel('Cross Validation Examples. from 1,2,...')
%ylabel('Price')
%save predict


%% =========== Part 5: Learning Curve for Linear Regression =============
%  Next, you should implement the learningCurve function. 
%
%  Write Up Note: Since the model is underfitting the data, we expect to
%                 see a graph with "high bias" -- slide 8 in ML-advice.pdf 
%

%lambda = 0;
%[error_train, error_val] = ...
 %   learningCurve([ones(m, 1) X], y, ...
 %                 [ones(size(Xval, 1), 1) Xval], yval, ...
 %                 lambda);

%plot(1:m, error_train, 1:m, error_val);
%title('Learning curve for linear regression')
%legend('Train', 'Cross Validation')
%xlabel('Number of training examples')
%ylabel('Error')
%axis([0 13 0 150])

%% =========== Part 6: Feature Mapping for Polynomial Regression =============
%  One solution to this is to use polynomial regression. You should now
%  complete polyFeatures to map each example into its powers
%


% Map X onto Polynomial Features and Normalize
X_poly = bright_polyFeatures(X);
sizeOfX_poly=size(X_poly)
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize TODO TODO
save('mu.mat','mu');
save('sigma.mat','sigma');
m=size(X_poly,1);
X_poly = [ones(m, 1), X_poly] ;                   % Add Ones

idx=randperm(length(y));
idx=idx(1:recordsForTraining);
Xtrain=X_poly(idx,:);
ytrain=y(idx,:);
Xval=X_poly;
Xval(idx,:)=[];
yval=y;
yval(idx,:)=[];

Xval2=size(Xval)
yval2=size(yval)
print '2222222222222222222222222'
%Xtrain=X_poly(1:recordsForTraining,:); %allocate Xtrain data set
%ytrain=y(1:recordsForTraining,:);
%Xval=X_poly(recordsForTraining+1:end,:); %allocate Xval data set
%yval=y(recordsForTraining+1:end,:);
X=Xtrain;
y=ytrain;
%[X_norm, mu, sigma] = featureNormalize(X);
%X=X_norm;
%[Xval_norm, mu, sigma] = featureNormalize(Xval);
%Xval=Xval_norm;
fprintf('Normialized...');
numberOfFeatures=size(X,2)
theta=ones(numberOfFeatures,1); %recordsForTraining     
%J = linearRegCostFunction([ones(recordsForTraining, 1) X], y, theta, 1)
bestLambda=0;
Jmin=10000000;
bestTheta=zeros(numberOfFeatures,1);
%lambdas=[0,0.003,0.01,0.03,0.1,0.3,1,2,3,4,5,6,9,10,20,30,40,50,60,70,80,100,150,300,500,600,700,800,830,865,900,930,965,1000,3000,10000];
lambdas=[3];
sizeOfX=size(X)
sizeOfTheta=size(theta)
fprintf('Program paused. Press enter to continue.\n');
pause;

for k=1:length(lambdas);
[theta] = trainLinearReg(X, y, lambdas(k)); %ones(recordsForTraining, 1)
%Xval=[ Xval] %ones(size(Xval,1),1)

%predict traing set using theta
%predictX=X*theta;

%for i=1:recordsForCV
%fprintf(['Predict, y = [1 ; 1]:  [%f; %f] '...
%         '\n(\n'], ...
%         predictX(i), y(i));
%end;

%Predict cross validation set using theta
theta
 [J, grad] = linearRegCostFunction(Xval, yval, theta, 0);
 if J<Jmin
     Jmin=J;
     bestLambda=lambdas(k);
     bestTheta=theta;
 end;
end;
bestLambda
Jmin
%theta=bestLambda
predict=Xval*bestTheta;
for i=1:recordsForCV
fprintf(['Predict, yval = [1 ; 1]:  [%f; %f] '...
        '\n(\n'], ...
        predict(i), yval(i));
end;
%[theta] = trainLinearReg(X, y, 0.03); %ones(recordsForTraining, 1)
save('bestThet.mat','bestTheta');

% Map X_poly_test and normalize (using mu and sigma)
%X_poly_test = polyFeatures(Xtest, p);
%X_poly_test = bsxfun(@minus, X_poly_test, mu);
%X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
%X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % Add Ones

% Map X_poly_val and normalize (using mu and sigma)
%X_poly_val = polyFeatures(Xval, p);
%sizeOfX_poly_val=size(X_poly_val)
%sizeOfMu=size(mu)
%X_poly_val = bsxfun(@minus, X_poly_val, mu);
%X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
%X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % Add Ones

%fprintf('Normalized Training Example 1:\n');
%fprintf('  %f  \n', X_poly(1, :));



%% =========== Part 7: Learning Curve for Polynomial Regression =============
%  Now, you will get to experiment with polynomial regression with multiple
%  values of lambda. The code below runs polynomial regression with 
%  lambda = 0. You should try running the code with different values of
%  lambda to see how the fit and learning curve change.
%

%lambda = 0; % xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx change it. lambda = 0;
%[theta] = trainLinearReg(X_poly, y, lambda);

% Plot training data and fit
%figure(1);
%plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
%plotFit(min(X), max(X), mu, sigma, theta, p);
%xlabel('Change in water level (x)');
%ylabel('Water flowing out of the dam (y)');
%title (sprintf('Polynomial Regression Fit (lambda = %f)', lambda));

%figure(2);
%[error_train, error_val] = ...
 %   learningCurve(X_poly, y, X_poly_val, yval, lambda);
%plot(1:m, error_train, 1:m, error_val);

% Predict again using ploynomial regression
%Xval=[ones(recordsForCV,1) Xval];
%predict=X_poly_val*theta
%fprintf('New X.');
%plot(predict,yval);hold on;
plot(1:recordsForCV,yval, 1:recordsForCV,predict,'MarkerSize', 1,'LineWidth', 1);%recordsForCV
title('手机保修查询--二手iPhone估价系统');
legend('二手iPhone实际价格', '二手iPhone估价');
xlabel('交叉检验样本（序号）');
ylabel('价格');
