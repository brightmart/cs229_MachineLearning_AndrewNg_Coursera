function []=bright_secondApple()
%BRIGHT_SECONDAPPLE

%load or get X
X=csvread('zcf_second_app2_processedSingleX.csv');
%predict
load('bestThet.mat')
X2=bright_polyFeatures(X);
m=size(X,1)
X3 = [ones(m, 1), X2] ;  % Add Ones
save('X3.mat','X3')

sizeX2=size(X3)
sizeTheta=size(bestTheta)
predict=X3*bestTheta