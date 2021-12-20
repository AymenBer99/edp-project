clear;
close all;

n = input("Entrez n pour n^2 points:");
for i = 1:n
  % Maillage
  [coordinates,elements3,elements4,dirichlet,neumann] = maillage_carre(i);
  % A
  A = raideur_quadrangle(coordinates, elements3, elements4);
  % R : cholesky
  [R,flag] = chol(A);
  % Elements non nuls
  nz(i) = length(nonzeros(R));
  %Pourcentage des elements non nuls
  pourcentage(i) = nz(i)/i^4;
end
figure(1)
spy(A)

figure(2)
plot(1:n,nz,'r')
title('Eléments non nuls de A')

figure(3)
plot(1:n,pourcentage,'r')
title('Pourcentage des eléments non nuls de A')