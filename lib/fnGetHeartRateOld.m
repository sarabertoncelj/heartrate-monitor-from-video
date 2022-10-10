function [k, heartRate, kWithPadding, heartRateWithPadding] = fnGetHeartRate(RGBData, inputVideoFileName)

%% calculate heart rate without padding
fs = 30; colorChannel = 2; 
RGBData_norm = fnNormalizeData(RGBData,0);
RGBData_norm_filt     = fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_norm);
[AX, f] = fnFFTRGB(RGBData_norm_filt, fs, 1, {'Filtered data', 'Measurement: ', inputVideoFileName}, ['r';'g';'b']);
k = find(AX(:,colorChannel)==max(AX(:,colorChannel)));
heartRate = f(k)*60;

%% calculate heart rate with padding
LP = 1024;
[AXWithPadding, fWithPadding] = fnFFTRGBWithPadding(RGBData_norm_filt, fs, LP, {'Filtered data', 'Measurement: ', inputVideoFileName}, ['r';'g';'b']);
kWithPadding = find(AXWithPadding(:,colorChannel)==max(AXWithPadding(:,colorChannel)));
heartRateWithPadding = fWithPadding(kWithPadding)*60;

%[k, heartRate] = fnHeartRateICA(RGBData, 30, 2, {'Filtered data', 'Measurement: ', inputVideoFileName});


