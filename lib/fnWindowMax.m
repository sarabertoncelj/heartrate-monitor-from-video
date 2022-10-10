function dataW = fnWindowMax(data, fs)

delta = round(170/60*fs/3);
maxLoc=fnFindLocalMax(data(delta:end,2),5e-4,170/60*fs/3) + delta -1;
dataW = data(maxLoc(1):maxLoc(end)-1,:);

plot(data(:,2))
hold on
plot(maxLoc,data(maxLoc,2))
