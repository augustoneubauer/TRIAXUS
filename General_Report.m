%% Loading the data from the respective Deployment. First, is plotted some general parameters of the operation

load 020_02.mat

%Cable Length and Speed over ground
Cable = V(:,10);
Ship = V(:,9);
%Adjusting array sizes to fit with same length
t = round(linspace(1, length(Ship.groundspeed_knot), length(Cable.CableLength)));
SOG = Ship.groundspeed_knot(t);
%This indexing is used, following the instructions of the protocol
%description, to avoid negative values that should be displayed as 0 m
Idx = Cable.CableLength > 32768;
Cable.CableLength(Idx) = 0;

%Ploting Cable length, Speed oevr ground ans time in the same graph
h(1) = subplot(3,1,1)
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

%Ploting Vehicles depth over time
Vcl = V(:,1);

h(2) = subplot(3,1,2);
plot (Vcl.vtime, Vcl.Depth)
datetick('x', 'HH:MM.SS')
ylim([-15 360])
xlabel('Time')
ylabel('[m]')
title('Vehicles Depth')
set(gca, 'YDir','reverse') %to reverse Y axis direction
grid minor
datetick2

%Ploting Yaw flaps command
Cmd = V(:,2);

h(3) = subplot(3,1,3)

plot(Cmd.vtime, Cmd.YawFlapCommand)
datetick('x','HH:MM:SS')
ylim([-16 16])
ylabel('[°]')
xlabel('Time')
title('Yaw flaps Command')
grid minor
datetick2

linkaxes(h,'x');
%% Visualization of Vehicles Real Depth, the Depth Command and the Cable Neutral Point

Vcl = V(:,1);

NewDepthCmd = Vcl.DepthCmd/100; %Is divided per 100 to adjust the unit size to meters
figure 
plot (Vcl.vtime, Vcl.Depth,'b', Vcl.vtime, NewDepthCmd,'r', Vcl.vtime, Vcl.CableNeutralDepth,'k')
datetick('x', 'HH:MM.SS')
title('Real Depth, Depth Comman and Cable Neutral Point')
legend({'Vehicle Depth','Depth Command','Cable Neutral Point'},'Location','southeast')
ylim([0 520])
xlabel('Time')
ylabel('[m]')
set(gca, 'YDir','reverse')
grid
datetick2

%% Ploting ship position over time and also the GAPS position 

Vcl = V(:,5);
Gaps = V(:,3);
figure
plot (Gaps.longitude_GAPS, Gaps.latitude_GAPS,'.',Vcl.longitude, Vcl.latitude,'Linewidth',1)
legend({'GAPS Track','Polarstern Track'},'Location','southeast')
title('Ship and GAPS position along the operation')
xlabel('Longitude West [°]')
ylabel('Latitude[°]')
grid

%%
%Ploting GAPS data

Gaps = V (:,4);
Vcl = V (:,1);

%Cleaning GAPS data:
%lmiting data on X axis values
Idx1=  -3000 > Gaps.x;
Gaps.x(Idx1) = NaN;
Idx2= 0 < Gaps.x;
Gaps.x(Idx2) = NaN;
%lmiting data on Y axis values
Idy1=Gaps.y > 600;
Gaps.y(Idy1) = NaN;
Idy2=Gaps.y < -600;
Gaps.y(Idy2) = NaN;
%lmiting data for Depth axis values
Idx=Gaps.depth > 450;
Gaps.depth(Idx) = NaN;

%3D plot of GAPS postion 
figure
plot3(Gaps.x, Gaps.y, Gaps.depth,'.')
set(gca, 'ZDir','reverse')
title('3D image of GAPS points')
ylabel('y')
xlabel('x')
zlabel('Depth')
grid

%Plot of GAPS lateral position over time. This is the lateral distance from
%the ship 
figure
plot(Gaps.y, Gaps.vtime,'.')
datetick('y', 'HH:MM.SS')
title('Lateral Displacement over time')
ylabel('Time')
xlabel('[m]')
grid

%Plot of GAPS distance from the ship over time
figure
plot(Gaps.x, Gaps.vtime,'.')
datetick('y', 'HH:MM.SS')
title('Distance from the ship over time')
ylabel('Time')
xlabel('[m]')
grid

%Plot of GAPS lateral and Yaw flap position over time
figure
a(1) = subplot(1,2,1);
plot(Gaps.y, Gaps.vtime,'.')
datetick('y', 'HH:MM.SS')
title('Lateral Displacement over time')
ylabel('Time')
xlabel('[m]')
xlim([-600 600])
grid

