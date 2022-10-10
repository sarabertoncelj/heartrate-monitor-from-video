%Za izračun bboxov
%load('GlobalVariables.mat')
msrmt = '63-61_2';
inputVideoFile = strcat(msrmt, '.mp4');
outputVideoFile = strcat('OutputVideos/', inputVideoFile);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();
% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader(inputVideoFile);
%fnShowFaceBFMap(inputVideoFileName, inputVideoFilePath, bbox, RGBFaceMapDATA, 80, 30)
for x = 1:GV.nX
    for y = 1:GV.nY  
    RGBData = squeeze(RGBFaceMapDATA(:,x,y,:));
    [k, HR, HRW, P_HR, P_HRW] = fnGetHeartRate(RGBData, inputVideoFile, 30, 0, 0); % to lah daš v 1
    
    %     Amplituda(x,y) = MaxAmplituda
    if P_HRW
        moc_r(x,y) = (P_HRW(1)*1e6)/sum(mean(RGBData))^2;
        moc_g(x,y) = (P_HRW(2)*1e6)/sum(mean(RGBData))^2;
        moc_b(x,y) = (P_HRW(3)*1e6)/sum(mean(RGBData))^2;
    else
        moc_r(x,y) =0;
        moc_g(x,y) =0;
        moc_b(x,y) =0;
    end
%     disp(['HR: ' num2str(HR) ' bpm; P_HR: ' num2str(P_HR(2)*1e6/sum(mean(RGBData))^2)])
    
    end
end

%% show
figure;
subplot (1, 3, 1)
imagesc(moc_r.'); axis equal; axis square; axis image; title 'red'
colorbar;
subplot (1, 3, 2)
imagesc(moc_g.'); axis equal; axis square; axis image; title 'green'
colorbar;
subplot (1, 3, 3)
imagesc(moc_b.'); axis equal; axis square; axis image; title 'blue'
colorbar;