%% Aufagabe 2.2.1
clc
clear all;
close all;

A=1;    %Amplitude des Signals
Fs = 1000; %sample freq
Fc = 12;  %Trägerfrequenz
delta_om = 20;  %Frequenzdeviation
t = (0:1/Fs:4)';

% Funktionsdefinition und Aufruf
s_t=cos(2*pi*0.05*t + 180);
s_int = 2*pi*delta_om*cumsum(s_t)/Fs;
x_FM=gen_FM(2*pi*Fc,s_int,Fs,A);    %FM moduliertes Signal

plot(t, x_FM)
grid on

%%  Aufgabe 2.2.2
clear all;
close all;
clc

A=10;
Fs = 500; %sample freq
Fc = 60;  %Trägerfrequenz
%delta_om = 30;  %Frequenzdeviation
t = (0:1/Fs:1)';

% Funktionsdefinition und Aufruf
s_t=cos(2*pi*1*t);
s_int = 2*pi*20*cumsum(s_t)/Fs;
x_FM_sinus=gen_FM(2*pi*Fc,s_int,Fs,A);    %FM moduliertes Signal

figure
plot(t,s_t)
xlabel('t[s]')
ylabel('s_t [Volt]')
grid on
figure
%plot der Signalen
subplot(2,1,1);
hs_int=plot(t,s_int);
title('s_{int}(t)');
xlabel('t[s]')
ylabel('s_{int} [Volt]')
grid on

subplot(2,1,2);
hx_FM=plot(t,x_FM_sinus);
title('x_{FM}(t)');
xlabel('t[s]')
ylabel('X_{FM}(t) [Volt]')
grid on

%% sinus mit Integrierer
Fc_sinus=10;
Am=1;
Fs_sinus=2;
t_sinus = 0:1/1000:4;

s_sinus=Am*cos(2*pi*Fs_sinus*t_sinus);
s_tau=filter([0 1],[1 -1],s_sinus);
x_FM_sinus=Am*cos(s_tau + 2*pi*Fc_sinus*t_sinus);
figure
plot(t_sinus,s_sinus)
title('Sinus Quellsignal s(t)');
xlabel('t[s]')
ylabel('s(t) [Volt]')
grid on

figure
plot(t_sinus, s_tau)
title('Integrierer s(t)');
xlabel('t[s]')
ylabel('s_{int}(t) [Volt]')
grid on

figure
plot(t_sinus,x_FM_sinus);
title('Sinus FM s(t)');
xlabel('t[s]')
ylabel('X_{FM}(t) [Volt]')
grid on

%% Integrierer mit Rect als Quellsignal
Fc_rect=100;
Fs_rect=1500;
Am=1;
t_rect = -2:1/Fs_rect:4;
s_rect=Am*rectpuls(t_rect,1);
figure;
subplot(3,1,1);
plot(t_rect,s_rect,'r');
title('s(t)')
xlabel('t[s]')
ylabel('s(t) [Volt]')
grid on

s_tau=filter([0 1],[1 -1],s_rect);
subplot(3,1,2);
plot(t_rect,s_tau,'g');
title('s_{int}(t)')
xlabel('t[s]')
ylabel('s_{int}(t) [Volt]')
grid on

x_FM_rect=Am*cos(s_tau + 2*pi*Fc_rect*t_rect);
subplot(3,1,3);
plot(t_rect,x_FM_rect,'b');
title('x_{FM}(t)')
xlabel('t[s]')
ylabel('X_{FM}(t) [Volt]')
axis([-2 4 -1 1.2]);
grid on;

%% Differenzierer von y_fm(t) mit sinus am Eingang
figure;
subplot(4,1,1);
plot(t_sinus, s_sinus);
title('s(t)')
xlabel('t[s]')
ylabel('s(t) [Volt]')
grid on

subplot(4,1,2);
plot(t_sinus,x_FM_sinus,'r');
title('y_{FM}(t) mit Sinus am Eingang');
xlabel('t[s]')
ylabel('y_{FM}(t) [Volt]')
grid on

subplot(4,1,3);
g_FM_sinus=filter([-1 1],[1 0],x_FM_sinus);
plot(t_sinus,g_FM_sinus);
title('dy_{FM}(kT_A )')
xlabel('t[s]')
ylabel('dy_{FM}(t) [Volt]')
grid on

subplot(4,1,4);
g_DRC_sin=movmax(g_FM_sinus,100);
plot(t_sinus,g_DRC_sin);
title('g(t)')
xlabel('t[s]')
ylabel('g(t) [Volt]')
grid on

%% Differenzierer von y_fm(t) mit Rect am Eingang
figure;
subplot(4,1,1);
plot(t_rect,s_rect,'r');
title('s(t)')
xlabel('t[s]')
ylabel('s(t) [Volt]')
grid on

g_FM_rect=filter([-1/1500 1/1500],[1/1500 0],x_FM_rect);
subplot(4,1,2);
plot(t_rect,x_FM_rect,'r');
title('y_{FM}(t) mit Rect am Eingang');
xlabel('t[s]')
ylabel('y_{FM}(t) [Volt]')
grid on

subplot(4,1,3);
plot(t_rect,g_FM_rect);
title('dy_{FM}(t) nach dem Integrierer mit Rect am Eingang')
xlabel('t[s]')
ylabel('dy_{FM}(t) [Volt]')
grid on

subplot(4,1,4)
g_DRC_rect=movmax(g_FM_rect,100);

plot(t_rect,g_DRC_rect-0.3);
title('g(t)')
xlabel('t[s]')
ylabel('g(t) [Volt]')
grid on

%% Nachvollziehen von Aufgabe 6
figure;
w_m=0.9;
[B,A]=butter(1,w_m);    %w_m=0.5Hz und N=5
abb_11=filter(B,A,g_DRC_rect);  %gefiltertes Signal
x_FM_rect=Am*cos(s_tau + 2*pi*100*t_rect)+1;

subplot(4,1,1);
plot(t_rect,x_FM_rect,'r');
title('y_{FM}(t) mit Rect am Eingang');
xlabel('t[s]')
ylabel('g(t) [Volt]')
grid on

subplot(3,1,2);
plot(t_rect,g_FM_rect,'g');
title('Signal nach dem differenzierer')
xlabel('t[s]')
ylabel('g(t) [Volt]')
grid on

subplot(3,1,3);
plot(t_rect,abb_11,'b');
%axis([-3 3 0 2])
title('g_{FM}(t) nach dem Hüllkurvendetektor')
xlabel('t[s]')
ylabel('g(t) [Volt]')
grid on

%% rekonstruktion des Quellsignals mit Sinus

