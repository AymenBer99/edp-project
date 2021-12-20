clear;
close all;

h = [];
erreur = [];
for n=5:50
%Generation du maillage
[coordinates, elements3, elements4, dirichlet, neumann] = maillage_carre(n);

%Generation des elements de l'equation
A = raideur_triangle(coordinates,elements3);

%Generation de b
[Ntriangle,~] = size(elements3);
b = zeros(size(coordinates,1),1);

%1er terme de b(i)
for j = 1:Ntriangle
    X=coordinates(elements3(j,:),1);
    Y=coordinates(elements3(j,:),2);
    alpha = det([X(2)-X(1) , X(3)-X(1); Y(2)-Y(1), Y(3)-Y(1)]);
    for k=1:3
        b(elements3(j,k)) = b(elements3(j,k)) + (alpha/6) * ...
        f_uexacte(sum(coordinates(elements3(j,:),:))/3);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% CONDITIONS AUX LIMITES %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Conditions de Dirichlet
% 3ème terme de b(i)
for i = 1:size(dirichlet,1)
    for k = 1:size(A,1)
        b(dirichlet(i))=b(dirichlet(i))-A(i,k)*...
        u_d([coordinates(dirichlet(i),1), coordinates(dirichlet(i),2)]);
    end
end

%Solution
u = zeros(n*n,1);
PointsLibres = setdiff(1:(n*n),unique(dirichlet));
u(PointsLibres) =  A(PointsLibres,PointsLibres) \ b(PointsLibres);

%Ajout pour tracer courbe d'erreur
solutionExacte = u_exacte(coordinates);
h = [h 1/n];
erreur = [erreur norm(solutionExacte-u)/size(u,1)];
end
loglog(h,erreur)