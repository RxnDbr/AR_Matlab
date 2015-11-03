clear all
close all
video = VideoReader('vid_in.mp4');
Im1 = read(video, 1); %1st image of the video

%define model with the 1st image

%select 2points 
figure, image(Im1)
[x,y] = ginput(2);
pointA = [fix(x(1)) fix(y(1))];
pointB = [fix(x(2)) fix(y(2))];
ImSelect = Im1(pointA(2):pointB(2), pointA(1):pointB(1), :);


colorVect = defineColorVect(Im1, pointA, pointB);
R = colorVect(:, 1);
G = colorVect(:, 2);
B = colorVect(:, 3);

%calcul the mean and sigma matrix
meanRGB = [mean(R); mean(G); mean(B)];
matCov = cova(colorVect, meanRGB);

%create a binary image based on the values obtained with the 2 selected
%points
ImBin1 = model(Im1, meanRGB, matCov);
% to see it : figure, imshow(im2bw(ImBin))

%Dialte dots in order to have only 4
SE = [0 1 0 ; 1 1 1; 0 1 0];
ImBin1 = imdilate(ImBin1, SE);
%figure , imshow(im2bw(ImBin))

%label attribution randomly
[ImLab1, num] = bwlabel(ImBin1,4);

%barycenter research
%mean of the position of each point in a shape 
ImBar1 = barycenterCalc(ImLab1, num);

%the same organized 
ImBar1 = firstOrganize(ImBar1);
   
nbImMax = video.numberOfFrames;
prevOrg = ImBar1; % 1st org

for n=2:nbImMax %start at the second image, we've already studied the 1st
     Im = read(video, n);
     %model applicaiton
     
     %keep only interesting aerea (four next to the previous point)
     ImIZ = [];
     radius = 30;
     ImBin = [];
     [row, col] = size(Im);
     ImBin(1:row,1:col)=0;
     [rowPrev, colPrev] = size(prevOrg);
     for i=1:rowPrev %only keep a small zone in the image not to process all the image : it reduce 
         
         ImIZ = Im(prevOrg(i,1)-radius:prevOrg(i,1)+radius , prevOrg(i,2)-radius:prevOrg(i,2)+radius,:); % cut an interesting zone in Im
         %figure, imshow(ImIZ)
         ImBinI = model(ImIZ, meanRGB, matCov); 
         %figure, imshow(ImBinI)
         ImBin(prevOrg(i,1)-radius:prevOrg(i,1)+radius , prevOrg(i,2)-radius:prevOrg(i,2)+radius) = ImBinI; % paste it in ImBin           
         %figure, imshow(im2bw(ImBin))
     end
     %figure, imshow(im2bw(ImBin))
     
     SE = [0 1 0 ; 1 1 1; 0 1 0];
     ImBin = imdilate(ImBin, SE);
     
     %label
     [ImLab, num] = bwlabel(ImBin, 4);
     %barycenter research
     
     ImBar = barycenterCalc(ImLab, num); % curent organization
     %barycenter organization depending on the previous organization
     orga = organize(prevOrg, ImBar);
     
     %homography
     %superimposition
     prevOrg = orga;
     
 end








 
