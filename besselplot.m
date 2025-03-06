close all;
clear all;
clc

z = 0:0.1:20;
J = ones(5,201)*9; %zufällige gleichtverteilte Werten
J_5=[];
m=7;
fs=50;  %Signal frequency
fc=3000;    %carrier frequency
Fa=6000;    %Abtastfrequenz

% Calculate Carson's bandwidth using the formula
bw_carson = 2 * (m + 1)*100;  % Carson's bandwidth
window = 1000 + bw_carson/2;
%calculate the bessel coeff and the function x_fm
for i = 0:20
    J(i+1,:) = besselj(i,z);
    J_5(i+1) = besselj(i,m);
    X_fm(i+1) = cumsum(J_5(i+1));
end

w=1:0.1:3;  %Zeitvektor für die x-Achse
stem(w,X_fm);
xlabel('$\frac{\omega}{2\pi 1000} \longrightarrow$','interpreter','latex','FontSize',20)
ylabel('$X_{FM}(\omega) \longrightarrow$','interpreter','latex','FontSize',20)
ylim([-0.4 0.6])
grid on

% Calculate the frequency axis for the spectrum
frequencies = linspace(1, 3, length(X_fm));
% Calculate the width of the spectrum
spectrum_width = sum(abs(frequencies) <= bw_carson/2);

fprintf('Carson''s Bandwidth: %.2f Hz\n', bw_carson);
fprintf('Spectrum Width: %.2f Hz\n', spectrum_width);

% Compare Carson's bandwidth with the actual spectrum width
if abs(bw_carson - spectrum_width) < 1e-2
    fprintf('Validation Successful: Carson''s bandwidth matches the spectrum width.\n');
else
    fprintf('Validation Failed: Carson''s bandwidth does not match the spectrum width.\n');
end
figure
labels={'J_0(m)','J_1(m)','J_2(m)','J_3(m)','J_4(m)','J_5(m)'};
plot(z,J)
xlabel('$m \longrightarrow$','interpreter','latex')
ylabel('$J_n(m) \longrightarrow$','interpreter','latex')
title('Plot mit zufälligen Gleichverteilten Werten')
axis([0 10 -0.5 1]);
grid on;

