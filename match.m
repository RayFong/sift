function num_matches = match(image1, image2)

% Find SIFT keypoints for each image
[im1, des1, loc1] = sift(image1);
[im2, des2, loc2] = sift(image2);

% For efficiency in Matlab, it is cheaper to compute dot products between
%  unit vectors rather than Euclidean distances.  Note that the ratio of 
%  angles (acos of dot products of unit vectors) is a close approximation
%  to the ratio of Euclidean distances for small angles.
%
% distRatio: Only keep matches in which the ratio of vector angles from the
%   nearest to second nearest neighbor is less than distRatio.
distRatio = 0.8;   

% For each descriptor in the first image, select its match to second image.
des2t = des2';                          % Precompute matrix transpose
num_matches = 0;
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        % Computes vector of dot products
   [vals,indx] = sort(acos(dotprods));  % Take inverse cosine and sort results

   % Check if nearest neighbor has angle less than distRatio times 2nd.
   if (vals(1) < distRatio * vals(2) || vals(1) < 0.2)
       num_matches = num_matches + 1;
      match(num_matches, :) = [i, indx(1)];
   end
end
fprintf('Before: %d\n', size(match, 1));

dThresh = 0.003 * max(size(im1));
inliers = estimateInliners(loc1(match(:, 1), 1:2), loc2(match(:, 2), 1:2), dThresh);
match = match(inliers, :);
num_matches = size(match, 1);

% Create a new image showing the two images side by side.
im3 = appendimages(im1,im2);

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
colormap('gray');
imagesc(im3);
hold on;
cols1 = size(im1,2);
for i = 1: num_matches
    line([loc1(match(i, 1),2) loc2(match(i, 2),2)+cols1], ...
         [loc1(match(i, 1),1) loc2(match(i, 2),1)], 'Color', 'c');
end
hold off;
fprintf('Found %d matches.\n', num_matches);
