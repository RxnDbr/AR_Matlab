function A = cova(colorVect, meanRGB)
a11 = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,1)-meanRGB(1)));
a12 = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,2)-meanRGB(2)));
a13 = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,3)-meanRGB(3)));
a22 = mean((colorVect(:,2)-meanRGB(2)).* (colorVect(:,2)-meanRGB(2)));
a23 = mean((colorVect(:,2)-meanRGB(2)).* (colorVect(:,3)-meanRGB(3)));
a33 = mean((colorVect(:,3)-meanRGB(3)).* (colorVect(:,3)-meanRGB(3)));

A = [a11, a12, a13; a12, a22, a23; a13, a23, a33];
end