function [A] = raideur_triangle(coordinates,elements3)
% Calcul de la matrice de raideur A

[Ntriangles,~]=size(elements3);
A=zeros(size(coordinates,1));

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