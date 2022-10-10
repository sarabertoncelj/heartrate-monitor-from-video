function V = fnMatrixTopTriangleWithoutDiagonal2Vector(M)

S = size(M);
V = [];

if S(1)==S(2)
    for i = 1:S(1)-1
        V = [V M(i, i+1:end)];
    end
else
    disp('InputDataError: Input matrix must be square!');
end
