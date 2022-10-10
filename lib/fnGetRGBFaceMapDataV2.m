function RGBFaceMapDATA = fnGetRGBFaceMapDataV2(videoFile, videoFileRef, bboxRef, N, videoFileOut)
%RGBFaceMapDATA = fnGetRGBFaceMapDataV2(videoFile, videoFileRef, bbox4ThermMapRef, [nX nY], outputVideoFile);

videoFileReaderRef = vision.VideoFileReader(videoFileRef);
videoFrameRef      = step(videoFileReaderRef); 
videoFileReader = vision.VideoFileReader(videoFile);
if nargin == 5
    videoObject = VideoWriter(videoFileOut);
    open(videoObject);
end
nX = N(1); nY = N(2);
RGBFaceMapDATA = zeros(1000, nX, nY, 3);

bboxPoints = bbox2points(bboxRef(1, :));
points = detectMinEigenFeatures(rgb2gray(videoFrameRef), 'ROI', bboxRef);
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
points = points.Location;
initialize(pointTracker, points, videoFrameRef);
oldPoints = points;

n = 1;
while ~isDone(videoFileReader)
    videoFrame = step(videoFileReader);
    videoFrame4Cal = double(videoFrame);
    if n==1
        videoPlayer  = vision.VideoPlayer('Position',[100 100 [size(videoFrame, 2), size(videoFrame, 1)]]);
    end
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
    if nargin == 5
        writeVideo(videoObject, videoFrame);
    end 

    n = n + 1;
end
    
release(videoFileReader);
release(videoPlayer);
if nargin == 5
    close(videoObject)
end
    
RGBFaceMapDATA = RGBFaceMapDATA(1:n-1, :, :, :);