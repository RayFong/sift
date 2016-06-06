function bestInliers = estimateInliners(pts1, pts2, dThresh)
% 分析匹配点集pts1和pts2中内点，剔除匹配错误的点
% pts1: M * 2
% pts2: M * 2

% dThresh = 1.5;
e = .60;                % outlier probability              
p = .99;
s = 8;
N = log(1 - p)/log(1 - (1 - e)^s);
samplesTaken = 0;
bestResErr = Inf;
maxInliers = 0;

pts1(:, 3) = 1;
pts2(:, 3) = 1;

fprintf('-----RANSAC-----\n');
fprintf('Distance threshold: %f\n', dThresh );

while samplesTaken < N
    % 随机选取八对匹配点
    samples = randperm(size(pts1, 1));
    samples = samples(1:8);
    samplesTaken = samplesTaken + 1;
    
    % 通过八点算法计算基本矩阵
    F = getF8pt(pts1(samples, :), pts2(samples, :));
    
    % 计算极线，并计算误差
    L1 =  normalizeLine(F * pts1');
    dist1 = abs(dot(pts2', L1));
    
    L2 =  normalizeLine(F' * pts2');
    dist2 = abs(dot(pts1', L2));
    
    inliers = find( dist1 < dThresh & dist2 < dThresh );
    inlierCount = size(inliers,2);            
    if inlierCount > 0
        resErr = sum( dist1(inliers).^2 + dist2(inliers).^2 ) / inlierCount;
    else
        resErr = Inf;
    end
    
    if inlierCount > maxInliers || (inlierCount == maxInliers && resErr < bestResErr)
        maxInliers = inlierCount;
        bestResErr = resErr;
        bestInliers = inliers;
        
        % 自适应更新迭代次数
        e = 1 - inlierCount / size( pts1,1 );
        if e > 0
            N = log(1 - p)/log(1 - (1 - e)^s);
        else
            N = 1;
        end 
    end
    
    %fprintf('iteration:%d inliers: %d N: %d re:%f\n', samplesTaken, maxInliers, N, bestResErr);
end