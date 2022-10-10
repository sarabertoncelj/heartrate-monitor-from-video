function [X,A,phi,a] = fnDTFT3(x, omega)

N=length(x);
n=0:N-1;

M=length(omega);
W=zeros(M,N);
W0=exp(-1i);

for k=1:M
    W(k,:)=W0.^(omega(k)*n);
end

%% matrix-based coefficient calculation 
X=W*x;

A=abs(X);a=20*log10(A/max(A));
phi=fnArg(X);
