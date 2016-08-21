function []= bright_zky_predict_CVTesting()
%predict using segTheta1 and segTheta2 of NN
load('bright_zky_zkyAllData.mat');
[superZkyXCV,superZkyyCV]=bright_zky_cuttingImage(XzkyCV,yzkyCV);
[superZkyX,superZkyy]=bright_zky_cuttingImage(Xzky,yzky);
load('bright_zky_data_Theta1Theta2.mat');

%% ================= Part:Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

%pred = predict(segTheta1, segTheta2, Xseg);
%save('bright_seg_pred','pred');
%fprintf('\nTraining Set Accuracy for Segmentation: %f\n', mean(double(pred == ySeg)) * 100);


% predict and validation of model

predTrainzky = predict(zkyTheta1, zkyTheta2, superZkyX);
sizePredTrainzky=size(predTrainzky)
sizeSuperZkyy=size(superZkyy)
save('bright_zky_predzky','predTrainzky');
fprintf('\nTraining Set Accuracy for zkyition(Training): %f\n', mean(double(predTrainzky == superZkyy)) * 100);

predCVzky = predict(zkyTheta1, zkyTheta2, superZkyXCV);
save('bright_zky_predCVzky','predCVzky','superZkyyCV');
fprintf('\nTraining Set Accuracy for zkyition===---->>>>>>(Cross Validation): %f\n', mean(double(predCVzky == superZkyyCV)) * 100);

%fprintf('\nTraining Set Accuracy for zkyition(Cross Validation)%f: %f\n', predCVzky,yzkyCV);
%predTestzky = predict(zkyTheta1, zkyTheta2, XzkyTest);
%save('bright_zky_predTestzky','predTestzky');
%fprintf('\nTraining Set Accuracy for zkyition(Testing): %f\n', mean(double(predTestzky == yzkyTest)) * 100);



