function dbl = create_init_img(img, sigma)

sig_diff = sqrt(sigma*sigma - 1);
dbl = imresize(img, 2, 'bicubic');
dbl = gaussian_smooth(dbl, sig_diff);
end