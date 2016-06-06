function hist = smooth_ori_hist(hist)

n = size(hist, 1);
h1 = hist(1);
prev = hist(n);
for i = 1 : n
    tmp = hist(i);
    hist(i) = 0.25 * prev + 0.5 * hist(i);
    if i == n
        hist(i) = hist(i) + 0.25 * h1;
    else
        hist(i) = hist(i) + 0.25 * hist(i+1);
    end
    prev = tmp;
end