function [k, HR, A_HRSingle, P_HRSingle, P_HRBand, k_noise, deltaK_noise, HR_SNR] = fnGetHeartRateParams(A, f)

%% load global variables
load('GlobalVariables.mat')
k = 19 + find(A(20:end,GV.colorChannel)==max(A(20:end,GV.colorChannel)));
HR = f(k); A_HRSingle = A(k,:); P_HRSingle = A(k,:).^2; P_HRBand = sum((A(k-GV.HRBand_deltaK:k+GV.HRBand_deltaK,:)).^2);

k_noise = round(k*3/2);
deltaK_noise = round(k/6); 
P_noise = mean(A(k_noise-deltaK_noise:k_noise+deltaK_noise,:).^2);
HR_SNR = P_HRSingle./P_noise;