clear all
close all
video = VideoReader('vid_in.mp4');
Im = read(video, 100); %100th image of the video
%no hant at the beginning

%define model 

%select 2points 
figure, image(Im)
[x,y] = ginput(2);
pointA = [fix(x(1)) fix(y(1))];
pointB = [fix(x(2)) fix(y(2))];
ImSelect = Im(pointA(2):pointB(2), pointA(1):pointB(1), :);
%imshow(ImSelect)

colorVect = defineColorVect(Im, pointA, pointB);
R = colorVect(:, 1);
G = colorVect(:, 2);
B = colorVect(:, 3);

%calcul the mean and sigma matrix
meanRGB = [mean(R); mean(G); mean(B)];
matCov = cova(colorVect, meanRGB);

%create a binary image based on the values obtained with the 2 selected
%points

threshold = 50.0;

matDist = maha2(Im, meanRGB, matCov);

ImBin = (matDist < threshold);

SE = [0 1 0 ; 1 1 1; 0 1 0];
ImBin = imdilate(ImBin, SE);
imshow(ImBin)


save('paramsHand.mat', 'meanRGB', 'matCov', 'threshold');