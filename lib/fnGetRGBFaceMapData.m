function RGBFaceMapDATA = fnGetRGBFaceMapData(videoFile, bbox, bbox2Par, videoFileOut)

videoFileReader = vision.VideoFileReader(videoFile);
videoFrame      = step(videoFileReader); 

bbox2WidthX     = bbox2Par(1);
bbox2WidthY     = bbox2Par(2);
nX = bbox(3)/bbox2WidthX;
nY = bbox(4)/bbox2WidthY;

RGBFaceMapDATA = zeros(1000, nX, nY, 3);

videoFrame4Cal = double(videoFrame);
bboxPoints = bbox2points(bbox(1, :));
points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
points = points.Location;
initialize(pointTracker, points, videoFrame);

videoPlayer  = vision.VideoPlayer('Position',[100 100 [size(videoFrame, 2), size(videoFrame, 1)]]);

oldPoints = points;
     
polygon.x = bboxPoints(:,1);
polygon.y = bboxPoints(:,2);
[PXY, ~, ~] = fnDividePoly(polygon,nX,nY);

for i = 1:nX
    for j = 1:nY
        bboxTempPoints(:,1) = PXY{i,j}.x;
        bboxTempPoints(:,2) = PXY{i,j}.y;
        bboxPolygonTemp = reshape(bboxTempPoints', 1, []);
        videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 2);        
        RGBFaceMapDATA(1,i,j,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{i,j});
    end
end
    
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox);
step(videoPlayer, videoFrame);
if nargin == 4
    videoObject = VideoWriter(videoFileOut);
    open(videoObject);
    writeVideo(videoObject, videoFrame);
end
    
n = 2; 
    
while ~isDone(videoFileReader)
    videoFrame = step(videoFileReader);
    videoFrame4Cal = double(videoFrame);
    [points, isFound] = step(pointTracker, videoFrame);
    visiblePoints = points(isFound, :);
    oldInliers = oldPoints(isFound, :);
        
    if size(visiblePoints, 1) >= 2         
        [xform, ~, visiblePoints] = estimateGeometricTransform(...
            oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);

        bboxPoints = round(transformPointsForward(xform, bboxPoints));            
        bboxPolygon = reshape(bboxPoints', 1, []);           
        polygon.x = bboxPoints(:,1);
        polygon.y = bboxPoints(:,2);
        [PXY, ~, ~] = fnDividePoly(polygon,nX,nY);

        for i = 1:nX
            for j = 1:nY                   
                bboxTempPoints(:,1) = PXY{i,j}.x;
                bboxTempPoints(:,2) = PXY{i,j}.y;
                bboxPolygonTemp = reshape(bboxTempPoints', 1, []);
                videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygonTemp, 'Color', 'm', 'LineWidth', 2);
                RGBFaceMapDATA(n,i,j,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{i,j});                
            end
        end

        videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');
        videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 2);
        oldPoints = visiblePoints;
        setPoints(pointTracker, oldPoints); 
    end
    
    step(videoPlayer, videoFrame);
    if nargin == 4
        writeVideo(videoObject, videoFrame);
    end 

    n = n + 1;
end
    
release(videoFileReader);
release(videoPlayer);
if nargin == 4
    close(videoObject)
end
    
RGBFaceMapDATA = RGBFaceMapDATA(1:n-1, :, :, :);
