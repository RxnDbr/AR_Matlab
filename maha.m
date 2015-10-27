function newIm = maha(image, meanRGB, matCov)
%a est un scalaire pour un point

%xi - m trans* mat cov inverse* xi-m
sizeI = size(image);
length = sizeI(:,2);
width = sizeI(:,1);
newIm = [];
image = double(image);
 
compDeux = inv(matCov);
compTrois = [image(:,:,1) - meanRGB(1), image(:,:,2) - meanRGB(2), image(:,:,3) - meanRGB(3)];
% calc1 = comp2 *comp3;
% newIm = comp3 .* calc1;

 for x=1:width
     for y=1:length
         xi = [double(image(x,y,1));double(image(x,y,2)); double(image(x,y,3))] ;
         comp1 = (xi-meanRGB).';
         comp2 = inv(matCov);
         comp3 = (xi-meanRGB);
         
         dist = comp1*comp2*comp3;
         newIm(x,y) = dist;
     end
end
newIm;
end

