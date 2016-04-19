function  [X, E, iter] = Update_X_E(Y, Y_Label, Y_dif, A, X, tau, eta, maxIter, epsilon)
[m, n] = size(Y);
nk = size(Y(:, Y_Label == 1), 2);
Rho = 1.5;
muMax = 1e+6;
mu = 1e-3;
H = zeros(m, n);
E = zeros(m, n);
iter = 0;
converged = false;

while ~converged
    iter = iter + 1;
    
    %optmize X
    X = (2 * tau * eye(n) + mu * (A') * A ) \ ((A') * H + mu * (A') * (Y_dif - E));
    
    %optmize E
    E = (2 * eta + mu ) \ (H + mu * (Y_dif - A * X));
    
    
    H = H + mu * (Y_dif - A*X -E);
    u = min(Rho * mu, muMax);
    
    if( norm((Y_dif - A*X -E) ,'fro') <= epsilon)
        converged = true;
    end;
    
    if ~converged && iter >= maxIter
        disp('Maximum iterations reached:X_E') ;
        converged = 1 ;
    end
    
end;