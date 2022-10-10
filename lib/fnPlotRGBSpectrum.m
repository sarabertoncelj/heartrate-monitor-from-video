function fnPlotRGBSpectrum(RGBData, k, delta_k, L)

RGBData_AxFFT = abs(fnFFTWithPadding(RGBData, L));
rectangle('Position',[k-delta_k, 0, delta_k*2+1, max(RGBData_AxFFT(k,:))],'FaceColor',[0.1 0.1 0.1]);
fnPlotRGB(RGBData_AxFFT(1:L/2,:))
plot(k, RGBData_AxFFT(k,1), 'or')
plot(k, RGBData_AxFFT(k,2), 'og')
plot(k, RGBData_AxFFT(k,3), 'ob')
