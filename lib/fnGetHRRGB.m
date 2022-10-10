function RGBData = fnGetHRRGB(inputVideoFileName, inputVideoFilePath)

inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName)
outputVideoFile = strcat('OutputVideos/', inputVideoFileName);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector('EyePairBig');

% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame) 
%bbox            = fnEliminateFalsePositives(bbox, 150);
%bbox            = bbox(1,:)

% forehead
bbox2WidthX     = round(bbox(1,3)/5); 
bbox2WidthY     = round(bbox(1,4)/3); 
bbox2OffsetY    = -bbox(4)-10-bbox2WidthY;
bbox2OffsetX    = round(bbox(1,3)/3);

bbox2           = [bbox(1)+bbox2OffsetX, bbox(2)+bbox(4)+bbox2OffsetY, bbox2WidthX, bbox2WidthY]; % ROI for heart rate measurement 
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox, 'Color', 'y', 'LineWidth', 4);
videoFrame      = insertShape(videoFrame, 'Rectangle', bbox2, 'Color', 'm', 'LineWidth', 2);
figure; imshow(videoFrame); title('Heart rate measurement');

RGBData = fnGetRGBAverage(inputVideoFile, bbox2, outputVideoFile);

