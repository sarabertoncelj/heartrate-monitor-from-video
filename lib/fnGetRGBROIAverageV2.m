function RGBData = fnGetRGBROIAverageV2(videoFile, bbox, bbox2Par, videoFileOut)

videoFileReader = vision.VideoFileReader(videoFile);
videoFrame      = step(videoFileReader); 

bbox2WidthX     = bbox2Par(1); 
bbox2WidthY     = bbox2Par(2); 
bbox2OffsetY    = bbox2Par(3);
bbox2OffsetX    = bbox2Par(4);

bbox2           = [bbox(1)+bbox2OffsetX, bbox(2)+bbox(4)+bbox2OffsetY, bbox2WidthX, bbox2WidthY]; % ROI for heart rate measurement 
NXhalf = round(bbox2(3)/2); NYhalf = round(bbox2(4)/2); 
NXquarter = round(NXhalf/2); NYquarter = round(NYhalf/2); 
W = fnGetWindow(bbox2, NXhalf, NYhalf, NXquarter, NYquarter);

videoSegment = videoFrame(bbox2(2)-NYquarter:bbox2(2)+bbox2(4)+NYquarter-1, bbox2(1)-NXquarter:bbox2(1)+bbox2(3)+NXquarter-1,:);
% average color chanels values
%figure;imshow(videoSegment);
RGBData(1,1)   = mean(mean(videoSegment(:,:,1).*W));
RGBData(1,2)   = mean(mean(videoSegment(:,:,2).*W));
RGBData(1,3)   = mean(mean(videoSegment(:,:,3).*W));

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
        NXhalf = round(bbox2(3)/2); NYhalf = round(bbox2(4)/2); 
        NXquarter = round(NXhalf/2); NYquarter = round(NYhalf/2);   
        W = fnGetWindow(bbox2, NXhalf, NYhalf, NXquarter, NYquarter);
        
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
   
    videoSegment = videoFrame(bbox2(2)-NYquarter:bbox2(2)+bbox2(4)+NYquarter-1, bbox2(1)-NXquarter:bbox2(1)+bbox2(3)+NXquarter-1,:);
    % average color chanels values
    %figure;imshow(videoSegment);
    RGBData(n,1)   = mean(mean(videoSegment(:,:,1).*W));
    RGBData(n,2)   = mean(mean(videoSegment(:,:,2).*W));
    RGBData(n,3)   = mean(mean(videoSegment(:,:,3).*W));
    
    n = n + 1;
end

release(videoFileReader);
release(videoPlayer);

if nargin == 4
    close(videoObject)
end

RGBData = RGBData(1:n-1,:);

end 


function W = fnGetWindow(bbox2, NXhalf, NYhalf, NXquarter, NYquarter)
    windowX = hann(NXhalf); 
    windowY = hann(NYhalf);
    W = zeros(bbox2(4) + NYquarter*2,bbox2(3) + NXquarter*2);

    for i = 1:NYquarter
        windowTemp = windowX(1:NXquarter)*windowY(i);
        W(i,:) = [windowTemp' ones(1,bbox2(3))*windowY(i) flip(windowTemp)'];
        W(bbox2(4)+2*NYquarter-i+1,:) = [windowTemp' ones(1,bbox2(3))*windowY(i) flip(windowTemp)'];
    end
    for i = NYquarter+1:NYquarter+bbox2(4)
        windowTemp = windowX(1:NXquarter);
        W(i,:) = [windowTemp' ones(1,bbox2(3)) flip(windowTemp)'];
    end    
    %figure;imshow(W)
end


