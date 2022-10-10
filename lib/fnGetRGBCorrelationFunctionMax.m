function [RFmax RFmax_n] = fnGetRGBCorrelationFunctionMax(RGBData)
    
    RGBData = fnNormalizeData(RGBData,1);
    S = size(RGBData); RFmax  = []; RFmax_n = [];
    if round(S(2)/3)==S(2)/3
        GData = RGBData(:,2:3:S(2)-1);
        GData_fft = fnFFT(GData);
        S_GData = size(GData);
        n = 1;
        for i = 1:S_GData(2)-1
            for j = i+1:S_GData(2)
                RF(1:S(1),n) = fnIFFT(GData_fft(:,i).*conj(GData_fft(:,j)));
                RFmax(n) = max(RF(1:S(1),n));
                n_temp = find(RF(1:S(1),n)==RFmax(n));
                RFmax_n(n) = n_temp(1);
                if RFmax_n(n) > S(1)/2
                    RFmax_n(n) = RFmax_n(n)-S(1)-1;
                end
                n = n+1;
            end
        end
    else
        disp('InputDataError: Input matrix for calculating correlation must have 3*N columns!');
    end
    
end
   