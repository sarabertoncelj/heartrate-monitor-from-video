function polygons4BP = fnGetPolygons4BP(videoFrame, PXY)

RF.Nx = [2,3,2,3]; RF.Ny = [1,1,2,2];
CF.Nx = [5,5,5]; CF.Ny = [1,2,3];
LF.Nx = [7,8,7,8]; LF.Ny = [1,1,2,2];
RC.Nx = [1,2,3,1,2,3]; RC.Ny = [8,8,8,9,9,9];
CN.Nx = [5,5,5]; CN.Ny = [7,8,9];
LC.Nx = [7,8,9,7,8,9]; LC.Ny = [8,8,8,9,9,9]; 

polygons4BP.RF = fnEliminateHighVariancePolygon(videoFrame,PXY,RF);
polygons4BP.CF = fnEliminateHighVariancePolygon(videoFrame,PXY,CF);
polygons4BP.LF = fnEliminateHighVariancePolygon(videoFrame,PXY,LF);
polygons4BP.RC = fnEliminateHighVariancePolygon(videoFrame,PXY,RC);
polygons4BP.CN = fnEliminateHighVariancePolygon(videoFrame,PXY,CN);
polygons4BP.LC = fnEliminateHighVariancePolygon(videoFrame,PXY,LC);

end

% RF.Nx = [2,3]; RF.Ny = [1,1];
% CF.Nx = [5]; CF.Ny = [1];
% LF.Nx = [7,8]; LF.Ny = [1,1];
% RC.Nx = [2,3]; RC.Ny = [9,9];
% CN.Nx = [5]; CN.Ny = [9];
% LC.Nx = [7,8]; LC.Ny = [9,9];   
% Nx = [RF.Nx CF.Nx LF.Nx RC.Nx CN.Nx LC.Nx];
% Ny = [RF.Ny CF.Ny LF.Ny RC.Ny CN.Ny LC.Ny];