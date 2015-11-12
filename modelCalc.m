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


threshold = 550.0;


matDist = maha2(Im1, meanRGB, matCov);

ImBin1 = (matDist < threshold);


save('paramsDot.mat', 'meanRGB', 'matCov', 'threshold');