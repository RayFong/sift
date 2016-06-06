function [newpts, T] = normalize(pts)
% �淶���任
% ��1��λ�Ʊ任��ʹͼ���ԭ��λ��ͼ��㼯������
% ��2�������任��ʹͼ��任�ֲ���������ΪԲ�İ뾶Ϊsqrt(2)��Բ��
% ���룺pts ͼ��㼯 (M * [2/3])
% ����� newpts �淶���ͼ��㼯 (M * 2) 
%       T �任����

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
