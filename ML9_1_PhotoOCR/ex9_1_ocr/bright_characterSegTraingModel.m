function [segTheta1 segTheta2]=bright_characterSegTraingModel()
%CHARACTERSEGMENTATION character segmentation
% input_layer_size,hidden_layer_size,num_labels,dirr, lambda
dirr='D:\english\appleVerfCode-LabelledForCutting50\';
input_layer_size=2030;
hidden_layer_size=50;
num_labels=2;
lambda=0.3;
[Xseg yseg Xcv ycv Xtest ytest]=bright_getXsegysegForSegCutting(dirr);
X=Xseg;
y=yseg;
size1=size(X,1);
size2=size(X,2);

%% =================== Part 1: Training NN ===================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.
%
fprintf('\nTraining Neural Network for character segmentation ... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 100); %50 -->94

%  You should also try different values of lambda
%lambda = 0.15; %1

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)

fprintf('\nInitializing Neural Network Parameters ...\n')
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
segTheta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

segTheta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
save('bright_Theta1_CharacterSeg.mat','segTheta1');
save('bright_Theta2_CharacterSeg.mat','segTheta2');
fprintf('Program paused. Press enter to continue.\n');
pause;
bright_predictOnTraingCVTesting(segTheta1,segTheta2,Xseg,yseg,Xcv,ycv,Xtest,ytest);