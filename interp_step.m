function X = interp_step(octv, intvl, r, c)

dD = deriv_3D(octv, intvl, r, c);
H = hessian_3D(octv, intvl, r, c);
X = H \ dD;