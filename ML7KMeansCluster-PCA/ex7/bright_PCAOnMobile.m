function bright_PCAOnMobile(X)
[X_norm, mu, sigma] = featureNormalize(X);

%  Run PCA
[U, S] = pca(X_norm);
fprintf('Program paused. Press enter to continue.\n');
pause;

%  Visualize the top 3 eigenvectors found
%displayData(U(:, 1:8)'); % 36

%fprintf('Program paused. Press enter to continue.\n');
%pause;

%  Project images to the eigen mobile using the top k eigenvectors 
K = 2;
Z = projectData(X_norm, U, K);
plot(Z(:,1),Z(:,2),'ro');
hold on;
save('bright_Z.mat','Z');
fprintf('The projected data Z has a size of: ')
fprintf('%d ', size(Z));

fprintf('\nVisualizing the projected (reduced dimension) faces.\n\n');

K =2;
X_rec  = recoverData(Z, U, K);
plot(X_rec(:,1),X_rec(:,2),'rx');

save('bright_X_rec.mat','X_rec');
% Display normalized data
%subplot(1, 2, 1);
%displayData(X_norm(1:100,:));
%title('Original faces');
%axis square;

% Display reconstructed data from only k eigenfaces
%subplot(1, 2, 2);
%displayData(X_rec(1:100,:));
%title('Recovered faces');
%axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;

