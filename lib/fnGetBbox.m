function bboxPoints = fnGetBbox(videoFrame, videoFrameRef, bboxRef)

bboxPoints = bbox2points(bboxRef(1, :));
% points = detectMinEigenFeatures(rgb2gray(videoFrameRef), 'ROI', bboxRef);
points = detectSURFFeatures(rgb2gray(videoFrameRef), 'ROI', bboxRef);

% videoFrameRef = insertMarker(videoFrameRef, points, '+', 'Color', 'white');
% figure; imshow(videoFrameRef); title('FaceMap Ref Points');

pointTracker = vision.PointTracker('MaxBidirectionalError', 2);
points = points.Location;
initialize(pointTracker, points, videoFrameRef);

oldPoints = points;

[points, isFound] = step(pointTracker, videoFrame);
visiblePoints = points(isFound, :);
oldInliers = oldPoints(isFound, :);
        
if size(visiblePoints, 1) >= 2         
    [xform, ~, visiblePoints] = estimateGeometricTransform(...
            oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
%     videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');
%     figure; imshow(videoFrame); title('FaceMap Visible Points');
    
    bboxPoints = round(transformPointsForward(xform, bboxPoints));            
end
