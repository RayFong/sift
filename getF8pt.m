function F = getF8pt(pts1, pts2)
% 从pts1和pts2的起始的八个点获取基本矩阵
% pts1: N * 2
% pts2: M * 2

% 对pts1和pts2做规范化
[img1pts, T1] = normalize(pts1(1:8, :));
[img2pts, T2] = normalize(pts2(1:8, :));

x = img1pts(:, 1);
y = img1pts(:, 2);
u = img2pts(:, 1);
v = img2pts(:, 2);

A = [x.*u, y.*u, u, x.*v, y.*v, v, x, y, ones(8, 1)];
[~, ~, V] = svd(A, 0);
f = V(:,end);
F = reshape( f,[3 3])';

% enforce the singularity constraint
[U,D,V] = svd(F);
D(3,3) = 0;             % force to zero to satisfy Frobenius norm'
D = D / D(1,1);         % scale 
F = U * D * V';

%denormalize
F = T2' * F * T1;