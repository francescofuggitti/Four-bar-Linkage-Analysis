function [T] = kinematics1 (r_1,r_2,r_3,r_4,max_len,gait)

% KINEMATICS ANALYSIS FOURBAR LINKAGE (CRANK-ROCKER) - KINEMATICS1
% Questa function di  Matlab ha lo scopo di risolvere le equazioni
% di chiusura di un quadrilatero articolato di tipo manovella-bilanciere.

% INPUT:
% r_1: lunghezza manovella
% r_2: lunghezza biella
% r_3: lunghezza bilanciere
% r_4: lunghezza telaio
% max_len: numero passi totali di discretizzazione
% gait: passo di discretizzazione angolo

% OUTPUT :
% T: matrice gaitx3 delle soluzioni theta1, theta2, theta3

%definisce il primo vettore colonna della matrice T con tutti i valori di
%theta1 da 0 a 2*pi discretizzato di passo 'gait'
T(:,1) = 0:gait:2*pi;

%esegue un ciclo for per 'max_len' volte andando a calcolare,
%per ogni iterazione, gli angoli theta3 e theta2 corrispondenti
%all'i-esimo theta1
for i=1:max_len
    
    %coefficienti dell'equazione di secodo grado ridotta a theta3
    A = 2*r_1*r_3*sin(T(i,1));
    B = 2*r_1*r_3*cos(T(i,1)) - 2*r_3*r_4;
    C = (r_1)^2 + (r_3)^2 + (r_4)^2 - (r_2)^2 - 2*r_1*r_4*cos(T(i,1));
    
    %definisce un vettore con i coefficienti dell'equazione di secondo
    %grado in t per poi calcolarne le radici con la funzione roots.
    p=[(C-B) 2*A (B+C)];
    
    %Tali radici vengono assegnate ad un vettore colonna Y
    Y = roots(p);
    
    %controlla se le radici sono state assegnate in modo ordinato
    %nel vettore Y per poi scegliere la soluzione congruente con quella
    %scelta precedentemente.
    if issorted(Y)
        T(i,3) = 2*atan(Y(1));
    else
        T(i,3) = 2*atan(Y(2));
    end
    
    %rende positivo l'angolo theta3 aggiungendo 2*pi
    T(i,3)=T(i,3)+2*pi;
    
    %calcola rispettivamente r_2*cos(theta2) e r_2*sin(theta2).
    x = r_4 - r_3*cos(T(i,3)) - r_1*cos(T(i));
    y = -(r_1*sin(T(i)) + r_3*sin(T(i,3))); 
    
    %calcola theta2 tramite la funzione di matlab atan2 che calcola
    %l'arcotangente del rapporto tra y ed x tenendo conto del loro
    %segno.
    T(i,2) = atan2(y,x);
    
end

end
    
   