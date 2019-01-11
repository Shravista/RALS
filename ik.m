% performs inverse kinematics
function [thetas] = ik(O,R)
O = O(:);
thetas = zeros(4,6);
Oc = O - R(1:3,3);
thetas(:,1) = atan2(Oc(2),Oc(1));
thetas(1:2,3) = acos((Oc'*Oc-6.25)/6);
thetas(3:4,3) =-acos((Oc'*Oc-6.25)/6);
if isreal(thetas(:,3))
    for i = 1:4
        thetas(i,2) = atan2(Oc(3),sqrt(Oc(1:2)'*Oc(1:2))) - atan2(...
                        1.5*sin(thetas(i,3)), 2 + 1.5*cos(thetas(i,3)));
    end
R47 = cell(4,1);
    for j = 1:4
        q1 = thetas(j,1); q2 = thetas(j,2); q3 = thetas(j,3);
        r47 = R04(q1,q2,q3);
        R47{j} = r47\R;
    end
        for k = 1:2:4
            A = R47{k};
            thetas(k,5)   =  acos(A(3,3));
            thetas(k+1,5) = -acos(A(3,3));
        end
        for m = 1:4
            B = R47{m};
            if sin(thetas(m,5))>0
                thetas(m,4) = atan2(B(2,3),B(1,3));
                thetas(m,6) = atan2(B(3,2),-B(3,1));
            else
                thetas(m,4) = atan2(-B(2,3),-B(1,3));
                thetas(m,6) = atan2(-B(3,2),B(3,1));
            end
        end
else
    thetas = [];
end
end
%% preparatory function for the fourth frame
function R4 = R04(q1,q2,q3)
R4 = [ - cos(q1)*cos(q2)*sin(q3) - cos(q1)*cos(q3)*sin(q2),  sin(q1),...
                cos(q1)*cos(q2)*cos(q3) - cos(q1)*sin(q2)*sin(q3)
       - cos(q2)*sin(q1)*sin(q3) - cos(q3)*sin(q1)*sin(q2), -cos(q1),...
                cos(q2)*cos(q3)*sin(q1) - sin(q1)*sin(q2)*sin(q3)
           cos(q2)*cos(q3) - sin(q2)*sin(q3), 0, ...
           cos(q2)*sin(q3) + cos(q3)*sin(q2)];
end
