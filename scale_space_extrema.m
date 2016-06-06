function scale_space_extrema(octvs)
global features dog_pyr
% intvls = 3

prelim_contr_thr = 0.5 * 0.04 / 3;
image_border = 5;
features = {};
feat_idx = 1;

for o = 1 : octvs
    [height, width] = size(dog_pyr{o, 1});
    for i = 2 : 4
        for r = image_border+1 : height - image_border
            for c = image_border+1 : width - image_border
                if abs(dog_pyr{o, i}(r, c)) > prelim_contr_thr
                    if is_extremum(o, i, r, c)
                        feat = interp_extremum(o, i, r, c);
                        if isstruct(feat)
                            if is_too_edge_like(dog_pyr{feat.octv, feat.intvl}, feat.r, feat.c) == 0
                                features{feat_idx} = feat;
                                feat_idx = feat_idx + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end
                           