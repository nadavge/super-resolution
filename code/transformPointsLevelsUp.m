function [ xPositions,yPositions,levels ] = transformPointsLevelsUp( xPositions,yPositions,levels,pyr,levelsUp )
%TRANSFORMPOINTSLEVELSUP Summary of this function goes here
% Given position of points in some levels of the pyramid,  return their
% location in an upper levels of the pyramid.
% Arguments:
% xPositions - MxNxK matrix of x positions in the pyramid
% yPositions - MxNxK matrix of y positions in the pyramid
% levels -   MxNxK matrx with the levels in the pyramid of each point.
% pyr - the pyramid
% levelsUp - integer that indicates how much levels up each point should go, so if for
% example the point is at level 2, and levelsUp=1 the returned point will
% at level 3
% 
% Outputs - 
% xPositions - MxNxK matrix of new x positions in the pyramid
% yPositions - MxNxK matrix of new y positions in the pyramid
% levels -   MxNxK matrx with the levels in the pyramid of each new point.

for i=1:(7-levelsUp)
    xResizeFactor=size(pyr{i+levelsUp},2)/size(pyr{i},2);
    yResizeFactor=size(pyr{i+levelsUp},1)/size(pyr{i},1);
    xPositions(levels==i)=xResizeFactor*xPositions(levels==i)-0.5*xResizeFactor*(1-1/xResizeFactor);
    yPositions(levels==i)=yResizeFactor*yPositions(levels==i)-0.5*yResizeFactor*(1-1/yResizeFactor);
end
levels=levels+levelsUp;

end

