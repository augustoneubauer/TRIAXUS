load 016_01.mat 

%Plot of Cable Tension
h(3) = subplot(3,1,3);
plot(Vcl.vtime, Vcl.Tension)
datetick('x','HH:MM:SS')
title('Cable Tension')
ylim([0 2500])
ylabel('[Kg]')
xlabel('Time')
grid
linkaxes(h,'x');
datetick2