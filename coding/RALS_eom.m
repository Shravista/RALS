
%% intitializing
% initialize com and mass of each links properly
% mass of each link has taken unity kg for the sake simplicity
% g is accelaration due to gravity
%m = 1;
n = 6;                  % n is no of degrees of freedom
syms g real
syms(g,'real');
m = sym('m',[6,1]);     %mi is the mass of ith link
q = sym('q',[6,1]);     %qi is joint angle of joint i
qd = sym('qd',[6,1]);   %qdi is the angular velocity of the joint
qdd = sym('qdd',[6,1]); %qddi is the angular accelaration of the joint 
load transforms.mat T J
load com
com = sym(com);
com(:,2) = T{1}(1:3,:)*[com(:,2);1];
com(:,3) = T{2}(1:3,:)*[com(:,3);1];
  for k = 4:6
     com(:,k) = T{k}(1:3,:)*[com(:,k);1];
  end
 %% Potential Energy
 % update the mass values later based on solidworks results and then with
 % respect to the manufacturing
 ga = [sym(0);sym(0);-g]; %acceleration due to gravity vector in m/s^2
 PE = sym(0);
     for j = 1:6
         PE = PE + m(j)*ga'*com(:,j);
     end
 %% Inertia matrix D(q) and Kinetic Energy
 % qd is the rotational speed of the servo motor and needed to be updated
 % based on the actual RPM of the motor.
 % intertia tensor (I including the rotation matrix with respect to the 
 % base frame) particularly needed to be updated properly before simulation
 I = arrayfun(@(x) inertia_tensor(x), 1:n, 'UniformOutput', 0)';
 D = m(1)*(J{1}(1:3,:))'*J{1}(1:3,:) + (J{1}(4:6,:))'*I{1}*J{1}(4:6,:);
     for b = 1:6
         Jv = J{b}(1:3,:);
         Jw = J{b}(4:6,:);
         D = D + m(b)*(Jv)'*Jv + (Jw)'*I{b}*Jw;
     end
KE = 1/2*((qd)'*D*qd);
 %% Corolius matrix and PHI
 Cs = sym(zeros(6,6,6));
       for i1 = 1:6
           for j1 = 1:6
               for k1 = 1:6
                    diff1 = diff(D(k1,j1),q(i1));
                    diff2 = diff(D(k1,i1),q(j1));
                    diff3 = diff(D(i1,j1),q(k1));
                     Cs(i1,j1,k1) = (1/2)*(diff1+diff2-diff3)*qd(i1);
                end
           end
       end
 C = sym(zeros(6,6));    
       for i2 = 1:6
           for j2 = 1:6
               for k2 = 1:6
                   C(i2,j2) = C(i2,j2) +  Cs(k2,i2,j2);
               end
           end
       end

PHI = sym(zeros(6,1));
      for i3 = 1:6
           PHI(i3) = diff(PE,q(i3));
           PHI = PHI';
      end
%% EOM
% EOM will be the 6X1 vector.

EOM = D*qdd + C*qd + PHI;


%% inertia tensor
function tensor = inertia_tensor(num)

n = num2str(num);

tensor = [sym(['Ixx' n]) sym(['Ixy' n]) sym(['Ixz' n]);
          sym(['Iyx' n]) sym(['Iyy' n]) sym(['Iyz' n]);
          sym(['Izx' n]) sym(['Izy' n]) sym(['Izz' n])];

assume(tensor, 'real');

end


 
 
                 
     
         
 
         
         