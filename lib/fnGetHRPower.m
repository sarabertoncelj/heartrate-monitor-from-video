function [RGBData_HR_Power, RGBData_HR_BWPower] = fnGetHRPower(RGBData, k, delta_k, L)

RGBData_AxFFT = abs(fnFFTWithPadding(RGBData, L));
RGBData_HR_Power = max(RGBData_AxFFT(k-delta_k:k+delta_k,:));
RGBData_HR_BWPower = sum(RGBData_AxFFT(k-delta_k:k+delta_k,:).^2);




