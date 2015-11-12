function matCov = cova(colorVect, meanRGB)

matCov = [];

matCov(1,1) = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,1)-meanRGB(1)));
matCov(1,2) = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,2)-meanRGB(2)));
matCov(1,3) = mean((colorVect(:,1)-meanRGB(1)).* (colorVect(:,3)-meanRGB(3)));
matCov(2,1) = mean((colorVect(:,2)-meanRGB(2)).* (colorVect(:,2)-meanRGB(2)));
matCov(2,2) = mean((colorVect(:,2)-meanRGB(2)).* (colorVect(:,3)-meanRGB(3)));
matCov(2,3) = mean((colorVect(:,3)-meanRGB(3)).* (colorVect(:,3)-meanRGB(3)));

end