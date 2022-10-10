function RGBHRData = fnFilterHRComp(RGBData, kHR, deltak, Nh)

s = size(RGBData);
w = hann(s(1)); W = w*ones(1,s(2)); 
%RGBData = W.*RGBData;

X = fnFFT(RGBData);
XFilt = zeros(size(X));

for i=1:Nh
    k = (kHR-1)*i + 1;
    XFilt(k-deltak:k+deltak,:) = X(k-deltak:k+deltak,:);
    XFilt(end-k-deltak+2:end-k+deltak+2,:) = X(end-k-deltak+2:end-k+deltak+2,:);
end

%figure;plot(abs(XFilt))

RGBHRData = fnIFFT(XFilt);


