function F = fnGetFeatures(msrmnt, bitPlotData)

    %% load face ROIs RGBData
    load(strcat('FaceMapData/', msrmnt, '.mat'));
    %% load measurement data
    load(strcat('HeartRateData/', msrmnt, '.mat'));
    RGBFaceMapDATA = RGBFaceMapDATA(2:end,:,:,:);
    %% load global variables
    load('GlobalVariables.mat')
    if isfield(DATA,'fs')
        fs = DATA.fs;
    else
        fs = GV.fsDeafult; 
    end

    %% combine polygons for six face regions
    RGBFaceMapDATA4Analisys = RGBFaceMapDATA;
    [RGBData.RF.Origin, RGBData.RF.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RF);
    [RGBData.CF.Origin, RGBData.CF.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CF);
    [RGBData.LF.Origin, RGBData.LF.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LF);
    [RGBData.RC.Origin, RGBData.RC.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RC);
    [RGBData.CN.Origin, RGBData.CN.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CN);
    [RGBData.LC.Origin, RGBData.LC.Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LC);
    
    %% dtft analysis of normalized data
    [RGBData.RF.NormA, ~, f] = fnDTFTRGB(RGBData.RF.Norm,fs,0);
    [RGBData.CF.NormA, ~, ~] = fnDTFTRGB(RGBData.CF.Norm,fs,0);
    [RGBData.LF.NormA, ~, ~] = fnDTFTRGB(RGBData.LF.Norm,fs,0);
    [RGBData.RC.NormA, ~, ~] = fnDTFTRGB(RGBData.RC.Norm,fs,0);
    [RGBData.CN.NormA, ~, ~] = fnDTFTRGB(RGBData.CN.Norm,fs,0);
    [RGBData.LC.NormA, ~, ~] = fnDTFTRGB(RGBData.LC.Norm,fs,0);
        
    %% fir filter data   
    RGBData.RF.NormFilt = fnFir(RGBData.RF.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    RGBData.CF.NormFilt = fnFir(RGBData.CF.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    RGBData.LF.NormFilt = fnFir(RGBData.LF.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    RGBData.RC.NormFilt = fnFir(RGBData.RC.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    RGBData.CN.NormFilt = fnFir(RGBData.CN.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    RGBData.LC.NormFilt = fnFir(RGBData.LC.Norm, [GV.fFirMin GV.fFirMax]/fs*2, GV.Nfir);
    
    %% rect window data (zero-crossing or max)
    %RGBData.RF.NormFiltWin = fnWindowZeroCrossing(RGBData.RF.NormFilt(GV.FilteredDataOffset:end,:));
    RGBData.CF.NormFiltWin = fnWindowZeroCrossing(RGBData.CF.NormFilt(GV.FilteredDataOffset:end,:));
    RGBData.LF.NormFiltWin = fnWindowZeroCrossing(RGBData.LF.NormFilt(GV.FilteredDataOffset:end,:));
    RGBData.RC.NormFiltWin = fnWindowZeroCrossing(RGBData.RC.NormFilt(GV.FilteredDataOffset:end,:));
%    RGBData.CN.NormFiltWin = fnWindowZeroCrossing(RGBData.CN.NormFilt(GV.FilteredDataOffset:end,:));
    RGBData.LC.NormFiltWin = fnWindowZeroCrossing(RGBData.LC.NormFilt(GV.FilteredDataOffset:end,:));
    
    %% dtft analysis filtered data
    [RGBData.RF.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.RF.NormFilt,fs,0);
    [RGBData.CF.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.CF.NormFiltWin,fs,0);
    [RGBData.LF.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.LF.NormFiltWin,fs,0);
    [RGBData.RC.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.RC.NormFiltWin,fs,0);
%    [RGBData.CN.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.CN.NormFiltWin,fs,0);
    [RGBData.LC.NormFiltWinA, ~, ~] = fnDTFTRGB(RGBData.LC.NormFiltWin,fs,0);
    
    %% heart rate original freq, ampl, and power
    [HROrig.RF.k, HROrig.RF.freq, HROrig.RF.A_HRSingle, HROrig.RF.P_HRSingle, HROrig.RF.P_HRBand, HROrig.RF.kNoise, HROrig.RF.kDeltaNoise, HROrig.RF.SNR] = fnGetHeartRateParams(RGBData.RF.NormFiltWinA, f);
    [HROrig.CF.k, HROrig.CF.freq, HROrig.CF.A_HRSingle, HROrig.CF.P_HRSingle, HROrig.CF.P_HRBand, HROrig.CF.kNoise, HROrig.CF.kDeltaNoise, HROrig.CF.SNR] = fnGetHeartRateParams(RGBData.CF.NormFiltWinA, f);
    [HROrig.LF.k, HROrig.LF.freq, HROrig.LF.A_HRSingle, HROrig.LF.P_HRSingle, HROrig.LF.P_HRBand, HROrig.LF.kNoise, HROrig.LF.kDeltaNoise, HROrig.LF.SNR] = fnGetHeartRateParams(RGBData.LF.NormFiltWinA, f);
    [HROrig.RC.k, HROrig.RC.freq, HROrig.RC.A_HRSingle, HROrig.RC.P_HRSingle, HROrig.RC.P_HRBand, HROrig.RC.kNoise, HROrig.RC.kDeltaNoise, HROrig.RC.SNR] = fnGetHeartRateParams(RGBData.RC.NormFiltWinA, f);
%    [HROrig.CN.k, HROrig.CN.freq, HROrig.CN.A_HRSingle, HROrig.CN.P_HRSingle, HROrig.CN.P_HRBand, HROrig.CN.kNoise, HROrig.CN.kDeltaNoise, HROrig.CN.SNR] = fnGetHeartRateParams(RGBData.CN.NormFiltWinA, f);
    [HROrig.LC.k, HROrig.LC.freq, HROrig.LC.A_HRSingle, HROrig.LC.P_HRSingle, HROrig.LC.P_HRBand, HROrig.LC.kNoise, HROrig.LC.kDeltaNoise, HROrig.LC.SNR] = fnGetHeartRateParams(RGBData.LC.NormFiltWinA, f);
         
    %% heart rate 1st harmonic freq, ampl, and power
    [HR1stHarm.RF.k, HR1stHarm.RF.freq, HR1stHarm.RF.A_HRSingle, HR1stHarm.RF.P_HRSingle, HR1stHarm.RF.P_HRBand, HR1stHarm.RF.SNR] = fnGetHeartRate1stHarmParams(RGBData.RF.NormFiltWinA, f, HROrig.RF.kNoise, HROrig.RF.kDeltaNoise);
    [HR1stHarm.CF.k, HR1stHarm.CF.freq, HR1stHarm.CF.A_HRSingle, HR1stHarm.CF.P_HRSingle, HR1stHarm.CF.P_HRBand, HR1stHarm.CF.SNR] = fnGetHeartRate1stHarmParams(RGBData.CF.NormFiltWinA, f, HROrig.CF.kNoise, HROrig.CF.kDeltaNoise);
    [HR1stHarm.LF.k, HR1stHarm.LF.freq, HR1stHarm.LF.A_HRSingle, HR1stHarm.LF.P_HRSingle, HR1stHarm.LF.P_HRBand, HR1stHarm.LF.SNR] = fnGetHeartRate1stHarmParams(RGBData.LF.NormFiltWinA, f, HROrig.LF.kNoise, HROrig.LF.kDeltaNoise);
    [HR1stHarm.RC.k, HR1stHarm.RC.freq, HR1stHarm.RC.A_HRSingle, HR1stHarm.RC.P_HRSingle, HR1stHarm.RC.P_HRBand, HR1stHarm.RC.SNR] = fnGetHeartRate1stHarmParams(RGBData.RC.NormFiltWinA, f, HROrig.RC.kNoise, HROrig.RC.kDeltaNoise);
%    [HR1stHarm.CN.k, HR1stHarm.CN.freq, HR1stHarm.CN.A_HRSingle, HR1stHarm.CN.P_HRSingle, HR1stHarm.CN.P_HRBand, HR1stHarm.CN.SNR] = fnGetHeartRate1stHarmParams(RGBData.CN.NormFiltWinA, f, HROrig.CN.kNoise, HROrig.CN.kDeltaNoise);
    [HR1stHarm.LC.k, HR1stHarm.LC.freq, HR1stHarm.LC.A_HRSingle, HR1stHarm.LC.P_HRSingle, HR1stHarm.LC.P_HRBand, HR1stHarm.LC.SNR] = fnGetHeartRate1stHarmParams(RGBData.LC.NormFiltWinA, f, HROrig.LC.kNoise, HROrig.LC.kDeltaNoise);
  
    %% plot data
    if bitPlotData
    %% plot original and filtered one-region data and spectrum
        fnPlotAllOriginalAndFilteredDataAndSpectrum(RGBData, HROrig, HR1stHarm, f, GV.HRBand_deltaK);
%         fnPlotAllPulseAndSpectrum(RGBData_RF_Pulse,RGBData_CF_Pulse,RGBData_LF_Pulse,RGBData_RC_Pulse,RGBData_CN_Pulse,RGBData_LC_Pulse);
    end
 
    %% mean values
    MNS = fnGetMeans([RGBData.CF.Origin]);

    %% combine calculated features
    F = [MNS HROrig.CF.freq HR1stHarm.CF.freq];
    F = [F HROrig.CF.A_HRSingle HROrig.CF.P_HRSingle HROrig.CF.P_HRBand HROrig.CF.SNR];
    F = [F HR1stHarm.CF.A_HRSingle HR1stHarm.CF.P_HRSingle HR1stHarm.CF.P_HRBand HR1stHarm.CF.SNR];

end

function fnPlotAllOriginalAndFilteredDataAndSpectrum(RGBData, HROrig, HR1stHarm, f, deltaK) 
    %fig_RF = figure; set(fig_RF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.RF, HROrig.RF.k, f, deltaK, HROrig.RF.kNoise, HROrig.RF.kDeltaNoise, HR1stHarm.RF.k);
    fig_CF = figure; set(fig_CF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.CF, HROrig.CF.k, f, deltaK, HROrig.CF.kNoise, HROrig.CF.kDeltaNoise, HR1stHarm.CF.k);
    %fig_LF = figure; set(fig_LF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.LF, HROrig.LF.k, f, deltaK, HROrig.LF.kNoise, HROrig.LF.kDeltaNoise, HR1stHarm.LF.k);
    %fig_RC = figure; set(fig_RC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.RC, HROrig.RC.k, f, deltaK, HROrig.RC.kNoise, HROrig.RC.kDeltaNoise, HR1stHarm.RC.k);
    %fig_CN = figure; set(fig_CN, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.CN, HROrig.CN.k, f, deltaK, HROrig.CN.kNoise, HROrig.CN.kDeltaNoise, HR1stHarm.CN.k);
    %fig_LC = figure; set(fig_LC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(RGBData.LC, HROrig.LC.k, f, deltaK, HROrig.LC.kNoise, HROrig.LC.kDeltaNoise, HR1stHarm.LC.k);
end

function fnPlotOriginalAndFilteredDataAndSpectrum(RGBData, k, f, delta_k, k_noise, delta_k_noise, k1stHarm)
    subplot(231), hold on, fnPlotRGB(RGBData.Origin), title('Original');
    subplot(232), hold on, fnPlotRGB(RGBData.Norm), title('Original Without Mean');
    subplot(233), hold on, fnPlotDTFTRGBASpectrum(RGBData.NormA, f, k, delta_k, k_noise, delta_k_noise, k1stHarm), title('Spectrum');
    subplot(235), hold on, fnPlotRGB(RGBData.NormFiltWin), title('Filtered');
    subplot(236), hold on, fnPlotDTFTRGBASpectrum(RGBData.NormFiltWinA, f, k, delta_k, k_noise, delta_k_noise, k1stHarm), title('Spectrum');
end

