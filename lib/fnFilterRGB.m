function data_bp = fnFilterRGB(omega_hp, n_hp, omega_lp, n_lp, data)
%% funkcija implementira butter srednjeprepustni filter
%% zaradi boljse ilustracije delovanja je srednjeprepustni filter implementiran 
%% kot zaporedje nizko in visoko prepustnih filtrov
%% parametri:
%% omega_hp - normirana krozna frekvenca - zacetek prepustnega obmocja
%% n_hp - red nizkoprepustnega filtra
%% omega_lp - normirana krozna frekvenca - konec prepustnega obmocja
%% n_lp - red visokoprepustnega filtra

%% nizkoprepustni filter
[b,a] = butter(n_lp,omega_lp,'low');
%figure;freqz(b,a)
% figure;zplane(b,a)

data_lp = filter(b,a,data);

% figure;
% subplot(311)
% plot(data(:,1),'r'), hold on, plot(data_lp(:,1),'k')
% subplot(312)
% plot(data(:,2),'r'), hold on, plot(data_lp(:,2),'k')
% subplot(313)
% plot(data(:,3),'r'), hold on, plot(data_lp(:,3),'k')

% figure;
% subplot(311)
% plot(data(50:end,1),'r'), hold on, plot(data_lp(50:end,1),'k')
% xlabel('n'), ylabel('red')
% subplot(312)
% plot(data(50:end,2),'g'), hold on, plot(data_lp(50:end,2),'k')
% xlabel('n'), ylabel('green')
% subplot(313)
% plot(data(50:end,3),'b'), hold on, plot(data_lp(50:end,3),'k')
% xlabel('n'), ylabel('blue')


%% visokoprepustni filter
[b,a] = butter(n_hp,omega_hp,'high');
%figure;freqz(b,a)
% figure;zplane(b,a)

data_bp = filter(b,a,data_lp);

% figure;
% subplot(311)
% plot(data(:,1),'r'), hold on, plot(data_bp(:,1),'k')
% subplot(312)
% plot(data(:,2),'r'), hold on, plot(data_bp(:,2),'k')
% subplot(313)
% plot(data(:,3),'r'), hold on, plot(data_bp(:,3),'k')

% figure;
% subplot(311)
% plot(data(100:end,1)-mean(data(:,1)),'r'), hold on, plot(data_lp(100:end,1)-mean(data_lp(:,1)),'k'), hold on, plot(data_bp(100:end,1),'m')
% xlabel('n'), ylabel('red')
% subplot(312)
% plot(data(100:end,2)-mean(data(:,2)),'g'), hold on, plot(data_lp(100:end,2)-mean(data_lp(:,2)),'k'), hold on, plot(data_bp(100:end,2),'m')
% xlabel('n'), ylabel('green')
% subplot(313)
% plot(data(100:end,3)-mean(data(:,3)),'b'), hold on, plot(data_lp(100:end,3)-mean(data_lp(:,3)),'k'), hold on, plot(data_bp(100:end,3),'m')
% xlabel('n'), ylabel('blue')


