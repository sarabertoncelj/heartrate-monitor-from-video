function F = fnGetFeaturesV3(msrmnt, bitPlotData)
    load(strcat('FaceMapData/', msrmnt, '.mat'));
    load(strcat('HeartRateData/', msrmnt, '.mat'));
    RGBFaceMapDATA = RGBFaceMapDATA(2:end,:,:,:);
    if isfield(DATA,'fs')
        fs = DATA.fs;
    else
        fs = 30; 
    end
    L = length(RGBFaceMapDATA);
    delta_k = 2; 
    delta_k = 0; 
        
    n = 5; fHR = fs/L*DATA.k; delta_f = fs/L*delta_k;
    f1 = fHR-delta_f; f2 = fHR+delta_f; 
    
    %% combine polygons for six face regions
    RGBFaceMapDATA4Analisys = RGBFaceMapDATA;
    [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RF);
    [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CF);
    [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LF);
    [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RC);
    [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CN);
    [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LC);
    
    RGBData_RF_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_RF_Norm);
    RGBData_CF_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_CF_Norm);
    RGBData_LF_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_LF_Norm);
    RGBData_RC_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_RC_Norm);
    RGBData_CN_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_CN_Norm);
    RGBData_LC_Norm = fnFilterButterHighPass(0.7, n, fs, RGBData_LC_Norm);
    
    RGBData_RF_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_RF_Norm, f1, f2, n, fs, L);
    RGBData_CF_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_CF_Norm, f1, f2, n, fs, L);
    RGBData_LF_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_LF_Norm, f1, f2, n, fs, L);
    RGBData_RC_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_RC_Norm, f1, f2, n, fs, L);
    RGBData_CN_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_CN_Norm, f1, f2, n, fs, L);
    RGBData_LC_Norm_HR1HarmonicButter = fnFilterHRCompWithPadding(RGBData_LC_Norm, f1, f2, n, fs, L);
    
    RGBData_RF_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_RF_Norm, f1*2, f2*2, n, fs, L);
    RGBData_CF_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_CF_Norm, f1*2, f2*2, n, fs, L);
    RGBData_LF_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_LF_Norm, f1*2, f2*2, n, fs, L);
    RGBData_RC_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_RC_Norm, f1*2, f2*2, n, fs, L);
    RGBData_CN_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_CN_Norm, f1*2, f2*2, n, fs, L);
    RGBData_LC_Norm_HR2HarmonicButter = fnFilterHRCompWithPadding(RGBData_LC_Norm, f1*2, f2*2, n, fs, L);
    
    RGBData_RF_Pulse = fnFilterHRComp(RGBData_RF_Norm, DATA.k, delta_k, 2);
    RGBData_CF_Pulse = fnFilterHRComp(RGBData_CF_Norm, DATA.k, delta_k, 2);
    RGBData_LF_Pulse = fnFilterHRComp(RGBData_LF_Norm, DATA.k, delta_k, 2);
    RGBData_RC_Pulse = fnFilterHRComp(RGBData_RC_Norm, DATA.k, delta_k, 2);
    RGBData_CN_Pulse = fnFilterHRComp(RGBData_CN_Norm, DATA.k, delta_k, 2);
    RGBData_LC_Pulse = fnFilterHRComp(RGBData_LC_Norm, DATA.k, delta_k, 2);
     
    if bitPlotData
    %% plot original and filtered one-region data and spectrum
        fnPlotAllOriginalAndFilteredDataAndSpectrum(DATA.k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Norm_HR1HarmonicButter, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Norm_HR1HarmonicButter, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Norm_HR1HarmonicButter, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Norm_HR1HarmonicButter, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Norm_HR1HarmonicButter, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Norm_HR1HarmonicButter);
        fnPlotAllPulseAndSpectrum(RGBData_RF_Pulse,RGBData_CF_Pulse,RGBData_LF_Pulse,RGBData_RC_Pulse,RGBData_CN_Pulse,RGBData_LC_Pulse);
    end
    delta_k = 2;    
    MNS = fnGetMeans([RGBData_RF, RGBData_CF, RGBData_LF, RGBData_RC, RGBData_CN, RGBData_LC]);
    [HR1Harmonic_Power, HR1Harmonic_BWPower] = fnGetHRPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], DATA.k, delta_k, L);
    [HR1HarmonicWindowed_Power, HR1HarmonicWindowed_BWPower] = fnGetHRWindowedPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], DATA.k, delta_k);
    [HR2Harmonic_Power, HR2Harmonic_BWPower] = fnGetHRPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], 2*DATA.k, delta_k, L);
    [HR2HarmonicWindowed_Power, HR2HarmonicWindowed_BWPower] = fnGetHRWindowedPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], 2*DATA.k, delta_k);
    PulsePower = fnGetPower([RGBData_RF_Pulse RGBData_CF_Pulse RGBData_LF_Pulse RGBData_RC_Pulse RGBData_CN_Pulse RGBData_LC_Pulse]);
    
    F = [MNS HR1Harmonic_Power HR1HarmonicWindowed_Power];
    F = [F HR2Harmonic_Power HR2HarmonicWindowed_Power];
    F = [F PulsePower];

    %save('FaceMapData/Features3.mat', 'F_AZ_1', 'F_AZ_2', 'F_AZ_3', 'F_MK_1', 'F_NB_1', 'F_KB_1', 'AZ_1_BP', 'AZ_2_BP', 'AZ_3_BP', 'MK_1_BP', 'NB_1_BP', 'KB_1_BP', 'AZ_1_VideoFaceSF', 'AZ_2_VideoFaceSF', 'AZ_3_VideoFaceSF', 'MK_1_VideoFaceSF', 'NB_1_VideoFaceSF', 'KB_1_VideoFaceSF');
