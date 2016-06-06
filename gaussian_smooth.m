function smooth_img = gaussian_smooth(img, sigma)

kernel_size = bitor(round(sigma*6 + 1), 1);
kernel = fspecial('gaussian', [kernel_size kernel_size], sigma);
smooth_img = imfilter(img,kernel,'replicate');

end