function J = jacob(x)

% OUTPUT:
% J: matrice Jacobiana valutata nel punto x
% 
% INPUT:
% x: vettore delle soluzioni

r(2)=3;
r(3)=3.5;

J(1,1) = -r(2)*sin( x(1));
J(1,2) = -r(3)*sin( x(2));
J(2,1) =  r(2)*cos( x(1));
J(2,2) =  r(3)*cos( x(2));

end