close all;
clear all;
clc

load ResizeARDatabase_540;
% TrainFace is the training data, each column is one sample
% TestFace is the testing data, each column is one sample
% TrainLabel gives the identity information of training data
% TestLabel gives the identity information of testing data

%number of testing samples
teNum=size(TestLabel,2);
%number of training classes
trClass=max(TrainLabel);

% normalize each sample with unit l_2 norm
D = TrainFace./ repmat(sqrt(sum(TrainFace.*TrainFace)),[size(TrainFace,1) 1]);
test = TestFace./ repmat(sqrt(sum(TestFace.*TestFace)),[size(TestFace,1) 1]);


Num = 26;
par.nClass        =   100;                 % the number of classes in the subset of AR database
par.nDim          =   540;                 % the eigenfaces dimension
KAPPA = [0.5 0.2  0.1 0.05 0.02 0.01 0.005 0.002];

% for i = 1 : size(KAPPA,2)
%     kappa = KAPPA(i);
%     -------------------------------------------------------------------------
%     projection matrix computing
%     Proj_M = inv(D'*D+kappa*eye(size(D,2)))*D';
%     
%     ID = [];
%     for indTest = 1:size(test,2)
%         [id]    = CRC_RLS(D,Proj_M,test(:,indTest),TrainLabel);
%         ID      =   [ID id];
%     end;
%     cornum      =   sum(ID==TestLabel);
%     reco_rate         =   [cornum/length(TestLabel)]; % recognition rate
%     fprintf('CRC的正确率为%f, kappaa = %f\n',reco_rate,  kappa);
% end;

%-------------------------------------------------------------------------
%训练
v = 1*sqrt(size(TrainFace,1))^-1;
tau = 0.01;
eta = 1 * v;
alpha = 0.01;
maxOut = 100;
[Beta, A, X, E, LossBeta] = Train(D, TrainLabel, tau, eta, alpha, maxOut);
% [accuracy] = Test(D, TrainLabel, Beta, A,  test, TestLabel);