%Plot of Yaw flaps position and Command
a(2) = subplot(1,2,2);
plot(Vcl.PortYawFlapPosition, Vcl.vtime, Vcl.StarboardYawFlapPosition,Vcl.vtime)
datetick('y', 'HH:MM.SS')
ylabel('Time')
xlabel('[°]')
title('Yaw Flap')
xlim([-16 16])
grid
linkaxes(a,'y')

%% Flap analysis

Vcl = V(:,1);
Cmd = V(:,2);
%Plot of Pitch flaps position and Command
figure
h(1) = subplot(3,1,1);
plot(Vcl.vtime, Vcl.UpperPitchFlapPosition,'r', Vcl.vtime, Vcl.LowerPitchFlapPosition,'g',Cmd.vtime, Cmd.PitchFlapCommand,'k')
datetick('x', 'HH:MM.SS')
ylabel('[°]')
xlabel('Time')
title('Position and Command of Pitch Flaps')
grid
datetick2


%Plot of Yaw flaps position and Command
h(2) = subplot(3,1,2);
plot(Vcl.vtime, Vcl.PortYawFlapPosition,'r', Vcl.vtime, Vcl.StarboardYawFlapPosition,'g',Cmd.vtime, Cmd.YawFlapCommand,'k')
datetick('x', 'HH:MM.SS')
ylabel('[°]')
xlabel('Time')
title('Position and Command of Yaw Flaps')
grid
datetick2

%Plot of Roll flaps position
h(3) = subplot(3,1,3);
plot(Vcl.vtime, Vcl.RollFlapPosition,'r', Cmd.vtime, Cmd.RollFlapCommand,'k')
datetick('x', 'HH:MM.SS')
title('Position of Roll Flaps in Red and Roll Flaps Command in Black')
xlabel('Time')
ylabel('[°]')
grid
linkaxes(h,'x');
datetick2

%% Attitude of the Vehicle

%Plot of heading sensor over time
Vcl = V(:,1);
figure
h(1) = subplot(3,1,1);
plot(Vcl.vtime, Vcl.Heading)
datetick('x', 'HH:MM.SS')
title('Vehicles Heading')
ylabel('[°]')
xlabel('Time')
grid on 
datetick2

%Plot of Roll Sensor over time 
h(2) = subplot(3,1,2);
plot(Vcl.vtime, Vcl.RollSensorValue)
datetick('x', 'HH:MM.SS')
title('Vehicles Roll')
ylabel('[°]')
xlabel('Time')
grid on
datetick2

%Plot of Pitch sensor over time 
h(3)= subplot(3,1,3);
plot(Vcl.vtime, Vcl.PitchSensorValue)
datetick('x', 'HH:MM.SS')
title('Vehicles Pitch')
ylabel('[°]')
xlabel('Time')
grid on
linkaxes(h,'x');
datetick2

%% Winch System

Vcl=V(:,10);

%Plot of Cable Length
%This indexing is used, following the instructions of the protocol
%description, to avoid negative values that should be displayed as 0 m.
Idx = Vcl.CableLength > 32768; 
Vcl.CableLength(Idx) = 0;
h(1) = subplot(3,1,1);
plot (Vcl.vtime, Vcl.CableLength);
datetick('x', 'HH:MM.SS')
ylim([0 3000])
title('Cable Length')
xlabel('Time')
ylabel('Cable Length[m]')
grid
datetick2

% Plot of Cable Speed
%This indexing is made to exclude some points that seems to be "out of
%range", more specifically there are three points with a very high value
Idx = Vcl.CableSpeed > 1000;
Vcl.CableSpeed(Idx) = 0;
%This division is done, following the instructions at the protocol
%description, to correct the unit size
NewCableSpeed = Vcl.CableSpeed/10;
h(2) = subplot(3,1,2);
plot(Vcl.vtime, NewCableSpeed)
datetick('x','HH:MM:SS')
title('Cable Speed')
ylabel('[m/min]')
xlabel('Time')
grid
datetick2

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

%% Main Supply System 

Vcl = V (:,1);

%Main supply Voltage
figure
%This is used to plot the average of each 100 points. I did it to exclude
%some spikes and high frequency oscillations
mins = 1 : length(Vcl.vtime);
window = 100;
meanSupplyVoltage = movmean (Vcl.MainsSupplyVoltage, window);
c(1) = subplot(2,1,1);
plot(Vcl.vtime, Vcl.MainsSupplyVoltage,Vcl.vtime, meanSupplyVoltage,'Linewidth',1)
datetick('x','HH:MM:SS')
title('Main supply Voltage')
legend({'Main supply Voltage', 'Average of Main supply Voltage over 100 samples window'},'Location','southeast')
ylabel('[V]')
xlabel('Time')
grid
datetick2

