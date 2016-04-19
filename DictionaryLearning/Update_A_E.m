function  [A, E, iter] = Update_A_E(Y, Y_Label, Y_dif, X, eta, maxIter, epsilon)
[m, n] = size(Y);
nk = size(Y(:, Y_Label == 1), 2);
Rho = 2;
muMax = 1e+6;
mu = 1e-3;
e = 1/mu;
converged = false;
iter = 0;

E = zeros(m, n);
A = zeros(m, n);C = A;
H1 = zeros(m, n); H2 = zeros(m, n);
XXT = X*(X');

while ~converged
    iter = iter + 1;

    %optmize C
    Resi_C = A+2*H2./mu;
    [U S V] = svd(Resi_C, 'econ');
    diagS = diag(S);
    svp = length(find(diagS > 2/mu));
    if svp>=1
        diagS = diagS(1:svp)-2/mu;
    else
        svp = 1;
        diagS = 0;
    end
    C = U(:,1:svp)*diag(diagS)*V(:,1:svp)';  
    
    %optmize A
    A = (mu * C + mu * (Y_dif - E) * (X') + H1 * (X') - H2) / (mu*XXT + mu * eye(n)); 
    
    %optmize E
    E = (2 * eta + mu) \ ((H1) + mu * (Y_dif - A * X));
    
    H1 = H1 + mu * (Y_dif - A*X -E);
    H2 = H2 + mu * (A - C);
    mu = min ( Rho * mu, muMax);
    
    if( (norm(Y_dif-A*X-E, 'fro') <= epsilon) && (norm(A - C ,'fro') <= epsilon))
        converged = true;
    end;
    if ~converged && iter >= maxIter
        disp('Maximum iterations reached:A_E') ;
        converged = 1 ;
    end;
end;