function compute_descriptors()
global gauss_pyr features

% SIFT_DESCR_WIDTH = 4;
% SIFT_DESCR_HIST_BINS = 8;
SIFT_DESCR_MAG_THR = 0.2;

n = size(features, 2);
for i = 1 : n
	feat = features{i};
	hist = descr_hist(gauss_pyr{feat.octv, feat.intvl}, feat.r, feat.c, feat.ori, feat.scl_octv);
	feat.descr = reshape(hist, 1, 128);
	
	len_inv = 1.0 / norm(feat.descr);
	feat.descr = feat.descr * len_inv;
	
	idx = feat.descr > SIFT_DESCR_MAG_THR;
    feat.descr(idx) = SIFT_DESCR_MAG_THR;
    
	len_inv = 1.0 / norm(feat.descr);
    feat.descr = feat.descr * len_inv;
    features{i} = feat;
end