function orga = organize(prevOrg, curOrg)
%return curOrg which is the curent organization of barycenters classified
orga = [];
prevOrg = prevOrg(:,1).'; % keep only one axis because of treatment
prevOrgRep = repmat(prevOrg(1,:), size(curOrg(:,1)),1); % replicate previous matrix to apply minus calculation
for i=1:size(curOrg(:,1)) % do it for each dot
    a = [];
    a(i,:) = abs(curOrg(:,1)-prevOrgRep(:,i)); %dist matrix 
    index = find( a(i,:)== min(a(i,:))); % pick the best one
    orga(i,:) = curOrg(index,:); % ordonate matrix
end
end