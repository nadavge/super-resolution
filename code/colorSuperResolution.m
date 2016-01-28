function highres = colorSuperResolution( im )
% COLORSUPERRESOLUTION Super resolution an RGB image
    YIQ = rgb2ntsc(im);
    bigYIQ = rgb2ntsc(imresize(im,2,'cubic'));
    
    bigYIQ(:,:,1) = superResolution(YIQ(:,:,1));
    highres = ntsc2rgb(bigYIQ);
end
