function ImBin = model(Im, mean, matCov)

    matDist = maha(Im, mean, matCov);
    threshold = 1500.0;
    ImBin = (matDist < threshold);
end
    
    





 