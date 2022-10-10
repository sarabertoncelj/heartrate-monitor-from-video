function RGBPolyMean = fnGetRGBPolyMean(videoFrame, polygon)

videoFrame = imgaussfilt(double(videoFrame),5);
BW = roipoly(videoFrame,polygon.x,polygon.y);
BW = double(BW);
BW(BW==0) = NaN;
%videoFrame_filt = videoFrame.*BW;
videoFrame_filt_red = videoFrame(:,:,1).*BW;
videoFrame_filt_green = videoFrame(:,:,2).*BW;
videoFrame_filt_blue = videoFrame(:,:,3).*BW;
        
RGBPolyMean(1)  = mean(videoFrame_filt_red(~isnan(videoFrame_filt_red)));
RGBPolyMean(2) = mean(videoFrame_filt_green(~isnan(videoFrame_filt_green)));
RGBPolyMean(3) = mean(videoFrame_filt_blue(~isnan(videoFrame_filt_blue)));
