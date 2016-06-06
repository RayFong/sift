function bestInliers = estimateInliners(pts1, pts2, dThresh)
% ����ƥ��㼯pts1��pts2���ڵ㣬�޳�ƥ�����ĵ�
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
    % ���ѡȡ�˶�ƥ���
    samples = randperm(size(pts1, 1));
    samples = samples(1:8);
    samplesTaken = samplesTaken + 1;
    
    % ͨ���˵��㷨�����������
    F = getF8pt(pts1(samples, :), pts2(samples, :));
    
    % ���㼫�ߣ����������
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
        
        % ����Ӧ���µ�������
        e = 1 - inlierCount / size( pts1,1 );
        if e > 0
            N = log(1 - p)/log(1 - (1 - e)^s);
        else
            N = 1;
        end 
    end
    
    %fprintf('iteration:%d inliers: %d N: %d re:%f\n', samplesTaken, maxInliers, N, bestResErr);
end