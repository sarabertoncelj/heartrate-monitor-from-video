function rgbbrightness = fnGetBrightness(image, bbox)

image = im2double(image);

if nargin == 1
    rgbbrightness = [mean2(image(:,:,1)), mean2(image(:,:,2)), mean2(image(:,:,3))];
else
    rgbbrightness = [mean2(image(bbox(2):bbox(2)+bbox(4)-1,bbox(1):bbox(1)+bbox(3)-1,1)), mean2(image(bbox(2):bbox(2)+bbox(4)-1,bbox(1):bbox(1)+bbox(3)-1,2)), mean2(image(bbox(2):bbox(2)+bbox(4)-1,bbox(1):bbox(1)+bbox(3)-1,3))];
end

rgbbrightness = [rgbbrightness, 0.2126*rgbbrightness(1) + 0.7152*rgbbrightness(2) + 0.0722*rgbbrightness(3)];


