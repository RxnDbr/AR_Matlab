function ImBar = barycenterCalc(ImLab, num)
    %barycenter research
    %mean of the position of each point in a shape
    ImBar = [];
    for i=1:num
         [X,Y] = find(ImLab==i);
         ImBar(i,:) = int32(mean([X,Y]));
         
    end
end