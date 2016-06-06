function calc_feature_scales(sigma)
global features

n = size(features, 2);
for i = 1 : n
	feat = features{i};
	intvl = feat.intvl + feat.subintvl;
	feat.scl = sigma * (2.0 ^ (feat.octv-1 + (intvl-1) / 3));
	feat.scl_octv = sigma * (2.0 ^ ((intvl-1) / 3));
	features{i} = feat;
end
    