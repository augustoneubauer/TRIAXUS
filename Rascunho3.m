load 027_03.mat
Cable = V(:,10);
Vcl = V(:,1);

t = round(linspace(1, length(Vcl.Depth), length(Cable.CableLength)));
Depth = Vcl.Depth(t);

Idx = Cable.CableLength > 32768;
Cable.CableLength(Idx) = 0;

figure

yyaxis left
plot(Cable.Tension, Cable.CableLength,'.')
xlabel('Cable Tension[Kg]')
ylabel('Cable Length[m]')

yyaxis right
plot(Cable.Tension, Depth,'.')
ylabel('Depth [m]')
grid minor 