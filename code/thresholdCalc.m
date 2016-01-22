function [ thresh ] = thresholdCalc( im, imPatches )
%THRESHOLDCALC Calculate the threshold for the image
%   Find a threshold (maximum distance) for each input patch.
%   The threshold is calculated by shifting the image half a pixel in both
%   x and y directions, calculating the norm between the patches from the
%   original image and each of the shifted images, and then averaging.
    BORDER = 0;
    PATCH_AREA = 5*5;
    
    % Calculate the 2-norm of each row
    rowNorm = @(M) sqrt(sum(M.^2,2));
    [h, w, ~] = size(imPatches);
    
    [transX, transY] = translateImageHalfPixel( im );
    [~, ~, transX_patches] = samplePatches( transX, BORDER );
    [~, ~, transY_patches] = samplePatches( transY, BORDER );
    
    N = h*w;

    % Flatten the patches to the form [N x 25]
    transX_patches = reshape(transX_patches, N, PATCH_AREA);
    transY_patches = reshape(transY_patches, N, PATCH_AREA);
    imPatches_flat = reshape(imPatches, N, PATCH_AREA);
    
    % Each row is a different patch, calculate the norm of each row
    threshX = rowNorm(imPatches_flat - transX_patches);
    threshY = rowNorm(imPatches_flat - transY_patches);
    % Average the thresholds
    thresh = (threshX + threshY)/2;
    thresh = reshape(thresh, h, w);
end

