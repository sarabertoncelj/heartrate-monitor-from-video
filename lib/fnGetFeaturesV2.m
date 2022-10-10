function F = fnGetFeaturesV2(msrmnt, bitPlotData)
    load(strcat('FaceMapData/', msrmnt, '.mat'));
    load(strcat('HeartRateData/', msrmnt, '.mat'));
    if isfield(DATA,'fs')
        fs = DATA.fs;
    else
        fs = 30; 
    end
    L = 1024; Ltot = length(RGBFaceMapDATA);
    delta_k = 6; delta_k_orig = 2; 
    
    k = DATA.kWithPadding; k_orig = DATA.k; 
    n = 5; fHR = fs/299*(k_orig-1); delta_f = fs/299*delta_k_orig;
    f1 = fHR-delta_f; f2 = fHR+delta_f; 
    %L4windowing = 90; n1 = 70; n2 = n1 + L4windowing;

    %RGBFaceMapDATA4Analisys = RGBFaceMapDATA(n1:n2,:,:,:);
    RGBFaceMapDATA4Analisys = RGBFaceMapDATA;
    [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RF);
    [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CF);
    [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LF);
    [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.RC);
    [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.CN);
    [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, DATA.polygons4BP.LC);
    
    RGBData_RF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_RF_Norm, f1, f2, n, fs, Ltot);
    RGBData_CF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_CF_Norm, f1, f2, n, fs, Ltot);
    RGBData_LF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_LF_Norm, f1, f2, n, fs, Ltot);
    RGBData_RC_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_RC_Norm, f1, f2, n, fs, Ltot);
    RGBData_CN_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_CN_Norm, f1, f2, n, fs, Ltot);
    RGBData_LC_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_LC_Norm, f1, f2, n, fs, Ltot);
    
    RGBData_RF_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_RF_Norm), k_orig, delta_k_orig, 2);
    RGBData_CF_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_CF_Norm), k_orig, delta_k_orig, 2);
    RGBData_LF_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_LF_Norm), k_orig, delta_k_orig, 2);
    RGBData_RC_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_RC_Norm), k_orig, delta_k_orig, 2);
    RGBData_CN_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_CN_Norm), k_orig, delta_k_orig, 2);
    RGBData_LC_Pulse = fnFilterHRComp(fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,RGBData_LC_Norm), k_orig, delta_k_orig, 2);
    
    if bitPlotData
    %% plot original and filtered one-region data and spectrum
        %fnPlotAllOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Padded_Filtered, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Padded_Filtered, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Padded_Filtered, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Padded_Filtered, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Padded_Filtered, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Padded_Filtered);
        fnPlotAllPulseAndSpectrum(RGBData_RF_Pulse,RGBData_CF_Pulse,RGBData_LF_Pulse,RGBData_RC_Pulse,RGBData_CN_Pulse,RGBData_LC_Pulse,fs);
    end
        
    MNS = fnGetMeans([RGBData_RF, RGBData_CF, RGBData_LF, RGBData_RC, RGBData_CN, RGBData_LC]);
    [HR_Power, HR_BWPower] = fnGetHRPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], k, delta_k, L);
    [HRWindowed_Power, HRWindowed_BWPower] = fnGetHRWindowedPower([RGBData_RF_Norm, RGBData_CF_Norm, RGBData_LF_Norm, RGBData_RC_Norm, RGBData_CN_Norm, RGBData_LC_Norm], k_orig, delta_k_orig);
    R = fnGetRGBCorrelations([RGBData_RF_Padded_Filtered RGBData_CF_Padded_Filtered, RGBData_LF_Padded_Filtered, RGBData_RC_Padded_Filtered, RGBData_CN_Padded_Filtered, RGBData_LC_Padded_Filtered]);
    [RFmax, RFmax_n] = fnGetRGBCorrelationFunctionMax([RGBData_RF_Padded_Filtered RGBData_CF_Padded_Filtered, RGBData_LF_Padded_Filtered, RGBData_RC_Padded_Filtered, RGBData_CN_Padded_Filtered, RGBData_LC_Padded_Filtered]);
    F = [MNS HR_Power HR_BWPower HRWindowed_Power HRWindowed_BWPower R RFmax RFmax_n];

    %save('FaceMapData/Features3.mat', 'F_AZ_1', 'F_AZ_2', 'F_AZ_3', 'F_MK_1', 'F_NB_1', 'F_KB_1', 'AZ_1_BP', 'AZ_2_BP', 'AZ_3_BP', 'MK_1_BP', 'NB_1_BP', 'KB_1_BP', 'AZ_1_VideoFaceSF', 'AZ_2_VideoFaceSF', 'AZ_3_VideoFaceSF', 'MK_1_VideoFaceSF', 'NB_1_VideoFaceSF', 'KB_1_VideoFaceSF');
