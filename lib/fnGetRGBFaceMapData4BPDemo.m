function RGBFaceMapDATA = fnGetRGBFaceMapData4BPDemo(videoFile, bbox, N, nXHR, nYHR)

videoFileReader = vision.VideoFileReader(videoFile);
videoFrame      = step(videoFileReader); 
nX = N(1); nY = N(2);
%RGBFaceMapDATA = zeros(1000, nX, nY, 3);
RGBFaceMapDATA = zeros(1000, 3);

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
        %RGBFaceMapDATA(1,i,j,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{i,j});
    end
    RGBFaceMapDATA(1,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{nXHR,nYHR});
end
    
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox);
step(videoPlayer, videoFrame);
    
n = 2; 
% figure(1);
% xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', 20), ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 20)
% title('Extracted colour signals', 'FontSize', 20)
% axis([0 10 0.5 1])
    
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
                %RGBFaceMapDATA(n,i,j,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{i,j});                
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

    RGBFaceMapDATA(n,:) = fnGetRGBPolyMean(videoFrame4Cal, PXY{nXHR,nYHR});
    
    if n/30==round(n/30)
        figure(1); 
        n4plot = 0:n-2;
        t = n4plot/30; 
        plot(t,squeeze(RGBFaceMapDATA(2:n,1)),'r','LineWidth',1.5), hold on
        plot(t,squeeze(RGBFaceMapDATA(2:n,2)),'g','LineWidth',1.5)
        plot(t,squeeze(RGBFaceMapDATA(2:n,3)),'b','LineWidth',1.5)
        xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', 20), ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 20)
        title('Extracted colour signals', 'FontSize', 20)
        axis([0 max(10, max(t)) 0.4 1])
        hold off
    end
        
    if n>=300 && n/50==round(n/50)
        [k, HR, HRW, P_HR, P_HRW] = fnGetHeartRate(RGBFaceMapDATA(n-300+2:n,:), 'Demo', 30, 1); 
        disp(['HR: ' num2str(HR) ' bpm; P_HR: ' num2str(P_HR(2)*1e6/sum(mean(RGBFaceMapDATA(n-300+2:n,:)))^2)])
        %%break
    end
    
    n = n + 1;
    
end
    
release(videoFileReader);
release(videoPlayer);
    
RGBFaceMapDATA = RGBFaceMapDATA(1:n-1, :, :, :);
