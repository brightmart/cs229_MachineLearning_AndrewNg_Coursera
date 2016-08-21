function [theta] =bright_gainModelUsingLinear2(y)
%load X from CSV
X=csvread('zcf_second_app2_processed_2.csv');
%print X
pause;
sizeOfX=size(X)
sizeOfy=size(y)
pause;
recordsForTraining=127; %120 for training
recordsForCV=length(y)-recordsForTraining; % the rest, like 32 records for cross validation
%% =========== Part 5: Learning Curve for Linear Regression =============
%  Next, you should implement the learningCurve function. 

%% =========== Part 6: Feature Mapping for Polynomial Regression =============
% Map X onto Polynomial Features and Normalize
X_poly = bright_polyFeatures(X);
sizeOfX_poly=size(X_poly)
pause;
%[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Value is zero or one, will not need to normalize again more%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save('mu.mat','mu');
%save('sigma.mat','sigma');
m=size(X_poly,1);
X_poly = [ones(m, 1), X_poly] ;                   % Add Ones
sizeX_poly=size(X_poly)
pause;
idx=randperm(length(y));%%%%%%%%%%%%%%%%%%%%%TODO change it
%idx=idx(1:recordsForTraining);
%Xtrain=X_poly(idx,:);
%ytrain=y(idx,:);
%Xval=X_poly;
%Xval(idx,:)=[];
%yval=y;
%yval(idx,:)=[];
%X=Xtrain;
%y=ytrain;
Xtrain=X_poly(idx(1:recordsForTraining),:);
ytrain=y(idx(1:recordsForTraining));
Xval=X_poly(idx(recordsForTraining+1:end),:);
yval=y(idx(recordsForTraining+1:end));
X=Xtrain;
y=ytrain;
sizeXX=size(X)
sizeyy=size(y)
pause;
fprintf('Normialized...');
numberOfFeatures=size(X,2)
theta=ones(numberOfFeatures,1); %recordsForTraining     
bestLambda=0;
Jmin=10000000;
bestTheta=zeros(numberOfFeatures,1);
lambdas=[0,0.3,0.5,0.75,1,1.25,1.5,1.75,2,2.5,3,4,5,10,20,40,80];
%lambdas=[3]; BEST LAMBDA=2
sizeOfX=size(X)
sizeOfTheta=size(theta)
fprintf('Program paused. Press enter to continue.\n');
pause;

for k=1:length(lambdas);
[theta] = trainLinearReg(X, y, lambdas(k)); 

%Predict cross validation set using theta
sizeOfTheta=size(theta)
 [J, grad] = linearRegCostFunction(Xval, yval, theta, 0);
 if J<Jmin
     Jmin=J;
     bestLambda=lambdas(k);
     bestTheta=theta;
 end;
end;

%theta=bestLambda
predict=Xval*bestTheta;
for i=1:recordsForCV
fprintf(['Predict, yval = [1 ; 1]:  [%f; %f] '...
        '\n(\n'], ...
        predict(i), yval(i));
end;
bestLambda2=bestLambda
Jmin
pause;
%[theta] = trainLinearReg(X, y, 0.03); %ones(recordsForTraining, 1)
save('bestThet.mat','bestTheta');
%% =========== Part 7: Learning Curve for Polynomial Regression =============
%  Now, you will get to experiment with polynomial regression with multiple
%  values of lambda. The code below runs polynomial regression with 
%  lambda = 0. You should try running the code with different values of
%  lambda to see how the fit and learning curve change.
plot(1:recordsForCV,yval, 1:recordsForCV,predict,'MarkerSize', 1,'LineWidth', 1);%recordsForCV
title('手机保修查询--二手iPhone估价系统');
legend('二手iPhone实际价格', '二手iPhone估价');
xlabel('交叉检验样本（序号）');
ylabel('价格');