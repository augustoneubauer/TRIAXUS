load 024_01.mat 


Vcl=V(:,10);

%Plot of Cable Tension
figure
plot(Vcl.vtime, Vcl.Tension)
datetick('x','HH:MM:SS')
title('Cable Tension')
ylim([0 2500])
ylabel('[Kg]')
xlabel('Time')
grid
datetick2
