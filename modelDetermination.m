clear all
close all
video = VideoReader('vid_in.mp4');
Im = read(video, 1); %prend la première image de la vidéo

figure, image(Im)
[x,y] = ginput(2);
pointA = [fix(x(1)) fix(y(1))];
pointB = [fix(x(2)) fix(y(2))];
ImSelect = Im(pointA(2):pointB(2), pointA(1):pointB(1), :);
%figure, image(ImSelect)

colorVect = defineColorVect(Im, pointA, pointB);
R = colorVect(:, 1);
G = colorVect(:, 2);
B = colorVect(:, 3);

meanRGB = [mean(R); mean(G); mean(B)];
matCov = cova(colorVect, meanRGB);

matDist = maha(Im, meanRGB, matCov);
%matDistSelected = maha(ImSelect, meanRGB, matCov);
threshold = 500.0;
ImBin = (matDist < threshold);
figure, imshow(im2bw(ImBin))



 