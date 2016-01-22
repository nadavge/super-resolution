function [p_x, p_y,levels, patches] = createDB( pyr )
% CREATEDB Sample 5 ª 5 patches from levels 1,2,3 of the input pyramid.
% N represents the number of patches that are found in the three images.
%
% Arguments:
% pyr ? 7 ª 1 cell created using createPyramid
%
% Outputs:
% p_x ? N ª 1 vector with the x coordinates of the centers of the patches in the DB
% p_y ? N ª 1 vector with the y coordinates of the centers of the patches in the DB
% levels ? N ª 1 vector with the pyramid levels where each patch was sampled
% patches ? N ª 5 ª 5 the patches

    BORDER = 2; % To avoid problems later when resizing
    PATCH_SIZE = 5;
    
    p_x = [];
    p_y = [];
    levels = [];
    patches = [];
    
    for level=1:3,
        [curr_px, curr_py, curr_patches] = samplePatches( pyr{level}, BORDER );
        N = numel(curr_px);
        
        curr_levels = ones( N, 1 );
        curr_levels(:) = level;
        
        curr_patches = reshape( curr_patches, N, PATCH_SIZE, PATCH_SIZE );
        
        p_x = [p_x; curr_px(:)];
        p_y = [p_y; curr_py(:)];
        levels = [levels; curr_levels];
        patches = cat(1, patches, curr_patches); 
    end
end