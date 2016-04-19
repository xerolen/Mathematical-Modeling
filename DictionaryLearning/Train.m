function [Beta, A, X, E, LossBeta] = Train(Y, Y_Label, tau, eta, alpha, maxOut)
%³õÊ¼»¯A£¬X
[m, n] = size(Y);
nk = size(Y(:,Y_Label == 1), 2);
X = zeros(n ,n);
Beta = zeros(n, max(Y_Label));
E = zeros(m, n);
maxIter = 5000;

for ci = 1 : max(Y_Label)
    tempMatrix = Y(:, Y_Label == ci) - mean(Y(:, Y_Label == ci),2)*ones(1, size(Y(:, Y_Label == ci),2));
    [coeff, score, latent] = pca(tempMatrix);
    rate = cumsum(latent)./sum(latent);
%     tempMatrix = find(rate>=0.8);
%     num = tempMatrix(1);
    A(:, Y_Label == ci) = score;
    X(Y_Label == ci, Y_Label == ci) = coeff;
end;

LossBeta = zeros(1, maxOut);

%µü´ú
for i = 1 : maxOut
    Y_dif = Y - A * X;
    [Beta, E, iterBetaE, LossBeta(1,i)] = Update_Beta_E(Y, Y_Label, Y_dif, eta, alpha, maxIter, 1e-6);
    fprintf('iterBetaE = %d\n', iterBetaE);
    
    Y_dif = Y - kron(Y * Beta, ones(1,nk));
    [X, E, iterXE] = Update_X_E(Y, Y_Label, Y_dif, A, X,  tau, eta, maxIter, 1e-6);
    fprintf('iterXE = %d\n', iterXE);
    
    Y_dif = Y - kron(Y * Beta, ones(1,nk));
    [A, E, iterAE] = Update_A_E(Y, Y_Label, Y_dif, X, eta, maxIter, 1e-6);
    fprintf('iterAE = %d\n', iterAE);
end;