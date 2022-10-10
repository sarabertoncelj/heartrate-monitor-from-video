function [bbox, polygons4BP, brightness, headBrightness, skinColor] = fnGetMeasurementParametersV2(inputVideoFileName, inputVideoFilePath)

load('GlobalVariables.mat')
inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName);
outputVideoFile = strcat('OutputVideos/', inputVideoFileName);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame)

bbox            = fnEliminateFalsePositives(bbox, 150);
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox, 'Color', 'y', 'LineWidth', 2);
%bbox = bbox(2,:);
bbox            = fnResizeHead2Face(bbox);
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox, 'Color', 'm', 'LineWidth', 4);
%figure; imshow(videoFrame); title('Heart rate measurement');

%nX = GV.nX4FaceMap;
%nY = GV.nY4FaceMap;
%nX = 34;%nY = 34;
nX = 11; nY = 9;
%polygons4BP = 0;
[polygons4BP, PXY] = fnImShowFaceMapPolygon(bbox2points(bbox), [nX nY], videoFrame, 0, inputVideoFileName);
%bboxForehead = [PXY{2,2}.x(1) PXY{2,2}.y(1) PXY{10,3}.x(3)-PXY{2,2}.x(1) PXY{10,3}.y(3)-PXY{2,2}.y(1)]
bboxForehead = [PXY{1,1}.x(1) PXY{1,1}.y(1) PXY{11,2}.x(3)-PXY{1,1}.x(1) PXY{11,2}.y(3)-PXY{1,1}.y(1)]
%bboxForehead = [PXY{2,1}.x(1) PXY{2,1}.y(1) PXY{9,2}.x(3)-PXY{2,1}.x(1) PXY{9,2}.y(3)-PXY{2,1}.y(1)]
videoFrame      = insertShape(videoFrame, 'Rectangle', bboxForehead, 'Color', 'r', 'LineWidth', 4);
figure; imshow(videoFrame); title('Heart rate measurement');

brightness = fnGetBrightness(videoFrame)
headBrightness = fnGetBrightness(videoFrame, bbox);
skinColor = headBrightness(1:3)./sum(headBrightness(1:3));
skinColor = headBrightness(1:3)./headBrightness(4);

foreheadBrightness = fnGetBrightness(videoFrame, bboxForehead)
skinColor = foreheadBrightness(1:3)./sum(foreheadBrightness(1:3))
skinColor = foreheadBrightness(1:3)./foreheadBrightness(4)

%RGBFaceMapDATA = fnGetRGBFaceMapData4BP(inputVideoFile, bbox, [nX, nY], outputVideoFile);
