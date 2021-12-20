function [b] = vecteurb_quadrangle(coordinates, elements4,neumann,elements3,dirichlet,A)
%VECTEURB_TRIANGLE Calcule le vecteur b

b = zeros(size(coordinates,1),1);


%1er terme dans b(i) (contenant f)
% Ajout de la partie f pour les triangles
[Ntriangle,~] = size(elements3);

for j = 1:Ntriangle
    X=coordinates(elements3(j,:),1);
    Y=coordinates(elements3(j,:),2);
    alpha = det([X(2)-X(1) , X(3)-X(1); Y(2)-Y(1), Y(3)-Y(1)]);
    for k=1:3
        b(elements3(j,k)) = b(elements3(j,k)) + (alpha/6) * ...
        f(sum(coordinates(elements3(j,:),:))/3);
    end
end
%Ajout de la partie f pour les quadrangles
[Nquadrangle,~] = size(elements4);

for j = 1:Nquadrangle
    X=coordinates(elements4(j,:),1);
    Y=coordinates(elements4(j,:),2);
    alpha = det([X(2)-X(1) , X(4)-X(1); Y(2)-Y(1), Y(4)-Y(1)]);
    for k=1:4
        b(elements4(j,k)) = b(elements4(j,k)) + (alpha/4) * ...
        f(sum(coordinates(elements4(j,:),:))/4);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% CONDITIONS AUX LIMITES %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Conditions de Neumann
%2ème terme dans b(i) contenant g
for j = 1 : size(neumann,1)
    b(neumann(j,:))=b(neumann(j,:)) + norm(coordinates(neumann(j,1),:) -...
    coordinates(neumann(j,2),:))* g(sum(coordinates(neumann(j,:),:))/2)/2;
end

% Conditions de Dirichlet
% 3ème terme dans b(i)
for i = 1:size(dirichlet,1)
    for k = 1:size(A,1)
        b(dirichlet(i))=b(dirichlet(i))-A(i,k)*...
        u_d([coordinates(dirichlet(i),1), coordinates(dirichlet(i),2)]);
    end
end


end

