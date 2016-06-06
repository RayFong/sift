function [newpts, T] = normalize(pts)
% 规范化变换
% （1）位移变换，使图像的原点位于图像点集的中心
% （2）放缩变换，使图像变换分布在以质心为圆心半径为sqrt(2)的圆内
% 输入：pts 图像点集 (M * [2/3])
% 输出： newpts 规范后的图像点集 (M * 2) 
%       T 变换矩阵

center = mean(pts(:, 1:2));
diff = pts(:, 1:2) - repmat(center, size(pts, 1), 1);
avgdist = mean(sqrt(diff(:, 1).^2 + diff(:, 2).^2));
scale = sqrt(2) / avgdist;
T = diag([scale, scale, 1]) * [eye(3, 2), [-center, 1]'];

newpts = pts;
newpts(:, 3) = 1;
newpts = newpts * T';
newpts = newpts ./ repmat( newpts(:,3), 1, 3);
newpts(:,3) = [];
