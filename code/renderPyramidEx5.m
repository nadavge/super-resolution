function image = renderPyramidEx5(pyr)
%RENDERPYRAMIDEX5 Summary of this function goes here
%Getting a pyramid and draw it into a single image
% Arguments:
% pyr - the pyramid
% 
% Outputs - 
% image - the rendered pyrmaid 
levels=length(pyr);
totalWidth=0;
for i=1:levels
    totalWidth=totalWidth+size(pyr{i},2);
end
totalHeight=size(pyr{7},1);
image=zeros(totalHeight,totalWidth);

startInd=1;
for i=1:levels
    im=pyr{i};
    image(1:size(im,1),startInd:size(im,2)+startInd-1)=im;
    startInd=size(im,2)+startInd;
end


end
