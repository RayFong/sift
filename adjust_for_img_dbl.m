function adjust_for_img_dbl()
global features

n = size(features, 2);
for i = 1 : n
	feat = features{i};
	feat.x = feat.x / 2;
	feat.y = feat.y / 2;
	feat.scl = feat.scl / 2;
	features{i} = feat;
end