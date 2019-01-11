function A = compute_dh_matrix(r,alpha,d,theta)
%r - the length of the common normal
%alpha - angle about common normal from old z to new z
%d - offset along previous z to the common normal
%theta - angle about previous z, from old x to new x
%computes the DH-Link transformation matrix
[~,~,Rz] =rotation(theta);
[Rx,~,~] = rotation(alpha);
dz = [eye(3) [0;0;d];0 0 0 1];
dx = [eye(3) [r;0;0];0 0 0 1];
Rz = [Rz [0;0;0];0 0 0 1];
Rx = [Rx [0;0;0];0 0 0 1];
A = Rz*dz*dx*Rx;
end