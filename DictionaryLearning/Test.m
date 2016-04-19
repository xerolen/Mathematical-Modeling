function [accuracy] = Test(D, TrainLabel, Beta, A, TestData, TestLabel)

nk = size(TrainLabel(TrainLabel == 1), 2);
B = A;
A = kron(D * Beta, ones(1,nk));

beta=10;
gamma=10;
L=[];
teNum=size(TestLabel,2);

for i = 1 : size(TestData, 2)
    fprintf('Recognizing %d  out of %d query image\n', i, teNum);
    
    d2=[];
    
    
    % get the ith testing image
    y = TestData(:,i);
    
    % sdr procedure
    [a x e] = sdr_ialm(A, B, y, beta, gamma, 5e-3, 1000);
    
    % recovered clean face
    dny = y-B*x-e;

    % class residual
    for k = 1:max(TrainLabel)
        residual = dny - A(:,k==TrainLabel) * a(k==TrainLabel);
        d2(k) = residual' * residual;
    end
    % classification result
    [r L(i)] = min(d2);
end
accuracy = sum(L==TestLabel) / teNum;
fprintf('My recogniiton rate is %f', accuracy);