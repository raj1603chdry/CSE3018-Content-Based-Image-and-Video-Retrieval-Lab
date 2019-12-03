function[x] = getShapeStats(img)
% Function to return the shape features of the passed image

% Converting the test images into grayscale
img = im2bw(img, graythresh(img));

% Displaying the boundaries of the objects in the test image
% For test_image_1
[B, L] = bwboundaries(img);
figure;
imshow(img);
hold on;
for k=1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
end
% Using bwlabel to extract the objects, pseudocolor them and also associate
% a numerical value to them
[L, N] = bwlabel(img);
RGB = label2rgb(L, 'hsv', [.5 .5 .5], 'shuffle');
figure;
imshow(RGB);
hold on;
for k=1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2);
    text(boundary(1,2)-11, boundary(1,1)+11, num2str(k), 'Color', 'y', ...
        'FontSize', 14, 'FontWeight', 'bold');
end
% Extracting the region properties for img
stats = regionprops(L, 'all');
temp = zeros(1, N);
for k=1:N
    % Compute thinness ratio
    temp(k) = 4*pi*stats(k,1).Area / (stats(k,1).Perimeter)^2;
    stats(k,1).ThinnessRatio = temp(k);
    
    % Compute aspect ratio
    temp(k) = (stats(k, 1).BoundingBox(3)) / (stats(k,1).BoundingBox(4));
    stats(k,1).AspectRatio = temp(k);
end

% For the image
areas = zeros(1,N);
for k=1:N
    areas(k) = stats(k).Area;
end
TR = zeros(1,N);
for k=1:N
    TR(k) = stats(k).ThinnessRatio; 
end
figure(); 
hold on;
cmap = colormap(lines(16));
for k=1:N
    scatter(areas(k), TR(k), [], cmap(k,:), 'filled'), ylabel('Thinness Ratio'), xlabel('Area');
    hold on; 
end

x = stats;
return