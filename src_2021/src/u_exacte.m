function valeurExact = u_exacte(x)
%U_EXACTE sin(pi*x)*sin(pi*y)
n = size(x,1);
valeurExact = zeros(n,1);
for i = 1:n
    valeurExact(i,1) = sin(pi*x(i,1))*sin(pi*x(i,2));
end
end

