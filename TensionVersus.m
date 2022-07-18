load 028_03.mat
Cable = V(:,10);
Ship = V(:,9);

t = round(linspace(1, length(Ship.groundspeed_knot), length(Cable.CableLength)));
SOG = Ship.groundspeed_knot(t);

Idx = Cable.CableLength > 32768;
Cable.CableLength(Idx) = 0;

figure

yyaxis left
plot(Cable.Tension, Cable.CableLength,'.')
title('Deployment 028_03')
xlabel('Cable Tension[Kg]')
xlim([0 3000])
ylabel('Cable Length[m]')

yyaxis right
plot(Cable.Tension, SOG,'.')
ylabel('SOG [Knot]')
ylim([0 14])
grid