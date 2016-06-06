function build_gauss_pyr(base, octvs, intvls, sigma)
global gauss_pyr

gauss_pyr = cell(octvs, intvls+3);
sig = zeros(intvls+3, 1);

k = 2.0 ^ (1.0 / intvls);
sig(1) = sigma;
sig(2) = sigma * sqrt(k * k - 1);
for i = 3 : intvls+3
    sig(i) = sig(i-1) * k;
end

for o = 1 : octvs
    for i = 1 : intvls + 3
        if o == 1 && i == 1
            gauss_pyr{o, i} = base;
        elseif i == 1
            gauss_pyr{o, i} = imresize(gauss_pyr{o-1, intvls+1}, 0.5, 'nearest');
        else
            gauss_pyr{o, i} = gaussian_smooth(gauss_pyr{o, i-1}, sig(i));
        end
    end
end