function [ out_x,out_y ] = translateImageHalfPixel( im )
%TANSLATEIMAGEHALFPIXEL Summary of this function goes here
%Given an image return two images: out_x,out_y that are the result of shifting the image
%0.5 pixel right, and 0.5 pixel down respectively
% Arguments:
% im - the input image
%
% Outputs -
% out_x - the image translated 0.5 pixel right
% out_y - the image translated 0.5 pixel dowm
[h,w] = size(im);
im_new_y = zeros(h+1,w);
im_new_y(2:end,:) = im;
im_new_y(1,:) = im_new_y(2,:);
[X,Y] = meshgrid(1:w,1:h);
Y= Y+0.5;
out_y = interp2(im_new_y,X,Y,'cubic');

im_new_x = zeros(h,w+1);
im_new_x(:,2:end) = im;
im_new_x(:,1) = im_new_x(:,2);
[X,Y] = meshgrid(1:w,1:h);
X= X+0.5;
out_x = interp2(im_new_x,X,Y,'cubic');



end

