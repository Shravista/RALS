%clear 
close all
pause on
GraphingTimeDelay = 0.005;
totalTimeSteps = 1000;
a = zeros(6,1);
%g0 = 0;
%g1 = 0.5;
b = [2*pi/3,pi/2,-pi/2,pi/4,pi/3,0];
%b = zeros(6,1);
figure
scale_f = 5;
axis vis3d
axis(scale_f*[-1 1 -1 1 -1 1])
grid on
view(70,10)
xlabel('X (mm.)')
ylabel('Y (mm.)')
zlabel('Z (mm.)')
hold on
%[0 0 2.5], [0 0 0], [0 2 2] [0 2 3.5 4.5], [0 0 0 0], [0 0 0 0]
rals_fk = plot3([0 4.5], [0 0], [0 0],'k.-','linewidth',2,'markersize',10);
plot3([-10 10 0 0 0 0],[0 0 -10 10 0 0],[0 0 0 0 -10 10]);
pause(GraphingTimeDelay);

for i = 1:totalTimeSteps
   
    t = i/totalTimeSteps;
    q = [a(1)*(1-t) + b(1)*(t), a(2)*(1-t) + b(2)*(t), a(3)*(1-t) + b(3)*(t), a(4)*(1-t) + b(4)*(t), a(5)*(1-t) + b(5)*(t), a(6)*(1-t)+b(6)*(t)];
    %g = g0*(1-t) + g1*(t);
    pos = fk(q);
    set(rals_fk,'xdata',pos(:,1)','ydata',pos(:,2)','zdata',pos(:,3)')
    F(i) = getframe(1);
    pause(GraphingTimeDelay);
end
video = VideoWriter('rals1','MPEG-4');
video.FrameRate = 60;
open(video)
writeVideo(video,F);
close(video)


