function [k1stHarm, HR1stHarm, A_HR1stHarmSingle, P_HR1stHarmSingle, P_HR1stHarmBand, HR1stHarm_SNR] = fnGetHeartRate1stHarmParams(A, f, k_noise, deltaK_noise)

%% load global variables
load('GlobalVariables.mat')
k = find(A(k_noise + deltaK_noise:end,GV.colorChannel)==max(A(k_noise + deltaK_noise:end,GV.colorChannel)));
k1stHarm = k(1) + k_noise + deltaK_noise - 1;
HR1stHarm = f(k1stHarm); A_HR1stHarmSingle = A(k1stHarm,:); P_HR1stHarmSingle = A(k1stHarm,:).^2; P_HR1stHarmBand = sum((A(k1stHarm-GV.HRBand_deltaK:k1stHarm+GV.HRBand_deltaK,:)).^2);

P_noise = mean(A(k_noise-deltaK_noise:k_noise+deltaK_noise,:).^2);
HR1stHarm_SNR = P_HR1stHarmSingle./P_noise;