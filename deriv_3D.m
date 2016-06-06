function dI = deriv_3D(octv, intvl, r, c)
global dog_pyr

dx = (dog_pyr{octv, intvl}(r, c+1) - dog_pyr{octv, intvl}(r, c-1)) / 2;
dy = (dog_pyr{octv, intvl}(r+1, c) - dog_pyr{octv, intvl}(r-1, c)) / 2;
ds = (dog_pyr{octv, intvl+1}(r, c) - dog_pyr{octv, intvl-1}(r, c)) / 2;
dI = [dx; dy; ds];