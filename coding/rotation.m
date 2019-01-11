function [rotx,roty,rotz]=rotation(theta)
[m , n]=size(theta);
if m==1
    if n==1
        rotx = [1 0 0;0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
        roty = [cos(theta) 0 sin(theta);0 1 0;-sin(theta) 0 cos(theta)];
        rotz = [cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
    end
else 
    error('"Theta" must be a "Scalar"');
end


end