function RGBData_FFT = fnFFTWithPadding(RGBData, L)

S = size(RGBData);
RGBData_Padded = zeros(L, S(2)); l = round((L-S(1))/2);
if l > 0
    RGBData_Padded(l:l+S(1)-1,:) = RGBData;
else
    RGBData_Padded = RGBData;
end
RGBData_FFT = fnFFT(RGBData_Padded);