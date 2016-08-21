function bright_predictOnTraingCVTesting(segTheta1,segTheta2,Xseg,yseg,Xcv,ycv,Xtest,ytest)
%predict using segTheta1 and segTheta2 of NN


%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

%pred = predict(segTheta1, segTheta2, Xseg);
%save('bright_seg_pred','pred');
%fprintf('\nTraining Set Accuracy for Segmentation: %f\n', mean(double(pred == ySeg)) * 100);


% predict and validation of model
predTrain = predict(segTheta1, segTheta2, Xseg);
save('bright_seg_pred','predTrain');
fprintf('\nTraining Set Accuracy for Segmentation(Training): %f\n', mean(double(predTrain == yseg)) * 100);

predCV = predict(segTheta1, segTheta2, Xcv);
save('bright_seg_predCV','predCV');
fprintf('\nTraining Set Accuracy for Segmentation(Cross Validation): %f\n', mean(double(predCV == ycv)) * 100);

predTest = predict(segTheta1, segTheta2, Xtest);
save('bright_seg_predTest','predTest');
fprintf('\nTraining Set Accuracy for Segmentation(Testing): %f\n', mean(double(predTest == ytest)) * 100);



