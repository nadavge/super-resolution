function [sampleCentersX,sampleCentersY,renderedPyramid] = ...
    getSamplingCenters( xCenters, yCenters,...
        centersPyrLevel , pyr, levelsUp )
% GETSAMPLINGCENTERS Given 3 nearest neighbors for each patch of the input
%   image, from the patches DB,
% find the location of parent patch in the rendered pyramid image
% Arguments:
% xCenters ? (m ? 4) ª (n ? 4) ª 3 matrix with the x coordinates of the
%   closest patches (child patches) to each sampled patch from the image
% yCenters ? (m ? 4) ª (n ? 4) ª 3 matrix with the y coordinates of the
%   closest patches (child patches) to each sampled patch from the image
% centersPyrLevel ? (m ? 4) ª (n ? 4) ª 3 matrix with the levels of the
%   closest patches to each sampled patch from the image
% pyr ? 7 ª 1 cell created using createPyramid
% levelsUp ? integer which tells how much levels up we need to sample
%   the parent patch, from the found patch.
%   In the figure the case is levelsUp=1.
%
% Outputs:
% sampleCentersX ? (m ? 4) ª (n ? 4) ª 3 matrix with the x coordinates of
%   the center of the patches in the rendered image (the green points in the figure)
% sampleCentersY ? (m ? 4) ª (n ? 4) ª 3 matrix with the y coordinates of
%   the center of the patches in the rendered image (the green points in the figure)
% renderedPyramid ? a single image containing all levels of the pyramid

    renderedPyramid = renderPyramidEx5(pyr);
    [xPos, yPos, levels] = transformPointsLevelsUp( xCenters, yCenters,...
        centersPyrLevel,pyr,levelsUp );
    
    sampleCentersX = zeros(size(xPos));
    sampleCentersY = yPos;
    
    offset = 0;
    for i=1:7,
       sampleCentersX(levels==i) = sampleCentersX(levels==i) + offset;
       offset = offset + size( pyr{i}, 2 );
    end
end