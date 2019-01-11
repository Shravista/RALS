function hout = plot_rals(x, y, z, phi, theta, psi,q, redValue, greenValue, blueValue, hin)
% x,y,z are the desired position of goal frame
% phi,theta,psi are the desired euler angles of goal frame
% q is the joint variables vector of length 6 storing six joint variables
%% CHECK THE INPUTS
if sum(isnan(q))>0
    q(1) = 0;
    q(2) = pi/2;
    q(3) = -pi/2;
    q(4:6) = 0;
    pcolor =  [1 0 0];
else
     pcolor = .8*[1 .88 .75];
end
%% Forward Kinematics
[pos,T] = fk(q);
o6 = pos(6,:)';
R = T{7}(1:3,1:3);
% gives the end effector axis length and orientation of each axis with 
% respect to the base frame
x60 = [o6 o6 + 8*R(:,1)];
y60 = [o6 06 + 8*R(:,2)];
z60 = [o6 06 + 8*R(:,3)];
%% Euler config
sph = sin(phi);
cph = cos(phi);
sth = sin(theta);
cth = cos(theta);
sps = sin(psi);
cps = cos(psi);
Rdes = [cph -sph   0 ; sph cph  0 ;    0 0   1] * ...
       [cth    0 sth ;   0   1  0 ; -sth 0 cth ] * ...
       [cps -sps   0 ; sps cps  0 ;    0 0   1];
odes = [x ; y ; z];
Hdes = [Rdes odes; 0 0 0 1];
odes = [odes ; 1];
vlen = 2; % length of the axis vector
xdes = [odes (Hdes * [vlen 0 0 1]')];
ydes = [odes (Hdes * [0 vlen 0 1]')];
zdes = [odes (Hdes * [0 0 vlen 1]')];
%% plot robot
if (nargin == 11)
     hrobot = hin(1);
    hx60 = hin(2);
    hy60 = hin(3);
    hz60 = hin(4);
    hxdes = hin(5);
    hydes = hin(6);
    hzdes = hin(7);
    set(hrobot, 'xdata', pos(:,1), 'ydata', pos(:,2), ...
        'zdata', pos(:,3),'color',pcolor);
    set(hx60, 'xdata', x60(1,:), 'ydata', x60(2,:), 'zdata', x60(3,:));
    set(hy60, 'xdata', y60(1,:), 'ydata', y60(2,:), 'zdata', y60(3,:));
    set(hz60, 'xdata', z60(1,:), 'ydata', z60(2,:), 'zdata', z60(3,:));
    if (((redValue ~= 0) || (greenValue ~= 0)) || blueValue ~= 0)
        hold on
        plot3(o6(1),o6(2),o6(3),'.','color',[redValue greenValue blueValue],...
            'markersize',5);
        hold off
    end
    set(hxdes, 'xdata', xdes(1,:), 'ydata', xdes(2,:), 'zdata', xdes(3,:));
    set(hydes, 'xdata', ydes(1,:), 'ydata', ydes(2,:), 'zdata', ydes(3,:));
    set(hzdes, 'xdata', zdes(1,:), 'ydata', zdes(2,:), 'zdata', zdes(3,:));
    hout = hin;
else
    hrobot = plot3(pos(:,1), pos(:,2), pos(:,3), ...
        '.-','linewidth',7,'markersize',35,'color',pcolor);
    hold on
    hx60 = plot3(x60(1,:), x60(2,:), x60(3,:), 'w:', 'linewidth',2);
    hy60 = plot3(y60(1,:), y60(2,:), y60(3,:), 'w--', 'linewidth',2);
    hz60 = plot3(z60(1,:), z60(2,:), z60(3,:), 'w-', 'linewidth',2);
    if (((redValue ~= 0) || (greenValue ~= 0)) || blueValue ~= 0)
        plot3(o6(1),o6(2),o6(3),'.','color',[redValue greenValue blueValue],'markersize',25);
    end
    hxdes = plot3(xdes(1,:), xdes(2,:), xdes(3,:), ':', 'linewidth',2,'color',[.5 .5 .5]);
    hydes = plot3(ydes(1,:), ydes(2,:), ydes(3,:), '--', 'linewidth',2,'color',[.5 .5 .5]);
    hzdes = plot3(zdes(1,:), zdes(2,:), zdes(3,:), '-', 'linewidth',2,'color',[.5 .5 .5]);
    hold off
    xlabel('X (mm)')
    ylabel('Y (mm)')
    zlabel('Z (mm)')
    set(gca,'color',[.1 .1 .1])
    scale_f = 5;
    axis equal vis3d
    axis([-1 1 -1 1 -1 1]*scale_f);
    %axis([-3.1081  3.5586 -3.3272 3.3395 0 3.5])
    view(37.5,28.4) %% 37.5 28.4 -110.4,40.8
    hout = [hrobot; hx60; hy60; hz60; hxdes; hydes; hzdes];
end

