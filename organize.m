function newOrg = organize(prevOrg, curOrg)
    %return curOrg which is the curent organization of barycenters classified
    %depending on the previous one
    newOrg = [];
    for i=1:size(prevOrg(:,1)) % do it for each dot
        prevOrgRep = repmat(prevOrg(i,:), size(curOrg, 1), 1); % replicate the ith row of the previous organized matrix in order not to loop
        matDist = [];
        matDist = abs(curOrg-prevOrgRep); %delta matrix from the prevOrg[i] for each row of the current organization
        sumXYDist = [];
        for j=1:size(matDist,1) % sum x and y for each row
            sumXYDist(j,:) = sum(matDist(j,:));
        end
        index = find(sumXYDist == min(sumXYDist(:))); % pick the min value of the matrix and save its row
        newOrg(i,:) = curOrg(index,:); % ordonate matrix
    end
end
