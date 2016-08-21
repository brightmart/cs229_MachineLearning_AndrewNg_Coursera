function [standTheta1 standTheta2]=bright_standard_standTraingModel()
%CHARACTERSEGMENTATION character segmentation
% input_layer_size,hidden_layer_size,num_labels,dirr, lambda
%dirr='D:\home\dividedManulForstand\' %D:\home\dividedManulForstand
input_layer_size=400;
hidden_layer_size=28; 
num_labels=62; 

load('bright_standard_standAllData.mat');
X=Xstand;
y=ystand;
size1=size(X,1);
size2=size(X,2);

%% =================== Part 1: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network for character stand 60,000+ ... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter',5000);   

%  You should also try different values of lambda
%lambdas=[0,0.01,0.03,0.1,0.3,1,3,6,9,30,60,100];
%lambdas=[0.3,0.5,0.6,0.8,1,1.3,1.6,1.9,2.2,2.5,2.7];
lambdas=[0.5];
hidden_layer_sizes=[28]; %--¡·90%[60,90,150]; %10,20,30,40,

minCost=10000;
bestLambda=10000;
besthidden_layer_size=28;
for i=1:length(hidden_layer_sizes);%lambdas
    hidden_layer_size=hidden_layer_sizes(i)
 % Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambdas(1));

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)

fprintf('\nInitializing Neural Network Parameters ...\n')
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
 [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size,  num_labels, XstandCV, ystandCV, 0);             
if J<minCost
   bestLambda =lambdas(1)
   minCost=J
   bestNn_params=nn_params;
   besthidden_layer_size=hidden_layer_size;
end;
end;
nn_params=bestNn_params;
hidden_layer_size=besthidden_layer_size;
% Obtain Theta1 and Theta2 back from nn_params
standTheta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

standTheta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
save('bright_stand_data_Theta1Theta2.mat','standTheta1','standTheta2','bestLambda','minCost');
fprintf('Program paused. Press enter to continue.\n');
pause;
%bright_stand_predictOnTraingCVTesting(standTheta1,standTheta2,Xstand,ystand,XstandCV,ystandCV,XstandTest,ystandTest)