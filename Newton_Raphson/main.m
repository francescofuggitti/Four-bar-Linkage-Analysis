%% NEWTON-RAPHSON METHOD - MAIN
clc; clear; close all;

% Soluzione primo tentativo
x_0=[1.49 ; 5.24]; 

% Tolleranza consentita
toll=1e-6;

% Massimo numero di iterazioni
itmax=100;

%Vettore colonna valori theta1
TH(:,1)=0:0.01*pi:2*pi;

for i=1:numel(TH)
% Metodo di Newton-Raphson per trovare la soluzione del sistema di
% equazioni non lineari
[x]=newtonraphson(@func,@jacob,x_0,toll,itmax,TH(i,1));

TH(i,2)=x(1); %assegno theta2 alla seconda colonna
TH(i,3)=x(2); %assegno theta3 alla terza colonna
end
