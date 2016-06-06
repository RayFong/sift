function [mag, ori] = calc_grad_mag_ori(img, r, c)

dx = img(r, c+1) - img(r, c-1);
dy = img(r-1, c) - img(r+1, c);

mag = sqrt(dx*dx + dy*dy);
ori = atan2(dy, dx);