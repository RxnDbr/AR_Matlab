function orga = organize(barys)
    % organize baryncenters, return an organize matrix of barycenters   
    points = [
        1,2,3,4;
        1,2,4,3;
        1,3,2,4;
        1,3,4,2;
        1,4,2,3;
        1,4,3,2 ]; % orgnization possibility depending on the first barycenter
    
    %test the orientation of each point depending on their neighboors    
    add1213 = (((barys(2,1)-barys(1,1)) * (barys(3,2)-barys(1,2))) - ((barys(2,2)-barys(1,2)) * (barys(3,1)-barys(1,1)))) > 0 ;
    add1314 = (((barys(3,1)-barys(1,1)) * (barys(4,2)-barys(1,2))) - ((barys(3,2)-barys(1,2)) * (barys(4,1)-barys(1,1)))) > 0 ;
    add1214 = (((barys(2,1)-barys(1,1)) * (barys(4,2)-barys(1,2))) - ((barys(2,2)-barys(1,2)) * (barys(4,1)-barys(1,1)))) > 0 ;
    add1413 = (((barys(4,1)-barys(1,1)) * (barys(3,2)-barys(1,2))) - ((barys(4,2)-barys(1,2)) * (barys(3,1)-barys(1,1)))) > 0 ;
    add1312 = (((barys(3,1)-barys(1,1)) * (barys(2,2)-barys(1,2))) - ((barys(3,2)-barys(1,2)) * (barys(2,1)-barys(1,1)))) > 0 ;
    add1412 = (((barys(4,1)-barys(1,1)) * (barys(2,2)-barys(1,2))) - ((barys(4,2)-barys(1,2)) * (barys(2,1)-barys(1,1)))) > 0 ;
 
    %create a matrix with solutions. Only one solution should be true
        
    sols = [] ;
    sols(1) = add1213 && add1314 ;
    sols(2) = add1214 && add1413 ;
    sols(3) = add1312 && add1214 ;
    sols(4) = add1314 && add1412 ;
    sols(5) = add1412 && add1213 ;
    sols(6) = add1413 && add1312 ;
    
    %find the index of the solution
    index = find(sols>0);
    
    %reorganize barycenters
    orga = [ barys(points(index,1), :); barys(points(index,2),:); barys(points(index,3),:); barys(points(index,4),:)] ; 
   
end
    
    
    