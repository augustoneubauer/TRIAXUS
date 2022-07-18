
load 020_02.mat

Vcl = V(:,1);
Gaps = V (:,4);

%Cleaning GAPS data:
%lmiting data on X axis values
Idx1=  -3000 > Gaps.x;
Gaps.x(Idx1) = NaN;
Idx2= 0 < Gaps.x;
Gaps.x(Idx2) = NaN;
%lmiting data on Y axis values
Idy1=Gaps.y > 1000;
Gaps.y(Idy1) = NaN;
Idy2=Gaps.y < -1000;
Gaps.y(Idy2) = NaN;
%lmiting data for Depth axis values
Idx=Gaps.depth > 450;
Gaps.depth(Idx) = NaN;

%Plot of GAPS lateral position over time
figure
h(1) = subplot(1,2,1);
plot(Gaps.y, Gaps.vtime,'.')
datetick('y', 'HH:MM.SS')
title('Lateral Displacement over time')
ylabel('Time')
xlabel('[m]')
xlim([-600 600])
grid

%Plot of Yaw flaps position and Command
h(3) = subplot(1,2,2);
plot(Vcl.PortYawFlapPosition, Vcl.vtime, Vcl.StarboardYawFlapPosition,Vcl.vtime)
datetick('y', 'HH:MM.SS')
ylabel('Time')
xlabel('[°]')
title('Yaw Flap')
xlim([-16 16])
grid

%Plot of GAPS distance from the ship over time
h(2) = subplot(1,2,2);
plot(Gaps.x, Gaps.vtime,'.')
datetick('y', 'HH:MM.SS')
xlim([-3000 0])
title('Distance from the ship over time')
ylabel('Time')
xlabel('[m]')
grid

