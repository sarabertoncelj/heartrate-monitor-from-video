function LightIntesity = fnGetLightIntensity(inputVideoFileName, inputVideoFilePath)

inputVideoFile = strcat(inputVideoFilePath, inputVideoFileName);
videoFileReader = vision.VideoFileReader(inputVideoFile);
videoFrame      = step(videoFileReader);
% figure; imshow(videoFrame); title('Light Intensity');

LightIntesity = [mean(mean(videoFrame(:,:,1))) mean(mean(videoFrame(:,:,2))) mean(mean(videoFrame(:,:,3)))]; 
