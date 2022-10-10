%function RGBFaceMapDATA = fnGetBPFaceMap(inputVideoFileName, inputVideoFilePath)
function [RGBFaceMapDATA, bbox] = fnGetBPFaceMap(inputVideoFileName, inputVideoFilePath)

load('GlobalVariables.mat')
inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName)
outputVideoFile = strcat('OutputVideos/', inputVideoFileName);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame);

bbox            = fnEliminateFalsePositives(bbox, 150);
bbox            = fnResizeHead2Face(bbox);
disp(char(10))
disp('******************')
disp('Demo video capture')
disp('******************')
disp(char(10))

%nX = 5; nY = 3;

fnImShowFaceMapPolygon(bbox2points(bbox), [GV.nX GV.nY], videoFrame, 0, inputVideoFileName);
RGBFaceMapDATA = fnGetRGBFaceMapData4BP(inputVideoFile, bbox, [GV.nX, GV.nY], outputVideoFile);
%RGBFaceMapDATA = fnGetRGBFaceMapData4BPDemo(inputVideoFile, bbox, [nX, nY], 5, 2);

