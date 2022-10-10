function [RGBData_HR_Power, RGBData_HR_BWPower] = fnGetHRWindowedPower(RGBData, k, delta_k)

S = size(RGBData);
w = hann(S(1)); W = w*ones(1,S(2));
RGBData_windowed = RGBData.*W;
RGBData_windowed_AxFFT = abs(fnFFT(RGBData_windowed));
RGBData_HR_Power = max(RGBData_windowed_AxFFT(k-delta_k:k+delta_k,:));
RGBData_HR_BWPower = sum(RGBData_windowed_AxFFT(k-delta_k:k+delta_k,:).^2);