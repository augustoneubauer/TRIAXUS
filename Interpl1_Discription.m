clear all
close all
clc

load 012_01.mat

[time(1).time, time(1).index] = unique(V(1).vtime);
depth = interp1(V(1).vtime,V(1).Depth(time(1).index),V(4).vtime,'nearest');

figure(1)
hold on
grid on
grid minor
plot(V(1).vtime,V(1).Depth,'.g',V(4).vtime,depth,'b')
xlabel('time')
ylabel('depth')
legend({'depth timebase 1','depth timebase 2'})

