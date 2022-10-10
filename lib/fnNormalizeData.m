function xNorm = fnNormalizeData(x, stdBit)

xNorm = x - ones(size(x,1),1)*mean(x);
if stdBit ==1
    xNorm = xNorm./(ones(size(x,1),1)*std(xNorm));
end
