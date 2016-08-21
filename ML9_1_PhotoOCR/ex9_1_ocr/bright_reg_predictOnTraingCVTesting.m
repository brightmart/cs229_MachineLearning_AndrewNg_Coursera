function bright_reg_predictOnTraingCVTesting(regTheta1,regTheta2,Xreg,yreg,XregCV,yregCV,XregTest,yregTest)
%predict using segTheta1 and segTheta2 of NN


%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

%pred = predict(segTheta1, segTheta2, Xseg);
%save('bright_seg_pred','pred');
%fprintf('\nTraining Set Accuracy for Segmentation: %f\n', mean(double(pred == ySeg)) * 100);

load('bright_reg_yregTest.mat','yregTest');
load('bright_reg_XregTest.mat','XregTest');

% predict and validation of model
predTrainReg = predict(regTheta1, regTheta2, Xreg);
sizePredTrainReg=size(predTrainReg)
sizeYreg=size(yreg)
save('bright_reg_predReg','predTrainReg');
fprintf('\nTraining Set Accuracy for Regition(Training): %f\n', mean(double(predTrainReg == yreg)) * 100);

predCVReg = predict(regTheta1, regTheta2, XregCV);
sizeYregCV=size(yregCV)
save('bright_reg_predCVReg','predCVReg');
fprintf('\nTraining Set Accuracy for Regition===---->>>>>>(Cross Validation): %f\n', mean(double(predCVReg == yregCV)) * 100);

fprintf('\nTraining Set Accuracy for Regition(Cross Validation)%f: %f\n', predCVReg,yregCV);
yregTest
sizeYregTest=size(yregTest)
predTestReg = predict(regTheta1, regTheta2, XregTest);
sizePredTestReg=size(predTestReg)
save('bright_reg_predTestReg','predTestReg');
fprintf('\nTraining Set Accuracy for Regition(Testing): %f\n', mean(double(predTestReg == yregTest)) * 100);



