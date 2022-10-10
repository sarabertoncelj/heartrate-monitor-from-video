function RGBData_Padded_Filtered = fnFilterHRCompWithPadding(RGBData, f1, f2, n, fs, L)

S = size(RGBData);
RGBData = fnNormalizeData(RGBData, 0);
RGBData_Padded = zeros(L, 3); l = round((L-S(1))/2);
if l > 0
    RGBData_Padded(l:l+S(1)-1,:) = RGBData;
else
    RGBData_Padded = RGBData;
end
RGBData_Padded_Filtered = fnFilterButterBandPass(f1, f2, n, fs, RGBData_Padded);





 
