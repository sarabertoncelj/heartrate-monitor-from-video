function RGBData = fnGetRGBAverage(videoFile, bbox2, videoFileOut)

videoFileReader = vision.VideoFileReader(videoFile);
videoFrame      = step(videoFileReader); 
videoPlayer     = vision.VideoPlayer('Position', [100 100 [size(videoFrame, 2), size(videoFrame, 1)]]);

% save video result
if nargin == 3
    videoObject = VideoWriter(videoFileOut);
    open(videoObject)
end

RGBData = zeros(1000, 3);


% average color chanels values
RGBData(1,1)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),1)))/(bbox2(3)+1)/(bbox2(4)+1);
RGBData(1,2)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),2)))/(bbox2(3)+1)/(bbox2(4)+1);
RGBData(1,3)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),3)))/(bbox2(3)+1)/(bbox2(4)+1);

n = 2;

while ~isDone(videoFileReader)
    videoFrame        = step(videoFileReader);
         
    videoFrame  = insertShape(videoFrame, 'Rectangle', bbox2, 'Color', 'm', 'LineWidth', 2);            
      
    step(videoPlayer, videoFrame);
    if nargin == 3
        writeVideo(videoObject, videoFrame);
    end    
   
    RGBData(n, 1)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),1)))/(bbox2(3)+1)/(bbox2(4)+1);
    RGBData(n, 2)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),2)))/(bbox2(3)+1)/(bbox2(4)+1);
    RGBData(n, 3)   = sum(sum(videoFrame(bbox2(2):bbox2(2)+bbox2(4),bbox2(1):bbox2(1)+bbox2(3),3)))/(bbox2(3)+1)/(bbox2(4)+1);
    
    n = n + 1;
end

release(videoFileReader);
release(videoPlayer);

if nargin == 3
    close(videoObject)
end

RGBData = RGBData(1:n-1,:);


