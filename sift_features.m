function sift_features(img)

sigma = 1.6;
intvls = 3;
init_img = create_init_img(img, sigma);
%octvs = log(min(size(init_img))) / log(2) - 2;
octvs = 4;
build_gauss_pyr(init_img, octvs, intvls, sigma);
build_dog_pyr(octvs, intvls);

scale_space_extrema(octvs);
calc_feature_scales(sigma);
adjust_for_img_dbl();
calc_feature_oris();
compute_descriptors();