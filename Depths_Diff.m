%%
load 020_02.mat
Vcl = V(:,1);

Idx = Vcl.CableLength > 32768;
Vcl.CableLength(Idx) = 0;


Diff = (Vcl.CableNeutralDepth - Vcl.Depth);

figure
h(1) = subplot(4,2,1);
area(Vcl.vtime, Diff)
datetick('x','HH:MM:SS')
ylabel('[m]')
title('020_02:Difference between Cable Neutral point and Depth sensor')
ylim([-100 400])
grid minor
datetick2


NewDepthCmd = Vcl.DepthCmd/100;
Error = (NewDepthCmd - Vcl.Depth);

h(2) = subplot(4,2,3);
area(Vcl.vtime, Error)
datetick('x','HH:MM:SS')
ylabel('[m]')
title('Difference between Depth sensor and Depth Command')
grid minor
datetick2

h(3) = subplot(4,2,2);
plot (Vcl.vtime, Vcl.Depth,'b', Vcl.vtime, NewDepthCmd,'r', Vcl.vtime, Vcl.CableNeutralDepth,'k')
datetick('x', 'HH:MM.SS')
title('020_02:Real Depth, Depth Comman and Cable Neutral Point')
legend({'Vehicle Depth','Depth Command','Cable Neutral Point'},'Location','southeast')
ylim([0 520])
xlabel('Time')
ylabel('[m]')
set(gca, 'YDir','reverse')
grid minor
datetick2


Cable = V(:,10);
Ship = V(:,9);
t = round(linspace(1, length(Ship.groundspeed_knot), length(Cable.CableLength)));
SOG = Ship.groundspeed_knot(t);
Idx = Cable.CableLength > 32768;
Cable.CableLength(Idx) = 0;

h(4) = subplot(4,2,4)
yyaxis left
plot(Cable.vtime, Cable.CableLength)
datetick('x', 'HH:MM.SS')
ylabel('Cable Length[m]')

yyaxis right
plot(Cable.vtime, SOG)
datetick('x', 'HH:MM.SS')
ylabel('SOG [Knot]')
grid minor
datetick2
