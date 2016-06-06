function flag = is_too_edge_like(dog_img, r, c)

flag = 1;
curv_thr = 10;
d = dog_img(r, c);
dxx = dog_img(r, c+1) + dog_img(r, c-1) - 2*d;
dyy = dog_img(r+1, c) + dog_img(r-1, c) - 2*d;
dxy = (dog_img(r+1, c+1) - dog_img(r+1, c-1) - dog_img(r-1, c+1) + dog_img(r-1, c-1)) / 4.0;

tr = dxx + dxy;
det = dxx*dyy - dxy*dxy;

if det <= 0
    return;
end

if tr * tr / det < (curv_thr + 1.0) * (curv_thr + 1.0) / curv_thr
    flag = 0;
end