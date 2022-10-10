function RGBPolyVariance = fnGetRGBPolyVariance(videoFrame, polygon)

BW = roipoly(videoFrame,polygon.x,polygon.y);
BW = double(BW);
BW(BW==0) = NaN;
%videoFrame_filt = videoFrame.*BW;
videoFrame_filt_red = videoFrame(:,:,1).*BW;
videoFrame_filt_green = videoFrame(:,:,2).*BW;
videoFrame_filt_blue = videoFrame(:,:,3).*BW;
        
RGBPolyVariance(1) = var(videoFrame_filt_red(~isnan(videoFrame_filt_red)));
RGBPolyVariance(2) = var(videoFrame_filt_green(~isnan(videoFrame_filt_green)));
RGBPolyVariance(3) = var(videoFrame_filt_blue(~isnan(videoFrame_filt_blue)));