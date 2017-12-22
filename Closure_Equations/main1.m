%% KINEMATICS & STATIC ANALYSIS PROGRAM - MAIN

clear all; clc;

r_1=input ('inserisci r1 (m): '); % input lung. manovella
r_2=input ('inserisci r2 (m): '); % input lung. biella
r_3=input ('inserisci r3 (m): '); % input lung. bilanciere
r_4=input ('inserisci r4 (m): '); % input lung. telaio

if r_1+r_4<=r_2+r_3 && r_1<r_4
    
    % stampa a schermo se il controllo e' andato a buon fine
    disp('il quadrilatero è di Grashof! ');
   
    % chiede il passo da tenere nel discretizzare theta1
    gait = input('inserisci il passo: ');
    
    % calcola il numero di passi totali eseguiti
    max_len = numel(0:gait:2*pi);
    
    % esegue l'analisi cinematica
    [T] = kinematics1 (r_1,r_2,r_3,r_4,max_len,gait);
    
    % chiede i moduli delle forze peso di ogni asta 
    P1 = input ('inserisci P1 (N): ');
    P2 = input ('inserisci P2 (N): ');
    P3 = input ('inserisci P3 (N): ');
    
    % esegue analisi statica
    [Pl_1,Pl_2,Pl_3,Pl_4,Pl_5, Q] = static1 (r_1,r_2,r_3,P1,P2,P3,T,max_len);

else
    % errore se il quadrilatero non rispetta Grashof
     error ('il quadrilatero immesso non è di Grashof! Ritenta');   
end

