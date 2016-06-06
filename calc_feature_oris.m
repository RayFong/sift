function calc_feature_oris()
global features gauss_pyr

SIFT_ORI_HIST_BINS = 36;
SIFT_ORI_PEAK_RATIO = 0.8;
PI2 = pi * 2;

good_features = {};
feat_idx = 1;
n = size(features, 2);
for i = 1 : n
    feat = features{i};
    hist = ori_hist(gauss_pyr{feat.octv, feat.intvl}, feat.r, feat.c, 36, round(4.5*feat.scl_octv), 1.5*feat.scl_octv);
    for j = 1 : 2
        hist = smooth_ori_hist(hist);
    end
    mag_thr = max(hist) * SIFT_ORI_PEAK_RATIO;
    
    for j = 1 : SIFT_ORI_HIST_BINS
        if j == 1, l = SIFT_ORI_HIST_BINS; else l = j-1; end
        if j == SIFT_ORI_HIST_BINS, r = 1; else r = j+1; end
		if hist(j) > hist(l) && hist(j) > hist(r) && hist(j) > mag_thr
			bin = j + 0.5 * (hist(l) - hist(r)) / (1 + hist(r) - 2 * hist(j));
			if bin < 0, bin = bin + SIFT_ORI_HIST_BINS; end;
			if bin >= SIFT_ORI_HIST_BINS, bin = bin - SIFT_ORI_HIST_BINS; end;
			feat.ori = ( ( PI2 * bin ) / SIFT_ORI_HIST_BINS ) - pi;
			good_features{feat_idx} = feat;
			feat_idx = feat_idx + 1;
		end
    end
end

features = good_features;