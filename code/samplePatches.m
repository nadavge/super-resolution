function [p_x, p_y, patches] = samplePatches( im , border )
% SAMPLEPATCHES Sample 5 ª 5 patches from the input image.
% Arguments:
% im ? a grayscale image of size m ª n
% border ? An integer that determines how much border we want to leave
% in the image.
% For example:
%   if border=0 the center of the first patch will be at (3,3),
%   and the last one will be at (end?2,end?2), so the number of patches
%   in this case is (m ? 4) ª (n ? 4).
%   But, if border=1 the center of the first patch will be at (4,4) and
%   the last one will be at (end?3,end?3).
%
% In general, the number of patches is
%   (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)).
%
% outputs:
% p_x ? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) matrix with the
%   x indices of the centers of the patches
% p_y ? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) matrix with the
%   y indices of the centers of the patches
% patches? (m ? 2 · (2 + border)) ª (n ? 2 · (2 + border)) ª 5 ª 5 the patches
    PATCH_SIZE = 5;

    % The offset from the edges for the border
    offset = border + (PATCH_SIZE-1)/2;
    [m, n] = size(im);
    
    m_patches = (m - 2*offset); % Number of rows in patches
    n_patches = (n - 2*offset); % Number of cols in patches
    
    % Fill the p_x and p_y beforehand
    [p_x, p_y] = meshgrid(1:n_patches, 1:m_patches);
    p_x = p_x + offset;
    p_y = p_y + offset;
    
    patches = zeros( m_patches, n_patches, 5, 5 );
    for i=1:m_patches,
        for j=1:n_patches,
            patches(i,j,:,:) = im(i+border:i+border+PATCH_SIZE-1,...
                                  j+border:j+border+PATCH_SIZE-1);
        end
    end
    
end