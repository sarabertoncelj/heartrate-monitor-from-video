function RGBHRPulse = fnGetHRPulse(msrmnt, bitPlot)

load(strcat('HeartRateData/', msrmnt, 'RGB.mat'));
load(strcat('HeartRateData/', msrmnt, '.mat'));
%DATA.luminosity

if isfield(DATA,'fs')
    fs = DATA.fs;
else
    fs = 30; 
end

delta_k_orig = 2; 
k_orig = DATA.k;
n = 5; fHR = fs/299*(k_orig-1); delta_f = fs/299*delta_k_orig;
f1 = fHR-delta_f; f2 = fHR+delta_f;

RGBData_norm = fnNormalizeData(RGBData(2:end,:),0);
RGBData_norm_filt = fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_norm);

% [AX, f] = fnFFTRGB(RGBData_norm_filt, fs, 0, 'Low-pass data', ['r';'g';'b']);
% [AX, f] = fnFFTRGB(RGBData_norm_filt, fs, 1, 'Low-pass data with windowing', ['r';'g';'b']);
% 
% RGBData_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_norm, f1, f2, n, fs, 0);
% [AX, f] = fnFFTRGB(RGBData_Padded_Filtered, fs, 1, 'Filtered data sub mean', ['r';'g';'b']);
% RGBData_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_norm, f1, f2, n, fs, 1);
% [AX, f] = fnFFTRGB(RGBData_Padded_Filtered, fs, 1, 'Filtered with padding data sub mean', ['r';'g';'b']);

RGBHRPulse = fnFilterHRComp(RGBData_norm_filt, k_orig, delta_k_orig, 2);
%RGBHRPulse = -fnFilterHRComp(RGBData_norm, k_orig, delta_k_orig, 2);

RGBHRPulse = RGBHRPulse./(max(DATA.VideoFaceSF)^2).*k_orig;
mean(RGBData)
r1=mean(RGBData(:,2))/mean(RGBData(:,3));
r2 = sqrt(sum(RGBHRPulse(:,2).^2)/sum(RGBHRPulse(:,3).^2));
RGBHRPulse = RGBHRPulse*r2/r1;
RGBHRPulse = RGBHRPulse/(sum(mean(RGBData).^2));
%RGBHRPulse = RGBHRPulse/mean(RGBData(:,2));
if bitPlot
    [AX, f] = fnFFTRGB(RGBHRPulse, fs, 0, 'HRPulse', ['r';'g';'b']);
end
%[AX, f] = fnFFTRGB(RGBHRPulse, fs, 1, 'HRPulse with windowing', ['r';'g';'b']);
