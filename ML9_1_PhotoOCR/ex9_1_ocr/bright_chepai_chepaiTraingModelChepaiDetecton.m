function [chepaiTheta1 chepaiTheta2]=bright_chepai_chepaiTraingModelChepaiDetecton(dirr2)
%CHARACTERSEGMENTATION character segmentation
% input_layer_size,hidden_layer_size,num_labels,dirr, lambda
%dirr2='D:\home\chepaiCut\'
%load('bright_chepai_chepaiBlocsAllData.mat');

[XchepaiBlock,ychepaiBlock,XchepaiBlockCV,ychepaiBlockCV,XchepaiBlockTest,ychepaiBlockTest]=bright_chepai_readCuttedImages(dirr2)


input_layer_size=1200;
hidden_layer_size=35; %10 
num_labels=2; 

X=XchepaiBlock;
y=ychepaiBlock;
size1=size(X,1);
size2=size(X,2);

%% =================== Part 1: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network for character chepai 364 ... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter',300);   

%  You should also try different values of lambda
lambdas=[0.3];%[0,0.3,0.6,1,2,3];%[1.5];%%[0,0.1,0.3,1,3,6,9,30];%[0,0.01,0.03,0.1,0.3,1,3,6,9,30,60,100,200];
minCost=10000;
bestLambda=10000;
for i=1:length(lambdas);%lambdas
    lambdas(i)
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
 [J grad] = nnCostFunction(nn_params, input_layer_size, hidden_layer_size,  num_labels, XchepaiBlockCV, ychepaiBlockCV, 0); %XchepaiCV,ychepaiCV            
if J<minCost
   bestLambda =lambdas(i)
   minCost=J
   bestNn_params=nn_params;
end;
end;
nn_params=bestNn_params;
% Obtain Theta1 and Theta2 back from nn_params
chepaiTheta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

chepaiTheta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
save('bright_chepai_data_Theta1Theta2.mat','chepaiTheta1','chepaiTheta2','bestLambda','minCost');
fprintf('Program paused. Press enter to continue.\n');
pause;