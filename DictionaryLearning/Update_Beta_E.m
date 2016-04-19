function  [Beta, E, iter, Loss_new] = Update_Beta_E(Y, Y_Label, Y_dif, eta, alpha, maxIter, epsilon)
[m, n] = size(Y);
nk = size(Y(:, Y_Label == 1), 2);
doubleY = (Y') * Y;

Rho = 1.5;
muMax = 1e+6;
mu = 1e-6;
OutH = zeros(m, n);
M = ones(nk, 1);
Beta = zeros(n, max(Y_Label));
E = zeros(m, n);
iter = 0;
Niter = 0;

iterMatrix = 2 * eye(n) + mu*(M'*M)*doubleY;
converged = false;
Loss_new = 0;


while ~converged
    iter = iter + 1;
    
    Betaold = Beta;
    Eold = E;
    OutHold = OutH;
    muold = mu;
    
    trBeta = Beta*(Beta');
    
    Loss_old = Loss_new;
    
    for ci = 1 : max(Y_Label)
        H = OutH(:, Y_Label == ci);
        Y_difci = Y_dif(:, Y_Label == ci);
        E_ci = E(:, Y_Label == ci);
        Matrix = doubleY * (trBeta - (Beta(:, ci)) * Beta(:, ci)') * doubleY;
        
         %optmize Beta
        Beta(:, ci) = (iterMatrix + 2 * alpha * Matrix) \ ((Y') * H * M + mu * (Y') *(Y_difci - E_ci) * M );
        
    end;
    
     %optmize E
    E = (2 * eta + mu) \ (OutH + mu * (Y_dif - kron(Y * Beta, ones(1,nk))));
    
    OutH = OutH + mu * (Y_dif - kron(Y * Beta, ones(1,nk)) -E);
    mu = min(Rho * mu, muMax);
    
    Loss_new = norm(Y_dif - kron(Y * Beta, ones(1,nk)) -E,'fro');
    
    if(iter == 1)
        Loss_old = Loss_new;
    end;
    
    fprintf('iter = %d, Loss_old = %f, Loss_new = %f, mu = %f\n', iter, Loss_old, Loss_new, mu);
    
    if(Loss_new > Loss_old)
        disp('µü´úÔ½½ç:Beta_E') ;
        Beta = Betaold;
        E = Eold;
        OutH = OutHold;
        mu = muold/10;
        Loss_new = Loss_old;
        Niter = Niter + 1;
    end;
    
    if( Loss_new <= epsilon || Niter>=10)
        converged = true;
    end;
    if ~converged && iter >= maxIter
        disp('Maximum iterations reached:Beta_E') ;
        converged = 1 ;
    end
end;