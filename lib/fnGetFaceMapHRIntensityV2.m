function dataOut = fnGetFaceMapHRIntensityV2(RGBFaceMapDATA, fHR, fs)

load('GlobalVariables.mat')
nX = size(RGBFaceMapDATA,2); nY = size(RGBFaceMapDATA,3);
%Axk = zeros(nX,nY,3); Axk_rel = zeros(nX,nY,3); Axk_rgbsum = zeros(nX,nY);
dataOut = zeros(nX,nY,4);

for i=30:30
    for j=14:15
        RGBData = squeeze(RGBFaceMapDATA(:,i,j,:));
        [k, HR, ~, P_HR, ~] = fnGetHeartRateFaceMap(RGBData, fHR, fs, 1);
        dataOut(i,j,1) = k;
        dataOut(i,j,2) = HR;
        dataOut(i,j,3) = P_HR(2);
    end
end

% npolAvX = 2; npolAvY = 1;
% 
% MAX = max(max(max(dataOut(:,:,3)))); 
% MIN = min(min(min(dataOut(:,:,3))));
% 
% for i=1:nX
%     for j=1:nY
%         dataOut(i,j,4) = 1-(MAX-dataOut(i,j,3))/(MAX-MIN);    
%     end
% end