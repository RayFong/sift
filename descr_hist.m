function hist = descr_hist(img, r, c, ori, scl)
% d is SIFT_DESCR_WIDTH, n is SIFT_DESCR_HIST_BINS

SIFT_DESCR_WIDTH = 4;
SIFT_DESCR_HIST_BINS = 8;
SIFT_DESCR_SCL_FCTR = 3.0;
PI2 = 2.0 * pi;

hist = zeros([SIFT_DESCR_WIDTH, SIFT_DESCR_WIDTH, SIFT_DESCR_HIST_BINS]);

cos_t = cos(ori);
sin_t = sin(ori);
bins_per_rad = SIFT_DESCR_HIST_BINS / PI2;
exp_denom = SIFT_DESCR_HIST_BINS * SIFT_DESCR_HIST_BINS * 0.5;
hist_width = SIFT_DESCR_SCL_FCTR * scl;
radius = round(hist_width * sqrt(2) * (SIFT_DESCR_WIDTH + 1.0) * 0.5 + 0.5);
[height, width] = size(img);
for i = -radius : radius
	for j = -radius : radius
		c_rot = (j * cos_t - i * sin_t) / hist_width;
		r_rot = (j * sin_t + i * cos_t) / hist_width;
		rbin = r_rot + 1.5;
		cbin = c_rot + 1.5;
		if rbin > -1.0 && rbin < SIFT_DESCR_WIDTH && cbin > -1.0 && cbin < SIFT_DESCR_WIDTH
			if r+i <= 1 || r+i >= height || c+j <= 1 || c+j >= width, continue; end
			[grad_mag, grad_ori] = calc_grad_mag_ori(img, r+i, c+j);
			grad_ori = grad_ori - ori;
			while(grad_ori < 0.0), grad_ori = grad_ori + PI2; end
			while(grad_ori >= PI2), grad_ori = grad_ori - PI2; end
			
			obin = grad_ori * bins_per_rad;
			w = exp(-(c_rot * c_rot + r_rot * r_rot) / exp_denom);
			
			r0 = floor(rbin);
			c0 = floor(cbin);
			o0 = floor(obin);
			d_r = rbin - r0;
			d_c = cbin - c0;
			d_o = obin - o0;
			
			for r = 0 : 1
				rb = r0 + r;
				if rb < 0 || rb >= SIFT_DESCR_WIDTH, continue; end;
				if r == 0, v_r = grad_mag * (1.0 - d_r); else v_r = grad_mag * d_r; end
				for c = 0 : 1
					cb = c0 + c;
					if cb < 0 || cb >= SIFT_DESCR_WIDTH, continue; end;
					if c == 0, v_c = v_r * (1.0 - d_c); else v_c = v_r * d_c; end
					for o = 0 : 1
						ob = mod(o0 + o, SIFT_DESCR_HIST_BINS);
						if o == 0, v_o = v_c * (1.0 - d_o); else v_o = v_c * d_o; end
						hist(rb+1, cb+1, ob+1) = hist(rb+1, cb+1, ob+1) + v_o;
					end
				end
			end
		end
	end
end