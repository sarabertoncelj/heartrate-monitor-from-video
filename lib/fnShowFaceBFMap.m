function fnShowFaceBFMap(inputVideoFileName, inputVideoFilePath, bbox, RGBFaceMapDATA, fHR, fs)

load('GlobalVariables.mat')

HRIntensity = fnGetFaceMapHRIntensityV2(RGBFaceMapDATA, fHR, fs);
HRIntensity = imgaussfilt(HRIntensity,0.7);

inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName);
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);

polygon.x = [bbox(1) bbox(1)+bbox(3) bbox(1)+bbox(3) bbox(1)];
polygon.y = [bbox(2) bbox(2) bbox(2)+bbox(4) bbox(2)+bbox(4)];
[PXY, Xnew, Ynew] = fnDividePoly(polygon,nX,nY);

videoFrameHR = ones(bbox4ThermMap(4), bbox4ThermMap(3),3);
for i = 2:GV.nX4FaceMap-1
    for j = 2:GV.nY4FaceMap-1
        bboxTempPoints(:,1) = PXY{i,j}.x;
        bboxTempPoints(:,2) = PXY{i,j}.y;
        bboxPolygonTemp = reshape(bboxTempPoints', 1, []);            
        videoFrame = insertShape(videoFrame, 'FilledPolygon', bboxPolygonTemp, 'Color', [HRIntensity(i, j), 0, (1-HRIntensity(i, j))/1.5], 'LineWidth', 2);
        videoFrameHR((j-1)*10+1:j*10,(i-1)*10+1:i*10,2) = 1-HRIntensity(i,j)*ones(bbox2WidthX,bbox2WidthY);
        videoFrameHR((j-1)*10+1:j*10,(i-1)*10+1:i*10,3) = 1-HRIntensity(i,j)*ones(bbox2WidthX,bbox2WidthY);
    end
end
