function pyr = createPyramid( im )
%CREATEPYRAMID Create a pyramid from the input image
% Create pyr, a pyramid for im, where pyr{1} is the smallest level,
% pyr{4} is the input image, and pyr{5},pyr{6},pyr{7} are zeros.
% The ratio between two adjacent levels in the pyramid is 2^(1/3).
% Arguments:
% im ? a grayscale image
%
% outputs:
% pyr ? A 7 ª 1 cell of matrices.

    % Calculate the cubic root of a number
    cbrt = @(x) x.^(1/3);
    
    pyr = cell(7,1);
    pyr{1} = imresize(im, 0.5);
    pyr{2} = imresize(im, cbrt(0.25));
    pyr{3} = imresize(im, cbrt(0.5));
    pyr{4} = im;
    pyr{5} = zeros( round(cbrt(2)*size(im)) );
    pyr{6} = zeros( round(cbrt(4)*size(im)) );
    pyr{7} = zeros( 2*size(im) );

end

