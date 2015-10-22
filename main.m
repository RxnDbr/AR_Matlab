clear all
close all
video = VideoReader('vid_in.mp4');
Im1 = read(video, 1); %1st image of the video

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

meanRGB = [mean(R); mean(G); mean(B)];
matCov = cova(colorVect, meanRGB);
nbImMax = video.numberOfFrames;

ImBin = model(Im1, meanRGB, matCov);
%figure, imshow(im2bw(ImBin))
%label
SE = [0 1 0 ; 1 1 1; 0 1 0];
ImBin = imdilate(ImBin, SE);
%figure , imshow(im2bw(ImBin))

[ImLab, num] = bwlabel(ImBin,4);
%barycenter research
%mean of the position of each point in a shape
truc = find(ImLab, 1);




% for n=1:nbImMax
%     Im = read(video, n);
%     %model applicaiton
%     ImBin = model(Im, meanRGB, matCov);
%     %label
%     ImLab = bwlabel(ImBin, 4);
%     %barycenter research
%     
%     %barycenter position
%     %homography
%     %superimposition
%     
% end








 