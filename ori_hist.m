function hist = ori_hist(img, r, c, n, rad, sigma)

PI2 = pi * 2;
exp_denom = 2.0 * sigma * sigma;
hist = zeros(n, 1);
[height, width] = size(img);

for i = -rad : rad
    for j = -rad : rad
        if r+i > 1 && r+i < height && c+j > 1 && c+j < width
            [mag, ori] = calc_grad_mag_ori(img, r+i, c+j);
            w = exp(-(i*i + j*j)/ exp_denom);
            bin = round(n*(ori+pi)/PI2);
            if bin == 0
                bin = n;
            end
            hist(bin) = hist(bin) + w *mag;
        end
    end
end