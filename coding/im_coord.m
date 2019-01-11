% Script: im_coord.m
% the following script is to generate the coordinates of image manually 
%  after generating [x y] vectors of curve location,
%  then compute a least squares fit of degree d using
%  matlab functions. 
%   x0 and y0 are origin location
%   lenscale is normalization to physical scale
  clear 
  close all
  I = imread('MANIT.png'); % update  the image acording to the requirement
  I = rgb2gray(I);
  I = imresize(I,0.15);
  imshow(I)
  disp('Click on 112 input points on the curve')
  [x, y] = ginput(112);  % click points on a curve, end is auto
  center = size(I)/2 + .5;    % origin at middle of VGA image
  x0 = center(1);
  y0 = center(2);
  lenscale = 50;         % 50 pixels/meter?
  %d = 2;                 % degree of
  xs = (x-x0)/lenscale; ys = (y-y0)/lenscale;
  %c = polyfit(xs,ys,d);
  %xvals = linspace(min(xs),max(xs));
  %yvals = polyval(c,xvals);
  figure
  plot(xs,ys,'r')
  title('0.15 image scale')
  xlabel('x axis')
  ylabel('y axis')
  hold on
  grid on
  len = length(xs);
  o = zeros(len,2);
  [~,~,rotz] = rotation(-pi);
  for i = 1:len
    a = [xs(i) ys(i) 0]';
    a = rotz*a;
   o(i,:) = a(1:2)';
  end
  plot(o(:,1),o(:,2),'k--')
  o(:,1) = o(:,1) + 0.98;
  o(:,2) = o(:,2) + 2.5;
  plot(o(:,1),o(:,2),'m')

hold off
  