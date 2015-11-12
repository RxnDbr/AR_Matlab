function ImBin = createImBin(Im, baryOrg, radius, meanRGB, matCov, threshold)

    %model applicaiton
    %keep only interesting zone (four next to the previous point)
    %IZ is for Interesting Zone
    
    ImIZ = []; %region of interest around a barycenter
    
    [row, col] = size(Im);
    
    ImBin = zeros(row,col);
    [rowBO, colBO] = size(baryOrg);
     
    for i=1:rowBO
        ImIZ = Im( baryOrg(i,1)-radius: baryOrg(i,1)+radius ,  baryOrg(i,2)-radius: baryOrg(i,2)+radius,:); % cut an interesting zone in Im
         
         %figure, imshow(ImIZ)
         matDist = maha2(ImIZ, meanRGB, matCov);
         ImBinIZ = (matDist < threshold); 
         
         %figure, imshow(ImBinI)
         ImBin(baryOrg(i,1)-radius:baryOrg(i,1)+radius , baryOrg(i,2)-radius:baryOrg(i,2)+radius) = ImBinIZ; % paste it in ImBin           
         %figure, imshow(im2bw(ImBin))
     end
     %figure, imshow(im2bw(ImBaseBin))
     
     SE = [0 1 0 ; 1 1 1; 0 1 0];
     
     ImBin = imdilate(ImBin, SE);