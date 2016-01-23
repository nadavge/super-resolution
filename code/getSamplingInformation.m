function [assignmentPositionsX,assignmentPositionsY,...
    samplingPositionsX,samplingPositionsY] = getSamplingInformation...
    (sampleCentersX,sampleCentersY,pyr,...
    inputPatchesCentersX,inputPatchesCentersY,levelsUp)
% GETSAMPLINGINFORMATION
% Get the information for sampling a high resolution image. Pairs of: 
%   assignment positions in the high resolution image,
%   and sampling positions from the rendered pyramid image
%
% Arguments:
% sampleCentersX ? (m ? 4) ª (n ? 4) ª 3 matrix with the x coordinates 
%   of the center of the high resolution patches in the rendered image.
%   This variable should be returned from getSamplingCenters function. 
%   (green x locations)
% sampleCentersY ? (m ? 4) ª (n ? 4) ª 3 matrix with the y coordinates
%   of the center of the high resolution patches in the rendered image.
%   his variable should be returned from getSamplingCenters function.
%   (green y locations).
% pyr ? 7 ª 1 cell created using createPyramid
% inputPatchesCentersX ? (m ? 4) ª (n ? 4) input patches center x coordinates
% inputPatchesCentersY ? (m ? 4) ª (n ? 4) input patches center y coordinates
% levelsUp ? integer which tells how much levels up we need to sample the
%   window, from the found patch. In the figure the case is levelsUp=1
%
% Outputs:
% assignmentPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x assignment
%   coordinates in the high resolution image (see figure)
% assignmentPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y assignment
%   coordinates in the high resolution image (see figure)
% samplingPositionsX ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 x sampling
%   coordinates in the rendered pyramid image (see figure)
% samplingPositionsY ? (m ? 4) ª (n ? 4) ª 3 ª 5 ª 5 y sampling
%   coordinates in the rendered pyramid image (see figure)
    ORIG_IMAGE = 4;
    % h = m-4, w = n-4
    [h, w] = size(inputPatchesCentersX);
    
    [patchX, patchY] = meshgrid(-2:2);
    % Transform to be of size 1x1x1x5x5
    patchX = permute(patchX, [3 4 5 1 2]);
    patchY = permute(patchY, [3 4 5 1 2]);
    % Transform to be of size (m-4)x(n-4)x3x5x5
    patchX = repmat(patchX, [h, w, 3]);
    patchY = repmat(patchY, [h, w, 3]);

    % Make the input patches for each of the assignments (3 assignments)
    inputPatchesCentersX = repmat(inputPatchesCentersX, [1, 1, 3]);
    inputPatchesCentersY = repmat(inputPatchesCentersY, [1, 1, 3]);
    
    % All the centers are from the original image
    levels = ORIG_IMAGE*ones(size(inputPatchesCentersX));
    
    % get upPixelsX, upPixelsY in size (m-4)x(n-4)
    [upPixelX, upPixelY, ~] = transformPointsLevelsUp(...
        inputPatchesCentersX, inputPatchesCentersY,...
        levels, pyr, levelsUp );
    
    % Transform to be of size (m-4)x(n-4)x3x5x5
    upPixelX = repmat(upPixelX, [1, 1, 3, 5, 5]);
    upPixelY = repmat(upPixelY, [1, 1, 3, 5, 5]);
    
    % Add the patchs shifts
    upPixelX = upPixelX + patchX;
    upPixelY = upPixelY + patchY;
    
    % Round the values, to see where the assignment would go
    assignmentPositionsX = round(upPixelX);
    assignmentPositionsY = round(upPixelY);
    
    % Calculate the shift from the rounded image indexes
    shiftX = assignmentPositionsX - upPixelX;
    shiftY = assignmentPositionsY - upPixelY;

    % Transform to be of size (m-4)x(n-4)x3x5x5
    sampleCentersX = repmat(sampleCentersX, [1, 1, 1, 5, 5]);
    sampleCentersY = repmat(sampleCentersY, [1, 1, 1, 5, 5]);
    
    samplingPositionsX = sampleCentersX + shiftX + patchX;
    samplingPositionsY = sampleCentersY + shiftY + patchY;
end
