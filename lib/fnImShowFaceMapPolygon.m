function [polygons4BP, PXY] = fnImShowFaceMapPolygon(bboxPoints,N,videoFrame,returnROI4BPSegments,inputVideoFileName)

nX = N(1); nY = N(2);
polygon.x = bboxPoints(:,1);
polygon.y = bboxPoints(:,2);
[PXY, ~, ~] = fnDividePoly(polygon,nX,nY);

for i = 1:nX
    for j = 1:nY
        bboxTempPoints(:,1) = PXY{i,j}.x;
        bboxTempPoints(:,2) = PXY{i,j}.y;
        bboxPolygonTemp = reshape(bboxTempPoints', 1, []);
        if (i/10)==round(i/10)
            if (j/10)==round(j/10)
                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'r', 'LineWidth', 5);
                %videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 5);
            else
                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'c', 'LineWidth', 2);
                %videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 2);
           end
        elseif (i/5)==round(i/5)
            videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'y', 'LineWidth', 2);
            %videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 2);
        else
            videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 2);
        end
    end
end

if returnROI4BPSegments==1
    polygons4BP = fnGetPolygons4BP(videoFrame, PXY);
    Nx = [polygons4BP.RF.Nx polygons4BP.CF.Nx polygons4BP.LF.Nx polygons4BP.RC.Nx polygons4BP.CN.Nx polygons4BP.LC.Nx];
    Ny = [polygons4BP.RF.Ny polygons4BP.CF.Ny polygons4BP.LF.Ny polygons4BP.RC.Ny polygons4BP.CN.Ny polygons4BP.LC.Ny];
    for i=1:length(Nx)
        bboxTempPoints(:,1) = PXY{Nx(i),Ny(i)}.x;
        bboxTempPoints(:,2) = PXY{Nx(i),Ny(i)}.y;
        bboxPolygonTemp = reshape(bboxTempPoints', 1, []);
        videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'blue', 'LineWidth', 3);
    end 
else
    polygons4BP = [];
end
    
figure; imshow(videoFrame); % title('FaceMap');
%k = strfind(inputVideoFileName, '.');
%savefig(strcat('OutputImages/', inputVideoFileName(1:k-1)));