%Main supply current Draw
MainCurrentDraw = Vcl.MainsSupplyCurrentDraw * 10^3; %Correction of unit size
%plot the average of each 100 points
mins = 1 : length(Vcl.vtime);
window = 100;
meanSupplyCurrentDraw = movmean (MainCurrentDraw, window);
c(2) = subplot(2,1,2);
plot(Vcl.vtime, MainCurrentDraw, Vcl.vtime, meanSupplyCurrentDraw,'Linewidth',1 )
datetick('x','HH:MM:SS')
title('Main supply Current Draw')
ylabel('[A]')
xlabel('Time')
grid
linkaxes (c,'x');
datetick2

%% Battery Supply

figure
%Battery Voltage
%plot the average of each 100 points
mins = 1 : length(Vcl.vtime);
window = 100;
meanVoltage = movmean (Vcl.BatteryVoltage, window);
a(1) = subplot(2,1,1);
plot(Vcl.vtime, Vcl.BatteryVoltage,Vcl.vtime,meanVoltage,'Linewidth',1)
datetick('x','HH:MM:SS')
title('Battery Voltage')
legend({'Battery Voltage', 'Average of Battery Voltage over 100 samples window'},'Location','southeast')
ylim([40 50])
ylabel('[V]')
xlabel('Time')
grid
datetick2


%Battery current Draw
BatteryCurrent = Vcl.BatteryCurrentDraw * 10^3; %Correction of unit size
%plot the average of each 100 points
mins = 1 : length(Vcl.vtime);
window = 100;
meanCurrent = movmean (BatteryCurrent, window);
a(2) = subplot(2,1,2);
plot(Vcl.vtime, BatteryCurrent, Vcl.vtime, meanCurrent,'Linewidth',1)
legend({'Battery Current Draw', 'Average of Battery Current Draw over 100 samples window'},'Location','southeast')
datetick('x','HH:MM:SS')
title('Battery Current Draw')
ylabel('[A]')
xlabel('Time')
grid
linkaxes (a,'x');
datetick2

%% Motors Supply

%Motors Voltage
%plot the average of each 100 points
mins = 1 : length(Vcl.vtime);
window = 100;
meanVoltageMotors = movmean (Vcl.VoltageMotors, window);
figure
b(1) = subplot(2,1,1);
plot(Vcl.vtime, Vcl.VoltageMotors, Vcl.vtime, meanVoltageMotors,'Linewidth',1)
legend({'Motors Voltage', 'Average of Motors Voltage over 100 samples window'},'Location','southeast')
datetick('x','HH:MM:SS')
ylabel('[V]')
xlabel('Time')
grid
datetick2


%Motors current Draw
MotorsCurrent = Vcl.CurrentDrawMotors * 10^3; %Correction of unit size
%plot the average of each 100 points
mins = 1 : length(Vcl.vtime);
window = 100;
meanCurrentDrawMotors = movmean (MotorsCurrent, window);
b(2) = subplot(2,1,2);
plot(Vcl.vtime, MotorsCurrent, Vcl.vtime, meanCurrentDrawMotors,'Linewidth',1)
legend({'Motors Current', 'Average of Motors Current over 100 samples window'},'Location','southeast')
datetick('x','HH:MM:SS')
title('Motors Current Draw')
ylabel('[A]')
xlabel('Time')
grid
linkaxes(b,'x');
datetick2

%% CPU Temperature
%Correcting array length
t = round(linspace(1, length(C.time), length(Vcl.vtime)));
Time = C.time(t);
Temp = round(linspace(1, length(C.tem), length(Vcl.vtime)));
Temp = C.tem(t);

diff = (Vcl.WaterTemp ./ Vcl.CoreTemp)*100;

figure
h(1) = subplot(2,1,1);
plot(Vcl.vtime, Vcl.CoreTemp,'r', Vcl.vtime, Vcl.WaterTemp,Time, Temp,'b','Linewidth',1)
datetick('x','HH:MM:SS')
title('Temperatures')
legend({'CPU Temperature','PT1000 Temperature','Water Temperature'},'Location','southeast')
ylabel('[°C]')
ylim([0 85])
xlabel('Time')
grid
datetick2

%Plot each 100 points to avoid spikes and high frequency oscillations
mins = 1 : length(Vcl.vtime);
window = 100;
meandiff = movmean (diff, window);

h(2) = subplot(2,1,2);
plot(Vcl.vtime, diff, Vcl.vtime,meandiff,'Linewidth',1)
title('Percentage of PT1000 temperature in relation to CPU temperature')
xlabel('Time')
ylabel('%')
grid
datetick2
