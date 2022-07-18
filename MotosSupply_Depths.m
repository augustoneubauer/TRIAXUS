%% Here is possible to visualize the Real Depth of the Vehicle (in blue), the Depth Command (in red) and th Cable Neutral Point (in black) 
load 016_01.mat 

Vcl = V(:,1);

NewDepthCmd = Vcl.DepthCmd/100;
figure 
h(1) = subplot (2,1,1);
plot (Vcl.vtime, Vcl.Depth,'b', Vcl.vtime, NewDepthCmd,'r', Vcl.vtime, Vcl.CableNeutralDepth,'k')
datetick('x', 'HH:MM.SS')
title('Real Depth, Depth Command and Cable Neutral Point')
legend({'Vehicle Depth','Depth Command','Cable Neutral Point'},'Location','southeast')
xlabel('Time')
ylabel('[m]')
set(gca, 'YDir','reverse')
grid
datetick2

%Motors current Draw
MainCurrentDraw = Vcl.MainsSupplyCurrentDraw * 10^3; %Correction of unit size
h(2) = subplot(2,1,2);
yyaxis left
plot(Vcl.vtime, MainCurrentDraw)
datetick('x', 'HH:MM.SS')
xlabel('Time')
ylabel('Motors Current[A]')
yyaxis right
plot(Vcl.vtime, Vcl.VoltageMotors)
datetick('x', 'HH:MM.SS')
ylabel('Motors Voltage [V]')
datetick2

linkaxes(h,'x');