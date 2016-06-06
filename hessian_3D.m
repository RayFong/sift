function H = hessian_3D(octv, intvl, r, c)
global dog_pyr

v = dog_pyr{octv, intvl}(r, c);
dxx = dog_pyr{octv, intvl}(r, c+1) + dog_pyr{octv, intvl}(r, c-1) - 2*v;
dyy = dog_pyr{octv, intvl}(r+1, c) + dog_pyr{octv, intvl}(r-1, c) - 2*v;
dss = dog_pyr{octv, intvl+1}(r, c) + dog_pyr{octv, intvl-1}(r, c) - 2*v;
dxy = (dog_pyr{octv, intvl}(r+1, c+1) - dog_pyr{octv, intvl}(r+1, c-1) - ...
    dog_pyr{octv, intvl}(r-1, c+1) + dog_pyr{octv, intvl}(r-1, c-1)) / 4.0;
dxs = (dog_pyr{octv, intvl+1}(r, c+1) - dog_pyr{octv, intvl+1}(r, c-1) - ...
    dog_pyr{octv, intvl-1}(r, c+1) + dog_pyr{octv, intvl-1}(r, c-1)) / 4.0;
dys = (dog_pyr{octv, intvl+1}(r+1, c) - dog_pyr{octv, intvl+1}(r-1, c) - ...
    dog_pyr{octv, intvl-1}(r+1, c) + dog_pyr{octv, intvl-1}(r-1, c)) / 4.0;
H = [dxx, dxy, dxs; dxy, dyy, dys; dxs, dys, dss];