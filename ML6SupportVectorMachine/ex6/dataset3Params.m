function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
cVector=[0.01,0.03,0.1,0.3,1,3,10,30];
cVectorLength=length(cVector);
sigmaVector=[0.01,0.03,0.1,0.3,1,3,10,30];
sigmaVectorLength=length(sigmaVector);
localMinnValue=10000;
tempMinnValue=0;
resultForSigma=0;
resultForC=0;
for c=1:cVectorLength;
   for s=1: sigmaVectorLength;
       CTemp=cVector(c);
       sigmaTemp=sigmaVector(s);
       model= svmTrain(X, y, CTemp, @(x1, x2) gaussianKernel(x1, x2, sigmaTemp)); %get model by using svnTrain provided with gaussianKernel, using traing data set X,y
       predictions = svmPredict(model, Xval); % use model and Xval to get predictions on Cross Validation data set
       tempMinnValue=mean(double(predictions ~=yval));
       if(tempMinnValue-localMinnValue<0)  
           localMinnValue=tempMinnValue;
           resultForSigma=sigmaTemp;
           resultForC=CTemp;     
       end;
   end;
end;
C=resultForC;
sigma=resultForSigma
localMinnValue




% =========================================================================

end
