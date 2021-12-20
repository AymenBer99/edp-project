function valeur = f_uexacte(x)
%F_UEXACTE Summary of this function goes here
%   Detailed explanation goes here
n = size(x,1);
valeur = zeros(n,1);
for i=1:n
    valeur(i,1) = 2 * pi^2 * sin(pi*x(i,1)) * sin(pi*x(i,2));
end
end

