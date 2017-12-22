function [Pl_1,Pl_2,Pl_3,Pl_4,Pl_5, Q] = static1 (r_1,r_2,r_3,P1,P2,P3,T,max_len)

% STATIC ANALYSIS FOURBAR LINKAGE (CRANK-ROCKER)
% Questa function Matlab ha lo scopo di risolvere le equazioni di
% equilibrio di un quadrilatero articolato di tipo manovella-bilanciere
% in cui sono note le dimensioni delle aste e le relative forze peso
% applicate nella mezzeria delle aste.

%INPUT
% r_1: lunghezza manovella
% r_2: lunghezza biella
% r_3: lunghezza bilanciere
% P1: forza peso della manovella applicata nella mezzeria
% P2: forza peso della biella applicata nella mezzeria
% P3: forza peso del bilanciere applicata nella mezzeria
% T: matrice gaitx3 delle soluzioni theta1, theta2, theta3
% max_len: numero passi totali di discretizzazione
% gait: passo di discretizzazione angolo

%OUTPUT
% Pl_i: plot delle soluzioni in funzione di theta1
% Q: matrice gaitx2 che restituisce i valori di theta1 e di Cm

%esegue un ciclo for per 'max_len' volte andando a calcolare,
%per ogni iterazione, le reazioni vincolari e la coppia C_m
%corrispondenti all'i-esimo theta1, e ai corrispondenti theta2 e theta3.
for i=1:max_len
    
    %definisce la matrice E costruita a partire dalle equazioni di
    %Equilibrio.
    E = [ 1 0 -1 0 0 0 0 0 0
        0 1 0 -1 0 0 0 0 0
        0 0 r_1*sin(T(i,1)) -r_1*cos(T(i,1)) 1 0 0 0 0
        0 0 1 0 0 1 0 0 0
        0 0 0 1 0 0 1 0 0
        0 0 0 0 0 -r_2*sin(T(i,2)) r_2*cos(T(i,2)) 0 0
        0 0 0 0 0 -1 0 1 0
        0 0 0 0 0 0 -1 0 1
        0 0 0 0 0 -r_3*sin(T(i,3)) r_3*cos(T(i,3)) 0 0];
    
    %definisce il vettore di termini noti b costruito a partire
    %dalle equazioni di Equilibrio.
    b=[0; P1; P1*((r_1)/2)*cos(T(i,1)); 0; P2; P2*((r_2)/2)*cos(T(i,2)); 0; P3; -P3*((r_3)/2)*cos(T(i,3))];
    
    %effettua un controllo sul det(E) assicurandosi che la matrice
    %non sia singolare.
    if det(E)~=0
        
        %si calcola il vettore della incognite X
        X = E\b;
        
        %in base alla disposizione della incognite nel vettore delle
        %incognite X=[f41x; f41y; f12x; f12y; Cm; f32x; f32y; f43x;
        %f43y]; si calcolano i moduli delle azioni dinamiche interne e
        %il modulo della coppia motrice Cm che mantiene in
        %equilibrio il meccanismo.
        
        F41(i,1) = sqrt( (X(1))^2 + (X(2))^2 );
        F12(i,1) = sqrt( (X(3))^2 + (X(4))^2 );
        Cm(i,1) = X(5);
        F32(i,1) = sqrt( (X(6))^2 + (X(7))^2 );
        F43(i,1) = sqrt( (X(8))^2 + (X(9))^2 );
        
    end
end

%costruisce la matrice Q
Q(:,1)=T(:,1);
Q(:,2)=Cm;

% Plot dei Risultati

%crea la finestra per graficare Cm
Pl_1=figure('Position',[200 100 700 500]);
plot(T(:,1),Cm,'LineWidth',2);
xlabel('\theta_1 [rad]'); 
ylabel('Coppia C_m'); 

%crea le finestre per graficare i moduli delle forze
Pl_2=figure('Position',[200 100 700 500]); 
grid on;
plot (T(:,1),F41,'LineWidth',2);
xlabel('\theta_1 [rad]'); 
ylabel('F_{41}'); 
Pl_3=figure('Position',[200 100 700 500]); 
grid on;
plot (T(:,1),F12,'LineWidth',2);
xlabel('\theta_1 [rad]'); 
ylabel('F_{12}'); 
Pl_4=figure('Position',[200 100 700 500]); 
grid on;
plot (T(:,1),F32,'LineWidth',2);
xlabel('\theta_1 [rad]'); 
ylabel('F_{32}'); 
Pl_5=figure('Position',[200 100 700 500]); 
grid on;
plot (T(:,1),F43,'LineWidth',2);
xlabel('\theta_1 (rad)'); 
ylabel('F_{43}'); 

end