function [Ax, Axr] = fnAkFFT(x,k)

[~, AX , ~] = fnFFT(x); 
Ax = AX(k);

Axr = Ax/sum(AX);

