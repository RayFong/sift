function feat = interp_extremum(octv, intvl, r, c)
global dog_pyr

contr_thr = 0.04 / 3;
max_interp_steps = 5;
image_border = 5;
[height, width] = size(dog_pyr{octv, 1});

feat = NaN;
i = 0;
while i < max_interp_steps
    X = interp_step(octv, intvl, r, c);
    if all(X < 0.5)
        break;
    end
    
    c = c + round(X(1));
    r = r + round(X(2));
    intvl = intvl + round(X(3));
    
    if intvl <= 1 || intvl > 4 || c <= image_border || r <= image_border ...
            || c > width - image_border || r > height - image_border
        return
    end
    i = i + 1;
end

if i >= max_interp_steps
    return
end

contr = interp_contr(octv, intvl, r, c, X);
if abs(contr) < contr_thr
    return
end

feat = struct( ...
    'x', (c + X(1)) * (2.0 ^ (octv-1)), ...
    'y', (r + X(2)) * (2.0 ^ (octv-1)), ...
    'r', r, ...
    'c', c, ...
    'octv', octv, ...
    'intvl', intvl, ...
    'subintvl', X(3), ...
    'scl', [], ...
    'ori', [], ...
    'scl_octv', [], ...
    'descr', []);