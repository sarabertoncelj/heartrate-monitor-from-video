function P = fnGetPower(RGBData)

s = size(RGBData);
P = zeros(1,s(2));

for i = 1:s(2)
    P(i) = sum(RGBData(:,i).^2)/s(1);
end