function orga = firstOrganize(barys)
    % organize baryncenters, return an organize matrix of barycenters   
    
    barys = define1stBar(barys);
    points = [
        1,2,3,4;
        1,2,4,3;
        1,3,2,4;
        1,3,4,2;
        1,4,2,3;
        1,4,3,2 ]; % orgnization possibility depending on the first barycenter
    
    i=1;
    [r,c] = size(points);
    pass = 0; %boolean
    while (i<=r) && (pass==0)
        part1 = prod2Vect(barys(points(i,1),:), barys(points(i,2),:), barys(points(i,3),:))> 0 ;   
        part2 = prod2Vect(barys(points(i,1),:), barys(points(i,3),:), barys(points(i,4),:))> 0 ;      
        pass = part1 && part2;
        i= i + 1;
    end
    orga = [];
    for n=1:4
        orga(n,:) = barys(points(i-1,n),:);   
    end  
end
      
function PV = prod2Vect(v1,v2,v3)
    PV = (v2(1) - v1(1) * v3(2) - v1(2)) - ...
        (v3(1) - v1(1) * v2(2) - v1(2));    
end

function barys = define1stBar(barys)
    for i=1:size(barys(:,1))
        sumBar(i) = sum(barys(i,:));
    end
    index = find (sumBar == min(sumBar));
    tmp(1,:) = barys(1,:);
    barys(1,:) = barys(index,:);
    barys(index,:) = tmp(1,:);
end

    