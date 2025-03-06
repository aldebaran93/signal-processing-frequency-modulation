w=-pi:0.01:pi;
T_a = 1/1000;
h=freqz([0 1*T_a],[1*T_a -1*T_a],w);
subplot(2,1,1);
plot(w,abs(h));
title('Magnitude');
grid on
subplot(2,1,2);
plot(w,angle(h));
title('Phase')
grid on
