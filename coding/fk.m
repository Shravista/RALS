% performs forward Kinematics
function [pos,T] = fk(q)
    %The output of the function is position of various joints and
    %transformation matrices
    %q is the joint angle vector of size (6,1)
    A = cell(7,1);
    T = cell(7,1);
    pos = zeros(6,3);
    %e = 0.3;
    A{1} = compute_dh_matrix(0,pi/2,0,q(1));
    A{2} = compute_dh_matrix(2,0,0,q(2));      %a = 2
    A{3} = compute_dh_matrix(1.5,0,0,q(3));    %b= 1.5
    A{4} = compute_dh_matrix(0,pi/2,0,pi/2);   %intermediate frame
    A{5} = compute_dh_matrix(0,-pi/2,0,q(4));      
    A{6} = compute_dh_matrix(0,pi/2,0,q(5));
    A{7} = compute_dh_matrix(0,0,1,q(6));      %c = 1
    %A{7} = [eye(3) [0 0 -e]';zeros(1,3) 1];
    %A{8} = [eye(3) [g/2 3^0.5*g/2 -0.3]';zeros(1,3) 1];
    %A{9} = [eye(3) [g/2 -3^0.5*g/2 -0.3]';zeros(1,3) 1];
    %A{10} = [eye(3) [-g 0 -0.3]';zeros(1,3) 1];
    %A{11} = [eye(3) [g/2 3^0.5*g/2 0]';zeros(1,3) 1];
    %A{12} = [eye(3) [g/2 -3^0.5*g/2 0]';zeros(1,3) 1];
    %A{13} = [eye(3) [-g 0 0]';zeros(1,3) 1];
    T{1} = A{1};
    for j = 2:7
        T{j} = T{j-1}*A{j};
    end
    %for l = 7:13
    %    T{l} = T{6}*A{l};
    %end
    for k = 1:2
        const = T{k}(1:3,4);
        pos(k,:) = const';
    end
    posi = T{4}(1:3,4);
    pos(3,:) = posi;
    for k = 4:6
        const = T{k+1}(1:3,4);
        pos(k,:) = const';
    end
end