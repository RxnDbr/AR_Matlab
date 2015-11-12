clear all
close all

%base video
videoBase = VideoReader('vid_in.mp4');
nbImBaseMax = videoBase.numberOfFrames;

%additional video
videoAdd = VideoReader('horse.avi');

%final video
videoFinal = VideoWriter('FinalVideo.avi');

%=========================================================================
%PROCESS IN THE FIRST IMAGE OF THE VIDEO
%==========================================================================

ImBase1 = read(videoBase, 1); 
load('paramsDot.mat')
matDist = maha2(ImBase1, meanRGB, matCov);
ImBaseBin1 = (matDist < threshold);
%Dialte dots in order to have only 4
SE = [0 1 0 ; 1 1 1; 0 1 0];
ImBaseBin1 = imdilate(ImBaseBin1, SE);
%label attribution randomly
[ImBaseLab1, num] = bwlabel(ImBaseBin1,4);
%barycenter research
%mean of the position of each point in a shape 
ImBaseBar1 = barycenterCalc(ImBaseLab1, num);
%the same organized 
ImBaseBar1 = firstOrganize(ImBaseBar1);  
prevOrg = ImBaseBar1; % 1st org

%==========================================================================
%VIDEO PROCESSING
%==========================================================================

open(videoFinal)
for n=1:nbImBaseMax
     
     ImBase = read(videoBase,n);
     [row, col] = size(ImBase);
     
     ImAdd = read(videoAdd, n);

     ImBaseBin = createImBin(ImBase, prevOrg, 20, meanRGB, matCov, threshold);
     [ImBaseLab, num] = bwlabel(ImBaseBin, 4);
     ImBaseBar = barycenterCalc(ImBaseLab, num);
     orga = organize(prevOrg, ImBaseBar);
     prevOrg = orga; % orga n depends on orga n-1 
     
     vecX=transpose(orga(:,2));
     vecY=transpose(orga(:,1));
     
     mask=uint8(zeros(row,col));

     ImFinal = motif2frame(ImAdd, ImBase,vecX, vecY, 0.83, mask);
     writeVideo(videoFinal,ImFinal);
    
end   

close(videoFinal)

disp('New Video Saved !');
 








 
