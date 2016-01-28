function [image] = getImage(assignmentPositionsX,assignmentPositionsY,...
    samplingPositionsX,samplingPositionsY,weights,emptyHighResImage,renderedPyramid)
% GETIMAGE given an image of the rendered pyrmamid, sampling indices from
%   the rendered pyrmamid, and assignment indices in the highres image
%   return a high resolution image
%
% Arguments:
% assignmentPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x assignment
%   coordinates in the high resolution image (getSamplingInformation output)
% assignmentPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y assignment
%   coordinates in the high resolution image (getSamplingInformation output)
% samplingPositionsX - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 x sampling coordinates
%   in the rendered pyramid image (getSamplingInformation output)
% samplingPositionsY - (m - 4) ª (n - 4) ª 3 ª 5 ª 5 y sampling coordinates
%   in the rendered pyramid image (getSamplingInformation output)
% weights - (m - 4) ª (n - 4) ª 3 matrix with the weights for each DB candidate
% emptyHighResImage - M ª N zeros image, where M and N are the dimensions
%   of a level in the pyramid that should be reconstructed in this function
% renderedPyramid - a single image containing all levels of the pyramid
%
% Outputs:
% image - M ª N high resolution image
    PATCH_SIZE = 5;

    numerator = emptyHighResImage;
    denominator = emptyHighResImage;
    % The image in the current iteration
    currIm = emptyHighResImage;
    currWeightsIm = emptyHighResImage;
    
    % Y offsets for the patches
    for i=1:PATCH_SIZE,
        % X offsets for the patches
        for j=1:PATCH_SIZE,
            % Which child match to take out of the three
            for k=1:3,
                currSamplePosX = samplingPositionsX(...
                    i:PATCH_SIZE:end,...
                    j:PATCH_SIZE:end,k,:,:);
                currSamplePosY = samplingPositionsY(...
                    i:PATCH_SIZE:end,...
                    j:PATCH_SIZE:end,k,:,:);
                currAssignPosX = assignmentPositionsX(...
                    i:PATCH_SIZE:end,...
                    j:PATCH_SIZE:end,k,:,:);
                currAssignPosY = assignmentPositionsY(...
                    i:PATCH_SIZE:end,...
                    j:PATCH_SIZE:end,k,:,:);
                
                currWeights = weights(i:PATCH_SIZE:end, j:PATCH_SIZE:end, k);
                % Transfer it to be HxWx5x5 where H,W are the original ones
                currWeights = repmat(currWeights, [1, 1, PATCH_SIZE, PATCH_SIZE]);
                
                [sampledIm] = interp2(renderedPyramid,...
                    currSamplePosX,currSamplePosY,'cubic',0);
                
                % Create a subscript for the sampled pixels for assignment
                I = sub2ind(size(emptyHighResImage), currAssignPosY, currAssignPosX);
                % Assign the sampled image and calculate add the results to
                % the numerator and denominator
                currIm(I) = sampledIm;
                currWeightsIm(I) = currWeights;
                
                numerator = numerator + currIm.*currWeightsIm;
                denominator = denominator + currWeightsIm;
            end
        end
    end
    
    image = numerator ./ denominator;
    % Get rid of NaNs from division by zero for unassigned pixels
    image(isnan(image)) = 0;
end