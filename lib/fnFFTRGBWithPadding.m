function [AXW4plot, f4plot] = fnFFTRGBWithPadding(x,fs,LP,plotTitle,colors)

L = length(x);
% k = 0:L-1; f = k/L*fs;
% 
% [~, AX , ~] = fnFFT(x);
% 
% KplotOff = round(L/2); f4plot = f(1:KplotOff); AX4plot = AX(1:KplotOff,:);
%% windowing
w = hann(L); W = w*ones(1,size(x,2));
xw = x.*W;
%%% zero-padding
Lz = floor((LP-length(x))/2);
xw = [zeros(Lz,3); xw; zeros(Lz,3)];
L = length(xw);
k = 0:L-1; f = k/L*fs;
KplotOff = round(L/2); f4plot = f(1:KplotOff);
%%%%%%%

%% dft
[~, AXW , ~] = fnFFT(xw);
AXW4plot = AXW(1:KplotOff,:);

if nargin == 5
    figure; sgtitle(plotTitle)
    subplot(211), hold on
    for i=1:size(xw,2)
        plot(k,xw(:,i),colors(i,:))
    end
    xlabel('$n$', 'Interpreter', 'latex'), ylabel('$x_w[n]$', 'Interpreter', 'latex')
    axis([min(k) max(k) min(min(xw)) max(max(xw))])
    subplot(212), hold on
    for i=1:size(x,2)
        plot(f4plot,AXW4plot(:,i),colors(i,:))
    end
    xlabel('$f$ [Hz]', 'Interpreter', 'latex'), ylabel('$A_{XW} [f]$', 'Interpreter', 'latex')
    axis([min(f4plot) max(f4plot) min(min(AXW4plot)) max(max(AXW4plot))])

    set(gcf,'Position',[100 100 800 550])
end
