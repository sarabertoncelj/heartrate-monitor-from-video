function F = fnGetFeatures(msrmnt, bitPlotData)
    fs = 30; 
    load(strcat('FaceMapData/', msrmnt, '_50.mat'));
    L = 1024; Ltot = length(RGBFaceMapDATA);
    delta_k = 6; delta_k_orig = 3; L4windowing = 90;

    if strcmp(msrmnt,'AZ_(1)') || strcmp(msrmnt,'AZ_(2)') || strcmp(msrmnt,'AZ_(3)') 
        RF.Nx = [2,2,2,3,3,3,4,4,4]; RF.Ny = [2,3,4,2,3,4,2,3,4];
        CF.Nx = [6,6,6,7,7,7]; CF.Ny = [2,3,4,2,3,4];
        LF.Nx = [9,9,9,10,10,10,11,11,11]; LF.Ny = [2,3,4,2,3,4,2,3,4];
        RC.Nx = [2,2,2,3,3,3]; RC.Ny = [11,12,13,11,12,13];
        CN.Nx = [6,6,7,7]; CN.Ny = [12,13,12,13];
        LC.Nx = [10,10,10,11,11,11]; LC.Ny = [11,12,13,11,12,13];        
%         [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [6,6,6,7,7,7], [2,3,4,2,3,4]);
%         [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [3,3,3,4,4,4], [2,3,4,2,3,4]);
%         [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [10,10,10,11,11,11], [2,3,4,2,3,4]);
%         [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [2,2,2,3,3,3], [11,12,13,11,12,13]);
%         [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA, [6,6,7,7], [12,13,12,13]);
%         [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [10,10,10,11,11,11], [11,12,13,11,12,13]);
        if strcmp(msrmnt,'AZ_(1)')
            n = 5; f1 = 1.319; f2 = 1.493; k = 48; k_orig = 9; n1 = 70; n2 = n1 + L4windowing;
        elseif strcmp(msrmnt,'AZ_(2)')
            n = 5; f1 = 2.608; f2 = 2.782; k = 92; k_orig = 28; n1 = 110; n2 = n1 + L4windowing;
        else
            n = 5; f1 = 1.759; f2 = 1.933; k = 63; k_orig = 15; n1 = 50; n2 = n1 + L4windowing;
        end
    elseif strcmp(msrmnt,'MK_(1)')
        RF.Nx = [3,3,3,4,4,4]; RF.Ny = [2,3,4,2,3,4];
        CF.Nx = [6,7,8,6,7,8]; CF.Ny = [4,4,4,5,5,5];
        LF.Nx = [10,10,10,11,11,11]; LF.Ny = [2,3,4,2,3,4];
        RC.Nx = [2,2,2,3,3,3]; RC.Ny = [11,12,13,11,12,13];
        CN.Nx = [7,7,8,8]; CN.Ny = [13,14,13,14];
        LC.Nx = [11,11,11,12,12,12]; LC.Ny = [12,13,14,12,13,14]; 
        n = 5; f1 = 0.9677; f2 = 1.1417; k = 36; k_orig = 5; n1 = 1; n2 = n1 + L4windowing;
        % n = 5; f1 = 2.405; f2 = 2.579; k = 48; MK_(3)
        %n = 5; f1 = 2.405; f2 = 3.196; % 
    elseif strcmp(msrmnt,'NB_(1)')        
        RF.Nx = [3,4]; RF.Ny = [4,4];
        CF.Nx = [6,6]; CF.Ny = [4,5];
        LF.Nx = [9,9]; LF.Ny = [3,4];
        RC.Nx = [2,2,2,3,3,3]; RC.Ny = [11,12,13,11,12,13];
        CN.Nx = [5,5,6,6]; CN.Ny = [12,13,12,13];
        LC.Nx = [10,10,10,11,11,11]; LC.Ny = [11,12,13,11,12,13];         
        n = 5; f1 = 1.26; f2 = 1.435; k = 46; k_orig = 9; n1 = 55; n2 = n1 + L4windowing;
    elseif strcmp(msrmnt,'KB_(1)') 
        RF.Nx = [1,1]; RF.Ny = [4,5];
        CF.Nx = [3,3,3,4,4,4,5,5,5]; CF.Ny = [3,4,5,3,4,5,3,4,5];
        LF.Nx = [7,7,8,8,9,9]; LF.Ny = [3,4,3,4,3,4];
        RC.Nx = [1]; RC.Ny = [11];
        CN.Nx = [3,3,4,4,5,5]; CN.Ny = [13,14,13,14,13,14];
        LC.Nx = [9,9,9,10,10,10,11,11,11]; LC.Ny = [11,12,13,11,12,13,11,12,13];  
        n = 5; f1 = 1.2607; f2 = 1.445; k = 46; k_orig = 11; n1 = 100; n2 = n1 + L4windowing;
    elseif strcmp(msrmnt,'KB_(2)') 
        [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [1,2], [5,5]); %RGBData_RF = fnMergeRGBData(RGBFaceMapDATA, Nx, Ny);
        [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [4,4,4,5,5,5,6,6,6], [4,5,6,4,5,6]);
        [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [7,7,8,8,9,9], [4,5,4,5,4,5]);
        [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [1], [11]);
        [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA, [4,4,5,5], [12,13,12,13]);
        [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [7,7,8,8,9,9], [11,12,11,12,11,12]);
        %n = 5; f1 = 1.876; f2 = 2.05;  
        n = 5; f1 = 1.933; f2 = 2.107;
    elseif strcmp(msrmnt,'KB_(3)')
        [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [1,2], [4,4]); %RGBData_RF = fnMergeRGBData(RGBFaceMapDATA, Nx, Ny);
        [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [4,4,5,5], [3,4,3,4]);
        [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA, [7,8,9], [3,3,3]);
        [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [], []);
        [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA, [2,2,3,3], [12,13,12,13]);
        [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA, [9,9,9,10,10,10,11,11,11], [11,12,13,11,12,13,11,12,13]);
        n = 5; f1 = 2.315; f2 = 2.489;
    end
    
    RGBFaceMapDATA4Analisys = RGBFaceMapDATA(n1:n2,:,:,:);
    [RGBData_RF, RGBData_RF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, RF);
    [RGBData_CF, RGBData_CF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, CF);
    [RGBData_LF, RGBData_LF_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, LF);
    [RGBData_RC, RGBData_RC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, RC);
    [RGBData_CN, RGBData_CN_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, CN);
    [RGBData_LC, RGBData_LC_Norm] = fnMergeRGBData(RGBFaceMapDATA4Analisys, LC);
    
    RGBData_RF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_RF_Norm, f1, f2, n, fs, Ltot);
    RGBData_CF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_CF_Norm, f1, f2, n, fs, Ltot);
    RGBData_LF_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_LF_Norm, f1, f2, n, fs, Ltot);
    RGBData_RC_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_RC_Norm, f1, f2, n, fs, Ltot);
    RGBData_CN_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_CN_Norm, f1, f2, n, fs, Ltot);
    RGBData_LC_Padded_Filtered = fnFilterHRCompWithPadding(RGBData_LC_Norm, f1, f2, n, fs, Ltot);
    
    if bitPlotData
    %% plot original and filtered one-region data and spectrum
        fnPlotAllOriginalAndFilteredDataAndSpectrum(k, delta_k, L, RGBData_RF, RGBData_RF_Norm, RGBData_RF_Padded_Filtered, RGBData_CF, RGBData_CF_Norm, RGBData_CF_Padded_Filtered, RGBData_LF, RGBData_LF_Norm, RGBData_LF_Padded_Filtered, RGBData_RC, RGBData_RC_Norm, RGBData_RC_Padded_Filtered, RGBData_CN, RGBData_CN_Norm, RGBData_CN_Padded_Filtered, RGBData_LC, RGBData_LC_Norm, RGBData_LC_Padded_Filtered);
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

  
%% plot filtered face region data
% N1 = 1; N2 = length(RGBData_RF_Padded_Filtered);
% figure; sgtitle('AZ (1)')
% subplot(231),hold on, fnPlotRGB(RGBData_RF_Padded_Filtered(N1:N2,:)), title('Right forehead');
% subplot(232),hold on, fnPlotRGB(RGBData_CF_Padded_Filtered(N1:N2,:)), title('Centre forehead');
% subplot(233),hold on, fnPlotRGB(RGBData_LF_Padded_Filtered(N1:N2,:)), title('Left forehead');
% subplot(234),hold on, fnPlotRGB(RGBData_RC_Padded_Filtered(N1:N2,:)), title('Right cheek');
% subplot(235),hold on, fnPlotRGB(RGBData_CN_Padded_Filtered(N1:N2,:)), title('Centre nose');
% subplot(236),hold on, fnPlotRGB(RGBData_LC_Padded_Filtered(N1:N2,:)), title('Left cheek');

