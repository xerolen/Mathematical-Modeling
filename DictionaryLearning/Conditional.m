function  Error = Conditional(Y, Y_Label, Beta, A, X, E)
%ŒÛ≤Ó≈–∂œ≥Ã–Ú
n = size(Y, 2);
M = ones(n, 1);

Error = 0;
for ci = max(Y_Label)
    Yk = Y(:, Y_Label == ci);
    Xk = X(:, Y_Label == ci);
    Betak = Beta(:, ci);
    Ek = E(:, Y_Label == ci);
    Error = Error + norm(Yk - A * Xk - Y * Betak * (M') - Ek,2)^2;
end;