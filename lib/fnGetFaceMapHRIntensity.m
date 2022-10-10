function Axk_av_norm = fnGetFaceMapHRIntensity(RGBFaceMapDATA, fk, fs)

nX = size(RGBFaceMapDATA,2); nY = size(RGBFaceMapDATA,3);
Axk = zeros(nX,nY,3); Axk_rel = zeros(nX,nY,3); Axk_rgbsum = zeros(nX,nY);

for i=1:nX
    for j=1:nY
        data = [RGBFaceMapDATA(:,i,j,1) RGBFaceMapDATA(:,i,j,2) RGBFaceMapDATA(:,i,j,3)];
        data_norm = fnNormalizeData(data, 1);
        data_norm_filt = fnFilterRGB(0.7/fs*2,5,4.5/fs*2,5,data_norm);
    
        [Axk(i, j, 1), Axk_rel(i,j, 1)] = fnAkFFT(data_norm_filt(:, 1),fk);
        [Axk(i, j, 2), Axk_rel(i,j, 2)] = fnAkFFT(data_norm_filt(:, 2),fk);
        [Axk(i, j, 3), Axk_rel(i,j, 3)] = fnAkFFT(data_norm_filt(:, 3),fk);
        Axk_rgbsum(i, j) = sum(Axk(i,j, 1:2));
        %Axk_rgbsum(i, j) = Axk(i, j, 2);
        
        data_norm_filt = fnFilterHRComp(data_norm, fk, 3, 2);
        Axk_rgbsum(i, j) = sum(sum(data_norm_filt(:,2).^2));
    end
end

npolAvX = 2; npolAvY = 1;
%AxAv = Axr(:, :, 2);
Axk_av = Axk_rgbsum;

MAX = max(max(Axk_av(npolAvX+1:nX-npolAvX, npolAvY+1:nY-npolAvY))); 
MIN = min(min(Axk_av(npolAvX+1:nX-npolAvX, npolAvY+1:nY-npolAvY)));

Axk_av_norm = zeros(nX,nY);
for i=1:nX
    for j=1:nY
        Axk_av_norm(i, j) = 1-(MAX-Axk_av(i, j))/(MAX-MIN);    
    end
end