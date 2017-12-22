function f=func(x,TH)

% OUTPUT:
% f: vettore dei resti
% 
% INPUT:
% x: vettore delle soluzioni
% TH: valore di theta1

r(1)=2;
r(2)=3;
r(3)=3.5;
r(4)=4;

theta(1)=TH;
f(1)= r(1)*cos(theta(1)) + r(2)*cos( x(1)) + r(3)*cos( x(2)) - r(4);
f(2)= r(1)*sin(theta(1)) + r(2)*sin( x(1)) + r(3)*sin( x(2));

f= f';
end