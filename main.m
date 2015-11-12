clear all
close all

%base video
videoBase = VideoReader('vid_in.mp4');
nbImMax = videoBase.numberOfFrames;

%additional video
videoAdd = VideoReader('horse.avi');

%final video
videoFinal=avifile('FinalVideo.avi','compression','none');

Im1 = read(videoBase, 1); %1st image of the video

load('paramsDot.mat')

matDist = maha2(Im1, meanRGB, matCov);

ImBin1 = (matDist < threshold);

%Dialte dots in order to have only 4
SE = [0 1 0 ; 1 1 1; 0 1 0];
ImBin1 = imdilate(ImBin1, SE);

%label attribution randomly
[ImLab1, num] = bwlabel(ImBin1,4);

%barycenter research
%mean of the position of each point in a shape 
ImBar1 = barycenterCalc(ImLab1, num);

%the same organized 
ImBar1 = firstOrganize(ImBar1);
   
prevOrg = ImBar1; % 1st org

for n=1:nbImMax

     source = read(videoBase, n);
     
     Im = read(videoBase,n);
     [row, col] = size(Im);
     
     %model applicaiton
     %keep only interesting aerea (four next to the previous point)
     ImIZ = [];
     radius = 20; %region of interest around a barycenter
     ImBin = [];
     ImBin(1:row,1:col)=0;
     [rowPrev, colPrev] = size(prevOrg);
     
     for i=1:rowPrev %only keep a small zone in the image not to process all the image 
         ImIZ = Im( prevOrg(i,1)-radius: prevOrg(i,1)+radius ,  prevOrg(i,2)-radius: prevOrg(i,2)+radius,:); % cut an interesting zone in Im
         
         %figure, imshow(ImIZ)
         matDist = maha2(ImIZ, meanRGB, matCov);
         ImBinI = (matDist < threshold); 
         
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
     
     prevOrg = orga;
     
     %source = imread('lena.bmp'); %Test to Inlay an Image
     vecX=transpose(orga(:,2));
     vecY=transpose(orga(:,1));
     
     mask=uint8(zeros(row,col));

     frame.cdata= motif2frame(source, Im,vecX, vecY, 0.83, mask);
     %Apply the transformation
     %figure, imshow(frame.cdata); % Test the image concatenation
     videoFinal = addframe(videoFinal,frame.cdata);
    
end     
    
close(videoFinal);
close(videoAdd);
close(videoBase);

disp('New Video Saved !');
 








 
