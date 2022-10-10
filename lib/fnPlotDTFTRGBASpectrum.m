function fnPlotDTFTRGBASpectrum(RGBDataA, f, k, delta_k, k_noise, delta_k_noise, k1stHarm)

rectangle('Position',[f(k-delta_k), 0, f(delta_k*2+1), max(RGBDataA(k,:))],'FaceColor',[0.1 0.1 0.1]);
rectangle('Position',[f(k_noise-delta_k_noise), 0, f(delta_k_noise*2+1), max(max(RGBDataA(k_noise-delta_k_noise:k_noise+delta_k_noise,:)))],'FaceColor',[0.1 0.1 0.1]);
rectangle('Position',[f(k1stHarm-delta_k), 0, f(delta_k*2+1), max(max(RGBDataA(k1stHarm-delta_k:k1stHarm+delta_k,:)))],'FaceColor',[0.1 0.1 0.1]);

%fnPlotRGB(f, RGBDataA)
hold on
plot(f,RGBDataA(:,1),'r')
plot(f,RGBDataA(:,2),'g')
plot(f,RGBDataA(:,3),'b')
plot(f(k), RGBDataA(k,1), 'or')
plot(f(k), RGBDataA(k,2), 'og')
plot(f(k), RGBDataA(k,3), 'ob')
plot(f(k1stHarm), RGBDataA(k1stHarm,1), 'or')
plot(f(k1stHarm), RGBDataA(k1stHarm,2), 'og')
plot(f(k1stHarm), RGBDataA(k1stHarm,3), 'ob')
