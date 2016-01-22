function [weights] = weightsSetting( imPatches, Dists, pyr ,dbPatchesStd )
% WEIGHTSSETTING Given 3 nearest neighbors for each patch of the input image
% Find a threshold (maximum distance) for each input patch.
% Next, give a weight for each candidate based on its distance from the input patch.
% denote m,n such that [m,n]=size(pyr{4})
% Arguments:
% imPatches - (m - 4) ª (n - 4) ª 5 ª 5 matrix with the patches that were
%   sampled from the input image (pyr{4})
% Dists - (m - 4) ª (n - 4) ª 3 matrix with the distances returned
%   from findNearestNeighbors.
% pyr - 7 ª 1 cell created using createPyramid
% dbPatchesStd - (m - 4) ª (n - 4) ª 3 matrix with the STDs of the
%   neighbors patches returned from findNearestNeighbors.
%
% Outputs:
% weights - (m - 4) ª (n - 4) ª 3 matrix with the weights for each DB candidates
    ORIG_INDEX = 4;
    
    thresh = thresholdCalc( pyr{ORIG_INDEX}, imPatches );
    weights = exp(- Dists.^2 ./ dbPatchesStd);
    
    % Indexes to keep, all first and second matches, and third matches that
    % pass the threshold (lower is better)
    keepIdx = zeros(size(weights));
    keepIdx(:,:,1) = 1; % All first matches
    keepIdx(:,:,2) = 1; % All second matches
    keepIdx(:,:,3) = Dists(:,:,3) <= thresh; % Threshold
    % Reset all indexes not meant for keeping
    weights(~keepIdx) = 0;
end