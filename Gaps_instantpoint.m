load 031_03.mat

Gaps = V (:,4);
%Cleaning GAPS data:
%lmiting data on X axis values
Idx1=  -3000 > Gaps.x;
Gaps.x(Idx1) = 0;
Idx2= 0 < Gaps.x;
Gaps.x(Idx2) = 0;
%lmiting data on Y axis values
Idy1=Gaps.y > 1000;
Gaps.y(Idy1) = 0;
Idy2=Gaps.y < -1000;
Gaps.y(Idy2) = 0;
%lmiting data for Depth axis values
Idx=Gaps.depth > 450;
Gaps.depth(Idx) = 0;

for i = 1:length(Gaps.vtime) 
    plot3(Gaps.x(i), Gaps.y(i), Gaps.depth(i),'.')
    set(gca, 'ZDir','reverse','Xlim',[-3000 0],'Ylim',[-1000 1000], 'Zlim',[0 400]);
    grid
     % pause 1/10000 second: 
     pause(0.0001)
  end