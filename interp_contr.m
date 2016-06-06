function val = interp_contr(octv, intvl, r, c, X)
global dog_pyr

dD = deriv_3D(octv, intvl, r, c);
t = dD' * X;
val = dog_pyr{octv, intvl}(r, c) + t * 0.5;