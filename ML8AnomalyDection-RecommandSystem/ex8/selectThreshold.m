function [bestEpsilon, bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%
%fprintf('1111.yval and pavl:%e %e\n', yval,pval);

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;
%maxPval=max(pval)
%minPval=min(pval)
stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval): stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
pvalOAnd1=(pval<epsilon);
%yvalOAnd1=(yval<epsilon);
%fprintf('=====yvalOAnd1 and pvalOAnd1=====:%e %e\n', yvalOAnd1,pvalOAnd1);
tp=sum((pvalOAnd1==1)&(yval==1));
fp=sum((pvalOAnd1==1)&(yval==0));
fn=sum((pvalOAnd1==0)&(yval==1));
precision=tp/(tp+fp);
recall=tp/(tp+fn);
F1=(2*precision*recall)/(precision+recall);
    % =============================================================
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end
end
