function [k, HR, A_HRSingle, P_HRSingle, P_HRBand, k_noise, deltaK_noise, HR_SNR] = fnGetHeartRateParamsFaceMap(A, f, fHR)

%% load global variables
load('GlobalVariables.mat')
kf1 = find(f>fHR-2); kf1 = kf1(1);
kf2 = find(f>fHR+2); kf2 = kf2(1);
k = find(A(kf1:kf2,GV.colorChannel)==max(A(kf1:kf2,GV.colorChannel)));
k = k + kf1 - 1;
HR = f(k); A_HRSingle = A(k,:); P_HRSingle = A(k,:).^2; P_HRBand = sum((A(k-GV.HRBand_deltaK:k+GV.HRBand_deltaK,:)).^2);

k_noise = round(k*3/2);
deltaK_noise = round(k/6); 
P_noise = mean(A(k_noise-deltaK_noise:k_noise+deltaK_noise,:).^2);
HR_SNR = P_HRSingle./P_noise;