function [img, des, loc] = sift(image)
global features

img = im2double(imread(image));
if length(size(img)) == 3
    img = rgb2gray(img);
end

sift_features(img);
n = size(features, 2);
des = zeros(n, 128);
loc = zeros(n, 4);

for i = 1 : n
    feat = features{i};
    des(i, :) = feat.descr;
    loc(i, :) = [feat.y, feat.x, feat.scl, feat.ori];
end

fprintf('Find Keypoints: %d\n', n);