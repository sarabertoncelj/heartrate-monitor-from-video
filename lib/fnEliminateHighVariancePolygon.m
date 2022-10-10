function validPolygons = fnEliminateHighVariancePolygon(videoFrame,PXY,possiblePolygons)

validPolygons.Nx = [];
validPolygons.Ny = [];
s = size(possiblePolygons.Nx);
for i = 1 : s(2)
    polygonVariance = fnGetRGBPolyVariance(videoFrame, PXY{possiblePolygons.Nx(i),possiblePolygons.Ny(i)});
    if polygonVariance(1) < 0.005
        validPolygons.Nx = [validPolygons.Nx possiblePolygons.Nx(i)];
        validPolygons.Ny = [validPolygons.Ny possiblePolygons.Ny(i)]; 
    end
end


end