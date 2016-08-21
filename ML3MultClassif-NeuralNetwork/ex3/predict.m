function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%
X=[ones(size(X,1),1) X]; %O.K.
Z2=Theta1*X'; %O.K.
sizeOfTheta1=size(Theta1)
sizeOfZ2=size(Z2)
A2=sigmoid(Z2);
A22=A2';
sizeOfA22=size(A22)
A222=[ones(size(A22,1),1) A22];
sizeOfA222=size(A222)
Z3=Theta2*A222';
Z33=Z3';
A3=sigmoid(Z33);
[maxV,indexV]=max(A3,[],2);
p=indexV;





% =========================================================================


end
