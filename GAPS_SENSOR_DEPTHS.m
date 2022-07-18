load 020_02.mat 
Gaps = V(:,4);
Gapstime = V(:,3);
Vcl = V(:,1);

t = round(linspace(1, length(Gaps.depth), length(Vcl.vtime)));
GapsDepth = Gaps.depth(t);

b = round(linspace(1, length(Gapstime.time_GAPS), length(Vcl.vtime)));
Gapstime = Gapstime.time_GAPS(b);
figure

plot (Gapstime, GapsDepth,'.', Vcl.vtime, Vcl.Depth,'Linewidth',2);
datetick('x', 'HH:MM.SS')
xlabel('Time')
ylabel('[m]')
title('Depth Sensor and GAPS Depth')
set(gca, 'YDir','reverse')
grid
datetick2