end

function fnPlotAllOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Padded_Filtered, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Padded_Filtered, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Padded_Filtered, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Padded_Filtered, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Padded_Filtered, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Padded_Filtered) 
    fig_RF = figure; set(fig_RF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Padded_Filtered);
    fig_CF = figure; set(fig_CF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Padded_Filtered);
    fig_LF = figure; set(fig_LF, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Padded_Filtered);
    fig_RC = figure; set(fig_RC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Padded_Filtered);
    fig_CN = figure; set(fig_CN, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Padded_Filtered);
    fig_LC = figure; set(fig_LC, 'WindowStyle', 'Docked'); fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Padded_Filtered);
end

function fnPlotOriginalAndFilteredDataAndSpectrum(k, delta_k, L, Data, Data_Norm, Data_Filtered)
    subplot(231), hold on, fnPlotRGB(Data), title('Original');
    subplot(232), hold on, fnPlotRGB(Data_Norm), title('Original Without Mean');
    subplot(233), hold on, fnPlotRGBSpectrum(Data_Norm, k, delta_k, L), title('Spectrum');
    subplot(235), hold on, fnPlotRGB(Data_Filtered), title('Filtered');
    subplot(236), hold on, fnPlotRGBSpectrum(Data_Filtered, k, delta_k, L), title('Spectrum');
end

function fnPlotAllPulseAndSpectrum(RGBData_RF_Pulse,RGBData_CF_Pulse,RGBData_LF_Pulse,RGBData_RC_Pulse,RGBData_CN_Pulse,RGBData_LC_Pulse,fs);
    [AX_RF, f] = fnFFTRGB(RGBData_RF_Pulse, fs, 0);
    [AX_CF, f] = fnFFTRGB(RGBData_CF_Pulse, fs, 0);
    [AX_LF, f] = fnFFTRGB(RGBData_LF_Pulse, fs, 0);
    [AX_RC, f] = fnFFTRGB(RGBData_RC_Pulse, fs, 0);
    [AX_CN, f] = fnFFTRGB(RGBData_CN_Pulse, fs, 0);
    [AX_LC, f] = fnFFTRGB(RGBData_LC_Pulse, fs, 0);  
    figure;
    subplot(211), hold on
        plot(RGBData_RF_Pulse(:,2),'Color', [0 1 0])
        plot(RGBData_CF_Pulse(:,2),'Color', [0 0.85 0])
        plot(RGBData_LF_Pulse(:,2),'Color', [0 0.7 0])
        plot(RGBData_RC_Pulse(:,2),'Color', [0 0.65 0])
        plot(RGBData_CN_Pulse(:,2),'Color', [0 0.5 0])
        plot(RGBData_LC_Pulse(:,2),'Color', [0 0.35 0])
     subplot(212), hold on
        plot(f,AX_RF(:,1),'Color', [0 1 0])
        plot(f,AX_CF(:,2),'Color', [0 0.85 0])
        plot(f,AX_LF(:,2),'Color', [0 0.7 0])
        plot(f,AX_RC(:,2),'Color', [0 0.65 0])
        plot(f,AX_CN(:,2),'Color', [0 0.5 0])
        plot(f,AX_LC(:,2),'Color', [0 0.35 0])        
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

