function dataFilt = fnFir(data, Wn, n, bitPlotFilter)

b = fir1(n, Wn);
if bitPlotFilter
    figure;freqz(b,1)
    figure;zplane(b,1)
end

dataFilt = filter(b,1,data);

