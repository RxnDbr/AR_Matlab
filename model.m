function ImBin = model(Im, mean, matCov)

    matDist = maha(Im, mean, matCov);
    threshold = 550.0;
    ImBin = (matDist < threshold);
end
    
    





 