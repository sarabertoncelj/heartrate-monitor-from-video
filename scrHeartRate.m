%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% heart rate measurement  %%%%%%%%%%
%%%%              main script             %%%%
%%%%       includes video reading,        %%%%
%%%%    normalization, filtering and      %%%%  
%%%%       automatic face detection       %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('/MATLAB Drive/HeartRate/HeartRate/lib')
msrmt = '63-61';
inputVideoFile = strcat(msrmt, '.mp4'); outputMatFile = strcat(msrmt, '.mat');

%% test
RGBData = fnGetHRRGB(inputVideoFile, 'InputVideos/');

%% pridobivanje rgb signalov
[RGBFaceMapDATA, bbox] = fnGetBPFaceMap(inputVideoFile, 'InputVideos/');
save(strcat('HeartRateData/', msrmt, '2.mat'), 'RGBFaceMapDATA');
RGBData = squeeze(RGBFaceMapDATA(:,8,4,:));

%% analiza
[k, HR, HRW, P_HR, P_HRW] = fnGetHeartRate(RGBData, inputVideoFile, 30, 1, 1); 
disp(['HR: ' num2str(HR) ' bpm; P_HR: ' num2str(P_HR(2)*1e6/sum(mean(RGBData))^2)])

figure; hold on
n = 0:(length(RGBData)-1);
t = n/30; 
plot(t,RGBData(:,1),'r','LineWidth',1.5)
plot(t,RGBData(:,2),'g','LineWidth',1.5)
plot(t,RGBData(:,3),'b','LineWidth',1.5)
xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', 20), ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 20)
title('Barvni signali', 'FontSize', 20)



