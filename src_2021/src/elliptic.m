clear ;
close all;

k = input("Maillage_carre (0) ou maillage fourni dans les " ...
    +"fichiers .dat (1):");

if k==0 
    n = input("Entrez n:");
    %Generation du maillage
    [coordinates, elements3, elements4, dirichlet, neumann] = maillage_carre(n);

    %Generation des elements de l'equation
    A = raideur_quadrangle(coordinates,elements3,elements4);
    b = vecteurb_quadrangle(coordinates,elements4,neumann,elements3,dirichlet,A);
    
    %Solution
    u = zeros(n*n,1);
    PointsLibres = setdiff(1:(n*n),unique(dirichlet));
    u(PointsLibres) =  A(PointsLibres,PointsLibres) \ b(PointsLibres);

    %Affichage
    show(elements3,elements4,coordinates,u);
    
else
    load('dirichlet.dat');
    load('elements4.dat');
    load('neumann.dat');
    load('coordinates.dat');
    load('elements3.dat');

    A = raideur_quadrangle(coordinates, elements3,elements4 );
    b = vecteurb_quadrangle(coordinates,elements4,neumann,elements3,dirichlet,A);

    n=size(coordinates,1);
    u=zeros(n,1);
    PointsLibres = setdiff(1:n,unique(dirichlet));
    u(PointsLibres) =  A(PointsLibres,PointsLibres) \ b(PointsLibres);

    %Affichage
    show(elements3,elements4,coordinates,u); 
end