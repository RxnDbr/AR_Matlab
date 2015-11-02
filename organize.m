function orga = organize(prevOrg, curOrg)
%return curOrg which is the curent organization of barycenters classified
%depending on the previous one
orga = [];
for i=1:size(curOrg(:,1)) % do it for each dot
    prevOrgRep = repmat(prevOrg(i,:), size(curOrg, 1), 1); % replicate the ith row of the previous organized matrix in order not to loop
    A = [];
    A = abs(curOrg-prevOrgRep); %delta matrix from the prevOrg[i] for each row of the current organization
    sumA = [];
    for j=1:size(A,1) % sum x and y for each row
        sumA(j,:) = sum(A(j,:));
    end
    index = find(sumA == min(sumA(:))); % pick the min value of the matrix and save its row
    orga(i,:) = curOrg(index,:); % ordonate matrix
end