
%function J = jacob(pos,T)
J = cell(6,1);
Z = sym(zeros(3,6));
load com.mat com
com = sym(com);
Z(:,1) = sym([0;0;1]);
    for i = 2:6
        z_temp = T{i-1}(1:3,3);
        Z(:,i) = z_temp;
    end
 pos = pos';
 jw = [Z(:,1) sym(zeros(3,5))];
    com(:,2) = T{1}(1:3,:)*[com(:,2);1];
    com(:,3) = T{2}(1:3,:)*[com(:,3);1];
    for m = 4:6
        com(:,m) = T{m}(1:3,:)*[com(:,m);1];
    end
    for j = 1:6
        jv = sym(zeros(3,6));
        if j>1
            jw = [Z(:,1:j) sym(zeros(3,6-j))];
        end
        for k = 1:j
           jv(:,k) = cross(Z(:,k),(com(:,j)-pos(:,k))); 
        end
        J{j} = [jv;jw];
    end
         
%end

