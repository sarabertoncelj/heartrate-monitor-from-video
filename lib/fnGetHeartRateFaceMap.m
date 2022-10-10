function [k, HR, HRW, P_HR, P_HRW] = fnGetHeartRateFaceMap(RGBData, fHR, fs, bitPlot)

%% load global variables
load('GlobalVariables.mat')
%% calculate heart rate without padding
RGBData_norm = fnNormalizeData(RGBData,0);
RGBData_norm_filt = fnFir(RGBData_norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
RGBData_norm_filt = fnWindowZeroCrossing(RGBData_norm_filt(GV.FilteredDataOffset:end,:));
%RGBData_norm_filt = fnWindowMax(RGBData_norm_filt(GV.FilteredDataOffset:end,:), fs);
if bitPlot
    [AX, ~, f] = fnDTFTRGB(RGBData_norm_filt, fs, 1, {'Face map'}, ['r';'g';'b']);
else
    [AX, ~, f] = fnDTFTRGB(RGBData_norm_filt, fs, 1);
end

[k, HR, ~, P_HR, ~] = fnGetHeartRateParamsFaceMap(AX, f, fHR);
[~, HRW, ~, P_HRW, ~] = fnGetHeartRateParamsFaceMap(AX, f, fHR);




