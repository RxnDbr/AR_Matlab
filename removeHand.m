function imageWithoutHand = removeHand(imageBase, imageWithHand)
     load('paramsHand.mat')
    
     imageWithoutHand = imageWithHand;
     
     matDist = maha2(imageBase, meanRGB, matCov);

     ImBin = (matDist < threshold);
     SE = [0 1 0 ; 1 1 1; 0 1 0];
     ImBin = imdilate(ImBin, SE);
     
     [r,c] = find(ImBin);
     for i=1:size(r)
        imageWithoutHand(r(i),c(i),:) = imageBase(r(i), c(i));
     end
     
end