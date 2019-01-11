%% setup
close all
clear
pause on
GraphicTimeDelay = 0.005;
%% create joint angle sequence
duration = rals_poc();
tstep = 0.01;
t = 0:tstep:duration;
ox_history = zeros(length(t),1);
oy_history = zeros(length(t),1);
oz_history = zeros(length(t),1);
phi_history = zeros(length(t),1);
theta_history = zeros(length(t),1);
psi_history = zeros(length(t),1);
r_history = zeros(length(t),1);
g_history = zeros(length(t),1);
b_history = zeros(length(t),1);
thetas_history = zeros(length(t),6);
    for i = 1:length(t)
        [~, ox_history(i), oy_history(i), oz_history(i), phi_history(i), ...
            theta_history(i), psi_history(i), r_history(i), g_history(i), ...
             b_history(i)] = rals_poc(t(i));
    end
%% Test
disp('Starting the test')
disp('Click in this window and press control-c to stop the code.')
h = plot_rals(0,0,0,0,0,0,[0,pi/2,-pi/2,0,0,0],0,0,0);
null = [];
%set(gcf,'Units','normalized','OuterPosition',[0 0 2 2])
    for j = 1:length(ox_history)
        R = eulerrotation(phi_history(j), theta_history(j), psi_history(j));
        O = [ox_history(j); oy_history(j); oz_history(j)];
        all_thetas = ik(O,R);
        sz = size(all_thetas,1);
        if sz == 0
            null = [null;j];
        end
        if j == 1
            thetas_history(j,:) = choose_solution(all_thetas,[0 pi/2 -pi/2 ...
                                    0 0 0]);
        else
            thetas_history(j,:) = choose_solution(all_thetas, ...
                                    thetas_history(j-1,:));
        end
        plot_rals(ox_history(j), oy_history(j), oz_history(j), ...
                    phi_history(j), theta_history(j), psi_history(j), ...
                    thetas_history(j,:),r_history(j),g_history(j), ...
                    b_history(j),h);
        title(['Pose ' num2str(j)]);
        %F(j) = getframe(gcf);
        pause(GraphicTimeDelay);
    end
    %video = VideoWriter('manit1','MPEG-4');
    %video.FrameRate = 50;
    %open(video)
    %writeVideo(video,F);
    %close(video)

