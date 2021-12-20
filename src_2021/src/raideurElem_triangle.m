function [M,alpha] = raideurElem_triangle(X,Y)
%RAIDEUR_TRIANGLE : Calcul la matrice de raideur a partir des coordonnees 
%de 3 points

% Iniialisation des données
M = zeros(3,3);

% Calcul de alpha (aire du triangle / 2)
alpha = det([X(2)-X(1) , X(3)-X(1); Y(2)-Y(1), Y(3)-Y(1)]);


% Remplissage de la matrice de raideur M
gradEta1 = 1/alpha * [Y(2)-Y(3);X(3)-X(2)];
gradEta2 = 1/alpha * [Y(3)-Y(1);X(1)-X(3)];
gradEta3 = 1/alpha * [Y(1)-Y(2);X(2)-X(1)];

M(1,1) = (alpha/2)*(gradEta1' * gradEta1) ;
M(1,2) = (alpha/2)*gradEta1' * gradEta2;
M(1,3) = (alpha/2)*gradEta1' * gradEta3;
M(2,1) = (alpha/2)*gradEta2' * gradEta1;
M(2,2) = (alpha/2)*(gradEta2' * gradEta2);
M(2,3) = (alpha/2)*gradEta2' * gradEta3;
M(3,1) = (alpha/2)*gradEta3' * gradEta1;
M(3,2) = (alpha/2)*gradEta3' * gradEta2;
M(3,3) = (alpha/2)*(gradEta3' * gradEta3);
end

