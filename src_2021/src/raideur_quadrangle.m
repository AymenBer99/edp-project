function [A] = raideur_quadrangle(coordinates,elements3,elements4)
%MATRICEA_QUADRANGLE Calcul la matrice A

% Calcul de la matrice de raideur A
%Prise en compte des quadrangles
[Nquadrangle,~] = size(elements4);
A = zeros(size(coordinates,1));
for i=1:Nquadrangle
    X=coordinates(elements4(i,:),1);
    Y=coordinates(elements4(i,:),2);
    Mraideur = raideurElem_quadrangle(X,Y);
   for j=1:4
       for k=1:4
          A(elements4(i,j),elements4(i,k)) = A(elements4(i,j),elements4(i,k)) + Mraideur(j,k);
       end
   end
end

%Prise en compte des triangles
[Ntriangles,~]=size(elements3);

for i = 1:Ntriangles
    X=coordinates(elements3(i,:),1);
    Y=coordinates(elements3(i,:),2);
    M=raideurElem_triangle(X,Y);
    for j = 1:3
        for k = 1:3
            A(elements3(i,j),elements3(i,k)) = A(elements3(i,j),elements3(i,k)) + M(j,k);
        end
    end    
end
end