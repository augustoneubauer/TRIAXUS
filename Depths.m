%% Here is possible to visualize the Real Depth of the Vehicle (in blue), the Depth Command (in red) and th Cable Neutral Point (in black) 
load 031_03.mat
Vcl = V(:,1);

NewDepthCmd = Vcl.DepthCmd/100; %Correction of unit size
figure 
h(1) = subplot(2,1,1);
plot (Vcl.vtime, Vcl.Depth,'b', Vcl.vtime, NewDepthCmd,'r', Vcl.vtime, Vcl.CableNeutralDepth,'k')
datetick('x', 'HH:MM.SS')
title('Real Depth, Depth Comman and Cable Neutral Point')
legend({'Vehicle Depth','Depth Command','Cable Neutral Point'},'Location','southeast')
xlabel('Time')
ylabel('[m]')
set(gca, 'YDir','reverse')
grid
datetick2

%Ploting the Cable Length during the time
Vcl = V(:,10);

Idx = Vcl.CableLength > 32768; %Used this value from the protocol description 
Vcl.CableLength(Idx) = 0;

h(2) = subplot(2,1,2);
plot (Vcl.vtime, Vcl.CableLength);
datetick('x', 'HH:MM.SS')
ylim([0 3000])
title('Cable Length')
xlabel('Time')
ylabel('Cable Length[m]')
grid
datetick2

linkaxes(h,'x');
