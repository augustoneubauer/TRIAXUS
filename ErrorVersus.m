load 032_01.mat
Vcl = V(:,1);
Cable = V(:,10);
Ship = V(:,9);

t = round(linspace(1, length(Ship.groundspeed_knot), length(Cable.CableLength)));
SOG = Ship.groundspeed_knot(t);

d = round(linspace(1, length(Vcl.DepthCmd), length(Cable.CableLength)));
DepthCmd = Vcl.DepthCmd(d);

c = round(linspace(1, length(Vcl.Depth), length(Cable.CableLength)));
Depthh = Vcl.Depth(c);

Idx = Cable.CableLength > 32768;
Cable.CableLength(Idx) = 0;

NewDepthCmd = DepthCmd/100;
Error = (NewDepthCmd - Depthh);

figure

yyaxis left
plot(Error, Cable.CableLength,'.')
title('032_01')
xlim([-50 50])
xlabel('Error [m]')
ylabel('Cable Length[m]')

yyaxis right
plot(Error, SOG,'.')
xlim([-50 50])
ylabel('SOG [Knot]')
grid