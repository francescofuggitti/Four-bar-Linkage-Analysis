function [x]=newtonraphson(func,jacob,x_0,toll,itmax,TH)
%
% NEWTON-RAPHSON ALGORITHM
% INPUT
% func : Function in cui viene valutato il vettore dei resti
% jacob : Function in cui viene valutata la Jacobiana
% x_0: Vettore soluzione di primo tentativo
% toll: Tolleranza
% itmax: Numero massimo di iterazioni
% TH: Valore di theta1
%
% OUTPUT
% x: Soluzione

% Inizializza le variabili

resid=1000;
iterations=0;

while resid>toll || iterations>itmax 
    
    % Calcola matrice Jacobiana
    J=feval(jacob,x_0);
    % Calcola residui
    f=feval(func,x_0,TH);
    % Calcola norma vettore dei residui
    resid=norm(f);
    
    % Trova il nuovo valore di x con il metodo di Newton-Raphson
    x = x_0-J\f;
    
    % Assegna il nuovo valore come condizioni iniziali per la successiva
    % iterazione
    x_0=x;
    
    iterations=iterations+1;
end

end
