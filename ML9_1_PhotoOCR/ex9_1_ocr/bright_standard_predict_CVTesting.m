function []= bright_standard_predict_CVTesting()
%predict using segTheta1 and segTheta2 of NN
% standTheta1,standTheta2,Xstand,ystand,XstandCV,ystandCV,XstandTest,ystandTest

load('bright_stand_data_Theta1Theta2.mat');
load('bright_standard_standAllData.mat');

%% ================= Part:Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

%pred = predict(segTheta1, segTheta2, Xseg);
%save('bright_seg_pred','pred');
%fprintf('\nTraining Set Accuracy for Segmentation: %f\n', mean(double(pred == ySeg)) * 100);


% predict and validation of model
predTrainstand = predict(standTheta1, standTheta2, Xstand);
save('bright_stand_predstand','predTrainstand');
fprintf('\nTraining Set Accuracy for standition(Training): %f\n', mean(double(predTrainstand == ystand)) * 100);

predCVstand = predict(standTheta1, standTheta2, XstandCV);
save('bright_stand_predCVstand','predCVstand','ystandCV');
fprintf('\nTraining Set Accuracy for standition===---->>>>>>(Cross Validation): %f\n', mean(double(predCVstand == ystandCV)) * 100);

%fprintf('\nTraining Set Accuracy for standition(Cross Validation)%f: %f\n', predCVstand,ystandCV);
predTeststand = predict(standTheta1, standTheta2, XstandTest);
save('bright_stand_predTeststand','predTeststand');
fprintf('\nTraining Set Accuracy for standition(Testing): %f\n', mean(double(predTeststand == ystandTest)) * 100);



