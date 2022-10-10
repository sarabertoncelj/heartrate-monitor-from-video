function R_RGBData = fnGetRGBCorrelations(RGBData)
    
    S = size(RGBData); R_RGBData  = [];
    if round(S(2)/3)==S(2)/3
        R = corrcoef(RGBData(:,2:3:S(2)-1));
        R_RGBData = fnMatrixTopTriangleWithoutDiagonal2Vector(R);
    else
        disp('InputDataError: Input matrix for calculating correlation must have 3*N columns!');
    end
    
end

    