function fnPlotMeanVsBP(F, S)

% AZ_1_VideoFaceSFLocal = AZ_1.VideoFaceSF.^2/AZ_1.k;
% AZ_2_VideoFaceSFLocal = AZ_2.VideoFaceSF.^2/AZ_2.k;
% AZ_3_VideoFaceSFLocal = AZ_3.VideoFaceSF.^2/AZ_3.k;
% MK_1_VideoFaceSFLocal = MK_1.VideoFaceSF.^2/MK_1.k;
% NB_1_VideoFaceSFLocal = NB_1.VideoFaceSF.^2/NB_1.k;
% KB_1_VideoFaceSFLocal = KB_1.VideoFaceSF.^2/KB_1.k;
% AZ_1_VideoFaceSFLocal = 1/9;
% AZ_2_VideoFaceSFLocal = 1/28;
% AZ_3_VideoFaceSFLocal = 1/15;
% MK_1_VideoFaceSFLocal = 1/5;
% NB_1_VideoFaceSFLocal = 1/9;
% KB_1_VideoFaceSFLocal = 1/11;
% kOff4HRPower = 55; %% HRW_Power
kOff4Mean = 4; delta_k = 17; 

%% plot for systolic
figure; 
subplot(271), hold on
plot(F(1,:), F(kOff4Mean,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+1,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+2,:)./S, '*', 'Color', [0 0 1])

subplot(272), hold on
plot(F(1,:), F(kOff4Mean+3,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+4,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+5,:)./S, '*', 'Color', [0 0 1])

subplot(273), hold on
plot(F(1,:), F(kOff4Mean+6,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+7,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+8,:)./S, '*', 'Color', [0 0 1])

subplot(278), hold on
plot(F(1,:), F(kOff4Mean+9,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+10,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+11,:)./S, '*', 'Color', [0 0 1])

subplot(279), hold on
plot(F(1,:), F(kOff4Mean+12,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+13,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+14,:)./S, '*', 'Color', [0 0 1])

subplot(2,7,10), hold on
plot(F(1,:), F(kOff4Mean+15,:)./S, '*', 'Color', [1 0 0])
plot(F(1,:), F(kOff4Mean+16,:)./S, '*', 'Color', [0 1 0])
plot(F(1,:), F(kOff4Mean+17,:)./S, '*', 'Color', [0 0 1])

%% plot for diastolic
subplot(275), hold on
plot(F(2,:), F(kOff4Mean,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+1,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+2,:)./S, '*', 'Color', [0 0 1])

subplot(276), hold on
plot(F(2,:), F(kOff4Mean+3,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+4,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+5,:)./S, '*', 'Color', [0 0 1])

subplot(277), hold on
plot(F(2,:), F(kOff4Mean+6,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+7,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+8,:)./S, '*', 'Color', [0 0 1])

subplot(2,7,12), hold on
plot(F(2,:), F(kOff4Mean+9,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+10,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+11,:)./S, '*', 'Color', [0 0 1])

subplot(2,7,13), hold on
plot(F(2,:), F(kOff4Mean+12,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+13,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+14,:)./S, '*', 'Color', [0 0 1])

subplot(2,7,14), hold on
plot(F(2,:), F(kOff4Mean+15,:)./S, '*', 'Color', [1 0 0])
plot(F(2,:), F(kOff4Mean+16,:)./S, '*', 'Color', [0 1 0])
plot(F(2,:), F(kOff4Mean+17,:)./S, '*', 'Color', [0 0 1])


X = [F(1,:); F(2,:); F(1,:)-F(2,:); F(kOff4Mean:kOff4Mean+17,:)];
R = corrcoef(X')

 
