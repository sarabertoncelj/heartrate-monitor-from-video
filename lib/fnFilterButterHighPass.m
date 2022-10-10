function data_filt = fnFilterButterHighPass(f_hp, n, fs, data)

%[b,a] = butter(n,[f_hp f_lp]/fs*2,'bandpass');
%figure;freqz(b,a)
% figure;zplane(b,a)
%data_filt = filter(b, a, data);

[b,a] = butter(n,f_hp/fs*2,'high');
data_filt = filter(b,a,data);