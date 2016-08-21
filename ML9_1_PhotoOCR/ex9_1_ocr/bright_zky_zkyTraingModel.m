function [zkyTheta1 zkyTheta2]=bright_zky_zkyTraingModel()
%CHARACTERSEGMENTATION character segmentation
% input_layer_size,hidden_layer_size,num_labels,dirr, lambda
%dirr='D:\home\dividedManulForzky\' %D:\home\dividedManulForzky
load('bright_zky_zkyAllData.mat');
[superZkyXCV,superZkyyCV]=bright_zky_cuttingImage(XzkyCV,yzkyCV);
[superZkyX,superZkyy]=bright_zky_cuttingImage(Xzky,yzky);

input_layer_size=100;
hidden_layer_size=25; %10
num_labels=10; 

X=superZkyX;
y=superZkyy;
size1=size(X,1);
size2=size(X,2);

%% =================== Part 1: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network for character zky 364 ... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter',500);   

%  You should also try different values of lambda
lambdas=[0,0.01,0.03,0.1,0.3,1,3,6,9,30,60,100,1000,5000];
lambdas=[0.1];%0.1
hidden_layer_sizes=[25]; %--¡·90%[60,90,150]; %10,20,30,40,

minCost=10000;
bestLambda=10000;
for i=1:length(lambdas);%lambdas
 % Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambdas(i));

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)

fprintf('\nInitializing Neural Network Parameters ...\n')
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
 [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size,  num_labels, superZkyXCV, superZkyyCV, 0); %XzkyCV,yzkyCV            
if J<minCost
   bestLambda =lambdas(i)
   minCost=J
   bestNn_params=nn_params;
end;
end;
nn_params=bestNn_params;
% Obtain Theta1 and Theta2 back from nn_params
zkyTheta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

zkyTheta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
save('bright_zky_data_Theta1Theta2.mat','zkyTheta1','zkyTheta2','bestLambda','minCost');
fprintf('Program paused. Press enter to continue.\n');
pause;
%bright_zky_predictOnTraingCVTesting(zkyTheta1,zkyTheta2,Xzky,yzky,XzkyCV,yzkyCV,XzkyTest,yzkyTest)