function [VideoFaceSF, polygons4BP, luminosity]  = fnGetMeasurementParameters(inputVideoFileName, inputVideoFilePath)

inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName);

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the face detector.
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);
luminosity = [mean(mean(videoFrame(:,:,1))) mean(mean(videoFrame(:,:,2))) mean(mean(videoFrame(:,:,3)))]
s_VF = size(videoFrame);
bbox            = step(faceDetector, videoFrame) 
%bbox = [304        2040        1402        1402];
%bbox = [450   330   650   650];
%bbox = [10   1000   950   950];
%bbox = [135        815         840         840];
%bbox = [1        405         720         720]; %DVurunic_1
%bbox = [155        975         770         770]; % JStrehovec_1
%bbox = [505        265         700         700]; % MFortunat_1
%bbox = [440 2130 1300 1300]; % NPrezelj_1 ali NPrezelj_2 
%bbox = [420 1930 1340 1340]; % NPrezelj_3
%bbox = [1150 70 1730 1730]; %MBevc_1
%bbox = [1020 110 1750 1750]; %MBevc_2
%bbox = [990 110 1750 1750]; %MBevc_3
bbox            = fnEliminateFalsePositives(bbox, 140);
bbox            = fnResizeHead2Face(bbox)
VideoFaceSF = [bbox(1,3)/s_VF(2) bbox(1,4)/s_VF(1)]
%bbox = [1350 550 1200 350];

nX = 9; nY = 10;
        
polygons4BP = fnImShowFaceMapPolygon(bbox2points(bbox), [nX nY], videoFrame, 1, inputVideoFileName);