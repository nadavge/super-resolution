images = {'butterfly.png','zebra.png', 'fish.png'};

for filename=images,
    filename = filename{1};
    im = im2double(imread(filename));
    bigim = imresize(im, 2, 'cubic');
    tic;
    result = colorSuperResolution(im);
    toc;
    
    figure; imshow(im);
    figure; imshow(bigim);
    figure; imshow(result);
end
