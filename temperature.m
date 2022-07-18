%%Temperatures of PT1000 and CPU for one deployment over time
load 016_01.mat 
Vcl = V (:,1);

t = round(linspace(1, length(C.time), length(Vcl.vtime)));
Time = C.time(t);
Temp = round(linspace(1, length(C.tem), length(Vcl.vtime)));
Temp = C.tem(t);

diff = (Vcl.WaterTemp ./ Vcl.CoreTemp)*100;

mins = 1 : length(Vcl.vtime);
window = 100;
meandiff = movmean (Vcl.CoreTemp, window);

figure
plot(Vcl.vtime, Vcl.CoreTemp,'.', Vcl.vtime, Vcl.WaterTemp,'.',Time, Temp,'.',Vcl.vtime,meandiff,'.')
datetick('x','HH:MM:SS')
title('Temperatures 016')
legend({'CPU Temperature','PT1000 Temperature','Water Temperature'},'Location','southeast')
ylabel('[°C]')
ylim([0 85])
xlabel('Time')
grid
datetick2

