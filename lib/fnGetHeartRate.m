function [k, HR, HRW, P_HR, P_HRW] = fnGetHeartRate(RGBData, inputVideoFileName, fs, bitPlot, bitPlotFilter)

%% load global variables
load('GlobalVariables.mat')
%% calculate heart rate without padding
RGBData_norm = fnNormalizeData(RGBData,0);
RGBData_norm_filt = fnFir(RGBData_norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir, bitPlotFilter);
RGBData_norm_filt = fnWindowZeroCrossing(RGBData_norm_filt(GV.FilteredDataOffset:end,:));
if bitPlot
    [AX, ~, f] = fnDTFTRGB(RGBData_norm_filt, fs, 0, {'Filtrirani signali', 'Meritev:: ', inputVideoFileName}, ['r';'g';'b']);
else
    [AX, ~, f] = fnDTFTRGB(RGBData_norm_filt, fs, 0);
end

[k, HR, ~, P_HR, ~] = fnGetHeartRateParams(AX, f);
[~, HRW, ~, P_HRW, ~] = fnGetHeartRateParams(AX, f);