end

function fnPlotAllOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Filt, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Filt, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Filt, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Filt, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Filt, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Filt) 
    fig_RF = figure; set(fig_RF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Filt);
    fig_CF = figure; set(fig_CF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Filt);
    fig_LF = figure; set(fig_LF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Filt);
    %fig_RC = figure; set(fig_RC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Filt);
    %fig_CN = figure; set(fig_CN, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Filt);
    %fig_LC = figure; set(fig_LC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Filt);
end

function fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, Data, Data_Norm, Data_Filtered)
    subplot(231), hold on, fnPlotRGB(Data), title('Original');
    subplot(232), hold on, fnPlotRGB(Data_Norm), title('Original Without Mean');
    subplot(233), hold on, fnPlotRGBSpectrum(Data_Norm, k, delta_k, L), title('Spectrum');
    subplot(235), hold on, fnPlotRGB(Data_Filtered), title('Filtered');
    subplot(236), hold on, fnPlotRGBSpectrum(Data_Filtered, k, delta_k, L), title('Spectrum');
end

function fnPlotAllPulseAndSpectrum(RGBData_RF_Pulse,RGBData_CF_Pulse,RGBData_LF_Pulse,RGBData_RC_Pulse,RGBData_CN_Pulse,RGBData_LC_Pulse)
    figure;
    subplot(231)
        fnPlotRGB(RGBData_RF_Pulse)
    subplot(232)
        fnPlotRGB(RGBData_CF_Pulse) 
    subplot(233)
        fnPlotRGB(RGBData_LF_Pulse) 
    subplot(234)
        fnPlotRGB(RGBData_RC_Pulse)
    subplot(235)
        fnPlotRGB(RGBData_CN_Pulse) 
    subplot(236)
        fnPlotRGB(RGBData_LC_Pulse)  
    
    figure;
    subplot(231), [X,AX,phiX]=fnFFT(RGBData_RF_Pulse);
        fnPlotRGB(AX(1:round(end/2),:))
    subplot(232), [X,AX,phiX]=fnFFT(RGBData_CF_Pulse);
        fnPlotRGB(AX(1:round(end/2),:)) 
    subplot(233), [X,AX,phiX]=fnFFT(RGBData_LF_Pulse);
        fnPlotRGB(AX(1:round(end/2),:)) 
    subplot(234), [X,AX,phiX]=fnFFT(RGBData_RC_Pulse);
        fnPlotRGB(AX(1:round(end/2),:))
    subplot(235), [X,AX,phiX]=fnFFT(RGBData_CN_Pulse);
        fnPlotRGB(AX(1:round(end/2),:)) 
    subplot(236), [X,AX,phiX]=fnFFT(RGBData_LC_Pulse);
        fnPlotRGB(AX(1:round(end/2),:))  
end

  
%% plot filtered face region data
% N1 = 1; N2 = length(RGBData_RF_Padded_Filtered);
% figure; sgtitle('AZ (1)')
% subplot(231),hold on, fnPlotRGB(RGBData_RF_Padded_Filtered(N1:N2,:)), title('Right forehead');
% subplot(232),hold on, fnPlotRGB(RGBData_CF_Padded_Filtered(N1:N2,:)), title('Centre forehead');
% subplot(233),hold on, fnPlotRGB(RGBData_LF_Padded_Filtered(N1:N2,:)), title('Left forehead');
% subplot(234),hold on, fnPlotRGB(RGBData_RC_Padded_Filtered(N1:N2,:)), title('Right cheek');
% subplot(235),hold on, fnPlotRGB(RGBData_CN_Padded_Filtered(N1:N2,:)), title('Centre nose');
% subplot(236),hold on, fnPlotRGB(RGBData_LC_Padded_Filtered(N1:N2,:)), title('Left cheek');

