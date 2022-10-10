function [A, AW, f] = fnDTFTRGB(x,fs,bitWin,plotTitle,colors)

load('GlobalVariables.mat')
L = length(x); n = 0:L-1;
%% dtft
omega = linspace(GV.fDTFTMin/fs*2*pi,GV.fDTFTMax/fs*2*pi,GV.fNumOfPoints); f = omega/2/pi*fs*60;
[~,A,~,~] = fnDTFT3(x, omega); A = A./L;
%% windowing
if bitWin
    w = hann(L); W = w*ones(1,size(x,2));
    xw = x.*W;
    [~,AW,~,~] = fnDTFT3(xw, omega); AW = AW./L;
else
    xw=x;
    AW=A;
end

if nargin == 5    
    t = n/30;   
    figure; 
    %% time plot   
    subplot(121), hold on
    %for i=1:size(x,2)
    for i=2:2
        plot(t,-x(:,i),colors(i,:),'LineWidth',1.5)
    end
    xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', 20), ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 20)
    %axis([min(t) max(t) min(min(x)) max(max(x))])
    axis([min(t) max(t) -6e-3 8e-3])
    title('Casovni prostor','FontSize', 12)
       
    %% frequency plot
        %% original
    subplot(122), hold on
    %for i=1:size(x,2)
    k = 19 + find(A(20:end,i)==max(A(20:end,i)));
    for i=2:2
        plot(f,A(:,i),colors(i,:),'LineWidth',1.5)
    end
    hold on
    plot(f(k),A(k,i), '.k', 'MarkerSize', 12)
    xlabel('$f$ [bpm]', 'Interpreter', 'latex', 'FontSize', 20), ylabel('$A_X (f)$', 'Interpreter', 'latex', 'FontSize', 20)
    axis([min(f) max(f) 0 max(max(A(:,2)))])
    %axis([min(f) max(f) 0 8e-4])
    title('    Frekvencni prostor','FontSize', 12)
    
    set(gcf,'Position',[460 200 750 350])

end
