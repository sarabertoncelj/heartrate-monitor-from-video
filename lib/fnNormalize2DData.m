function XNorm = fnNormalize2DData(X, stdBit)

S = size(X)
x = reshape(X,1,S(1)+S(2));
meanX = mean(x);
stdX = std(x);
XNorm = X - ones(S(1),S(2))*meaX;
if stdBit ==1
    XNorm = XNorm./(ones(S(1),S(2))*std(XNorm));
end
