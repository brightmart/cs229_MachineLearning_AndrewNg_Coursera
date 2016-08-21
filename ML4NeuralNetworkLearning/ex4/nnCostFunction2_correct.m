function [J grad] = nnCostFunction(nn_params, ...  
                                   input_layer_size, ...  
                                   hidden_layer_size, ...  
                                   num_labels, ...  
                                   X, y, lambda)  
%NNCOSTFUNCTION Implements the neural network cost function for a two layer  
%neural network which performs classification  
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...  
%   X, y, lambda) computes the cost and gradient of the neural network. The  
%   parameters for the neural network are "unrolled" into the vector  
%   nn_params and need to be converted back into the weight matrices.   
%   
%   The returned parameter grad should be a "unrolled" vector of the  
%   partial derivatives of the neural network.  
%  
  
% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices  
% for our 2 layer neural network  
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...  
                 hidden_layer_size, (input_layer_size + 1));  
  
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...  
                 num_labels, (hidden_layer_size + 1));  
  
% Setup some useful variables  
m = size(X, 1);  
           
% You need to return the following variables correctly   
J = 0;  
Theta1_grad = zeros(size(Theta1));  
Theta2_grad = zeros(size(Theta2));  
  
% ====================== YOUR CODE HERE ======================  
% Instructions: You should complete the code by working through the  
%               following parts.  
%  
% Part 1: Feedforward the neural network and return the cost in the  
%         variable J. After implementing Part 1, you can verify that your  
%         cost function computation is correct by verifying the cost  
%         computed in ex4.m  
%  
% Part 2: Implement the backpropagation algorithm to compute the gradients  
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of  
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and  
%         Theta2_grad, respectively. After implementing Part 2, you can check  
%         that your implementation is correct by running checkNNGradients  
%  
%         Note: The vector y passed into the function is a vector of labels  
%               containing values from 1..K. You need to map this vector into a   
%               binary vector of 1's and 0's to be used with the neural network  
%               cost function.  
%  
%         Hint: We recommend implementing backpropagation using a for-loop  
%               over the training examples if you are implementing it for the   
%               first time.  
%  
% Part 3: Implement regularization with the cost function and gradients.  
%  
%         Hint: You can implement this around the code for  
%               backpropagation. That is, you can compute the gradients for  
%               the regularization separately and then add them to Theta1_grad  
%               and Theta2_grad from Part 2.  
%  
%#计算每层的结果，记得要把bias unit加上，第一次写把a1 写成了 [ones(m,1); X];  
a1 = [ones(m,1) X];  
z2 = Theta1 * a1';  
a2 = sigmoid(z2);  
a2 = [ones(1,m); a2]; %#这里 a2 和 a1 的格式已经不一样了，a1是行排列，a2是列排列  
z3 = Theta2 * a2;  
a3 = sigmoid(z3);  
  
%# 首先把原先label表示的y变成向量模式的output，下面用了循环  
y_vect = zeros(num_labels, m);  
for i = 1:m,  
    y_vect(y(i),i) = 1;  
end;  
  
%#每一training example的cost function是使用的向量计算，然后for loop累加所有m个training example  
%#的cost function  
for i=1:m,  
    J =J+ sum(-1*y_vect(:,i).*log(a3(:,i))-(1-y_vect(:,i)).*log(1-a3(:,i)));  
end;  
J = J/m;  
  
%#增加regularization，一开始只写了一个sum，但其实theta1 2 分别都是矩阵，一个sum只能按列累加，bias unit的theta不参与regularization  
J = J + lambda*(sum(sum(Theta1(:,2:end).^2))+sum(sum(Theta2(:,2:end).^2)))/2/m
  
%#backward propagation  
%#Δ的元素个数应该和对应的theta中的元素的个数相同  
Delta1 = zeros(size(Theta1));  
Delta2 = zeros(size(Theta2));  
for i=1:1,  
    delta3 = a3(:,i) - y_vect(:,i);
      
   % #注意这里的δ是不包含bias unit的delta的，毕竟bias unit永远是1，  
   % #不需要计算delta, 下面的2:end,: 过滤掉了bias unit相关值 
   part1=(Theta2'*delta3);
   %sizeOfPart1=size(part1)
   %sizeOfPart2toEnd=size(part1(2:end))
   %sizeOfPart2toEnd2=size(part1(2:end,:))
    delta2 = (part1(2:end,:)).*sigmoidGradient(z2(:,i));  
   % #移除bias unit上的delta2，但是由于上面sigmoidGradient式子中  
   % #的z，本身不包含bias unit，所以下面的过滤不必要，注释掉。  
    part1OfD2=delta3 * a2(:,i)';
    %size(part1OfD2)
    Delta2 = Delta2+part1OfD2;
      
   % #第一层的input是一行一行的，和后面的结构不一样，后面是一列作为一个example  
    Delta1= Delta1+delta2 * a1(i,:);  
end;  
  
%#总结一下，δ不包含bias unit的偏差值，Δ对跟θ对应的，用来计算每个θ  
%#后面的偏导数的，所以Δ包含bias unit的θ  
Theta2_grad = Delta2/m;  
Theta1_grad = Delta1/m;  
  
%regularization gradient  
  
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + lambda * Theta2(:,2:end) / m;  
Theta1_grad(:,2:end) = Theta1_grad(:,2:end)+ lambda * Theta1(:,2:end) / m;  
  
  
  
  
  
  
% -------------------------------------------------------------  
  
% =========================================================================  
  
% Unroll gradients  
grad = [Theta1_grad(:) ; Theta2_grad(:)];  
