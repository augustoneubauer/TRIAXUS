load 031_03.mat 
adcp = A(:,1);
figure
plot(adcp.soundspeed, adcp.time)
datetick('y','HH:MM:SS')
grid
