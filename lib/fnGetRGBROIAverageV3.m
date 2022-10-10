function RGBData = fnGetRGBROIAverageV3(videoFile, bbox, bbox2Par, videoFileOut)

videoFileReader = vision.VideoFileReader(videoFile);
videoFrame      = step(videoFileReader); 

bbox2WidthX     = bbox2Par(1); 
bbox2WidthY     = bbox2Par(2); 
bbox2OffsetY    = bbox2Par(3);
bbox2OffsetX    = bbox2Par(4);

bbox2           = [bbox(1)+bbox2OffsetX, bbox(2)+bbox(4)+bbox2OffsetY, bbox2WidthX, bbox2WidthY]; % ROI for heart rate measurement 

% save video result
if nargin == 4
    videoObject = VideoWriter(videoFileOut);
    open(videoObject)
end

RGBData = zeros(1000, 3);

% optical flow for bbox
bboxPoints      = bbox2points(bbox(1, :));
points          = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);

pointTracker    = vision.PointTracker('MaxBidirectionalError', 2);
points          = points.Location;
initialize(pointTracker, points, videoFrame);

videoPlayer     = vision.VideoPlayer('Position', [100 100 [size(videoFrame, 2), size(videoFrame, 1)]]);

oldPoints       = points;
    
% average color chanels values
RGBData(1,1)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),1)))/(bbox2(3)+1)/(bbox2(4)+1);
RGBData(1,2)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),2)))/(bbox2(3)+1)/(bbox2(4)+1);
RGBData(1,3)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),3)))/(bbox2(3)+1)/(bbox2(4)+1);

n = 2;

while ~isDone(videoFileReader)
    videoFrame        = step(videoFileReader);
    [points, isFound] = step(pointTracker, videoFrame);
    visiblePoints     = points(isFound, :);
    oldInliers        = oldPoints(isFound, :);
    
    if size(visiblePoints, 1) >= 2         
        [xform, ~, visiblePoints] = estimateGeometricTransform(oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);

        bboxPoints = round(transformPointsForward(xform, bboxPoints));
        bbox2WidthXTemp = round(bbox2WidthX*(bboxPoints(2,1)-bboxPoints(1,1))/bbox(3));
        bbox2WidthYTemp = round(bbox2WidthY*(bboxPoints(3,2)-bboxPoints(1,2))/bbox(4));
        bbox2      = [bboxPoints(1,1)+bbox2OffsetX,bboxPoints(3,2)+bbox2OffsetY, bbox2WidthXTemp, bbox2WidthYTemp];
            
        bboxPolygon = reshape(bboxPoints', 1, []);
        videoFrame  = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 2);
        videoFrame  = insertShape(videoFrame, 'Rectangle', bbox2, 'Color', 'm', 'LineWidth', 2);            
        videoFrame  = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');
            
        oldPoints = visiblePoints;
        setPoints(pointTracker, oldPoints); 
    end
    
    step(videoPlayer, videoFrame);
    if nargin == 4
        writeVideo(videoObject, videoFrame);
    end    
   
    RGBData(n, 1)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),1)))/(bbox2(3)+1)/(bbox2(4)+1);
    RGBData(n, 2)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),2)))/(bbox2(3)+1)/(bbox2(4)+1);
    RGBData(n, 3)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),3)))/(bbox2(3)+1)/(bbox2(4)+1);
    
    n = n + 1;
end

release(videoFileReader);
release(videoPlayer);

if nargin == 4
    close(videoObject)
end

RGBData = RGBData(1:n-1,:);


