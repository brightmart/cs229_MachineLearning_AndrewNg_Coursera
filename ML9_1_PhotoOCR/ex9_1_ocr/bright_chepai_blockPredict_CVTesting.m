function []= bright_chepai_blockPredict_CVTesting()
load('bright_chepai_chepaiBlocsAllData.mat');
load('bright_chepai_data_Theta1Theta2.mat');
%% ================= Part:Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

%pred = predict(segTheta1, segTheta2, Xseg);
%save('bright_seg_pred','pred');
%fprintf('\nTraining Set Accuracy for Segmentation: %f\n', mean(double(pred == ySeg)) * 100);


% predict and validation of model
sizeXchepaiBlock=size(XchepaiBlock)
predChepaiBlock = predict(chepaiTheta1, chepaiTheta2, XchepaiBlock);
save('bright_chepai_predChepaiBlock','predChepaiBlock');
fprintf('\nTraining Set Accuracy for chepaiition(Training): %f\n', mean(double(predChepaiBlock == ychepaiBlock)) * 100);

predCVChepaiBlock = predict(chepaiTheta1, chepaiTheta2, XchepaiBlockCV);
save('bright_chepai_predCVChepaiBlock','predCVChepaiBlock');
fprintf('\nTraining Set Accuracy for chepaiition===---->>>>>>(Cross Validation): %f\n', mean(double(predCVChepaiBlock == ychepaiBlockCV)) * 100);




