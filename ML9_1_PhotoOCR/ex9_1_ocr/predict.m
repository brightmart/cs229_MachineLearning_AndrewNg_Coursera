function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
save('bright_seg_h2','h2');
[dummy, p] = max(h2, [], 2);
if p==1
    keyboard;
end
%fprintf('\nTraining Set Accuracy: %f\n', mean(double(p == yVal)) * 100);
%fprintf('\nTraining Set Accuracy(different less than 100): %f\n', mean(double(abs(p-yVal)<100)) * 100);
% =========================================================================

end
