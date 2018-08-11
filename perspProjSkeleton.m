function [] = perspProjSkeleton()
% Functions and test cases for implementation of perspective
% projection in MATLAB
% Author: Cameron Walker
% Date: 23 Feb 2018
% Completed Functionality: Mitchell Faulconbridge 14/3/18

function [P] = makePPMat(x,y,z)
 % make Perspective projection matrix to project from (x,y,z)
 % into the xy-plane
 
 P=[1 0 -x/z 0;0 1 -y/z 0;0 0 0 0;0 0 -1/z 1];
 
end

function [] = generatePlot(pts,xlims,ylims) 
 % This function uses the plot() function 
 % to plot the 2D vertex position of pts in the xy-plane
 % with xlims giving the x-axis range
 % and ylims giving the y-axis range
 % Note: the input pts are in 4D homogeneous coordinates
 %       so need to be transformed to give x* and y*
  
 projPts = pts([1:2],:)./pts(4,:);
 
 plot( projPts(1,[1,2]),projPts(2,[1,2]))
 hold on;

 plot(projPts(1,[1,4]),projPts(2,[1,4]))
 plot( projPts(1,[1,16]),projPts(2,[1,16]))
 plot( projPts(1,[3,2]),projPts(2,[3,2]))
 plot( projPts(1,[2,15]),projPts(2,[2,15]))
 plot( projPts(1,[3,4]),projPts(2,[3,4]))
 plot( projPts(1,[3,6]),projPts(2,[3,6]))
 plot( projPts(1,[5,4]),projPts(2,[5,4]))
 plot( projPts(1,[5,6]),projPts(2,[5,6]))
 plot( projPts(1,[5,7]),projPts(2,[5,7]))
 plot( projPts(1,[8,6]),projPts(2,[8,6]))
 plot( projPts(1,[8,7]),projPts(2,[8,7]))
 plot( projPts(1,[9,7]),projPts(2,[9,7]))
 plot( projPts(1,[8,10]),projPts(2,[8,10]))
 plot( projPts(1,[9,10]),projPts(2,[9,10]))
 plot( projPts(1,[9,11]),projPts(2,[9,11]))
 plot( projPts(1,[12,10]),projPts(2,[12,10]))
 plot( projPts(1,[12,11]),projPts(2,[12,11]))
 plot( projPts(1,[13,11]),projPts(2,[13,11]))
 plot( projPts(1,[12,14]),projPts(2,[12,14]))
 plot( projPts(1,[13,14]),projPts(2,[13,14]))
 plot( projPts(1,[13,16]),projPts(2,[13,16]))
 plot( projPts(1,[15,14]),projPts(2,[15,14]))
 plot( projPts(1,[15,16]),projPts(2,[15,16]))
 xlim(xlims)
 ylim(ylims)
 hold off;
end

function [] = renderImage(pts, p, xlims,ylims) 
 % This function renders the image of the Toyota wire-frame
 % with Points 1 to 16 in positions given by the columns of pts
 % from the viewing position p. xlims gives the x-axis range
 % and ylims gives the y-axis range

 P = makePPMat(p(1),p(2),p(3));
 transPts = P*pts;
 generatePlot(transPts,xlims,ylims)
end

function [Rx] = makeXRotMat(theta) 
 % make matrix to rotate theta radians around the x-axis

 Rx=[1 0 0 0;0 cos(theta) -sin(theta) 0;0 sin(theta) cos(theta) 0;0 0 0 1];

end

function [Ry] = makeYRotMat(theta) 
 % make matrix to rotate theta radians around the x-axis

 Ry=[cos(theta) 0 sin(theta) 0;0 1 0 0;-sin(theta) 0 cos(theta) 0;0 0 0 1];
 
end

function [Rz]= makeZRotMat(theta) 
 % make matrix to rotate theta radians around the x-axis

 Rz=[cos(theta) -sin(theta) 0 0;sin(theta) cos(theta) 0 0;0 0 1 0;0 0 0 1];

end

function [A] = makeZoomMat (X) 
 % make matrix to scale by scaleFactor X

 A=[X 0 0 0;0 X 0 0;0 0 X 0;0 0 0 1];
 
end

pts = [-6.5,-6.5,-6.5,-6.5,-2.5,-2.5,-.75,-.75,3.25,3.25,4.5,4.5,6.5,6.5,6.5,6.5;
        -2,-2,.5,.5,.5,.5,2,2,2,2,.5,.5,.5,.5,-2,-2;
        -2.5,2.5,2.5,-2.5,-2.5,2.5,-2.5,2.5,-2.5,2.5,-2.5,2.5,-2.5,2.5,2.5,-2.5;
         1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
xlims = [min(pts(1,:))-8,max(pts(1,:))+8];
ylims = [min(pts(2,:))-8,max(pts(2,:))+8];

%Tests from Computer Graphics in Automotive Design

%Figure 3:
subplot(2,2,1);
renderImage(pts,[0,0,10],xlims,ylims);title('Figure 3');

%Figure 4:
subplot(2,2,2);
renderImage(pts,[10,5,10],xlims,ylims);title('Figure 4');

% %Figure 5:
subplot(2,2,3);
rotPts = makeXRotMat(pi/4)*pts;
renderImage(rotPts,[0,0,10],xlims,ylims);title('Figure 5');

% %Figure 6 
subplot(2,2,4);
zoomPts = makeZoomMat(2)*pts;
renderImage(zoomPts,[0,0,10],xlims,ylims);title('Figure 6');

end

