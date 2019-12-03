% Reading images
D = './images';
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.

% Loading query image
query_image = imread('images/yellow7.jpg');
% Extracting colour planes of query image
q_red = single(query_image(:,:,1));
q_green = single(query_image(:,:,2));
q_blue = single(query_image(:,:,3));

% Table for storing the information for the images
info_table = cell2table(cell(0, 17), 'VariableNames', {'file_name', 'red_mean', 'red_std', 'red_var', 'red_skewness', 'red_kurtosis', ...
    'green_mean', 'green_std', 'green_var', 'green_skewness', 'green_kurtosis', 'blue_mean', 'blue_std', 'blue_var', 'blue_skewness', 'blue_kurtosis', 'euclidean_distance'});

% Looping through all the images in the directory
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    
    % Plotting the image with colour plane
    subplot(2, 3, 2);
    imagesc(I);
    title('Original image');
    subplot(2, 3, 4);
    imagesc(I(:,:,1));
    title('Red image');
    subplot(2, 3, 5);
    imagesc(I(:,:,2));
    title('Green image');
    subplot(2, 3, 6);
    imagesc(I(:,:,3));
    title('Blue image');
    
    S(k).data = I; % optional, save data.
    % Extracting the colour plane of the current image
    red = single(I(:, : , 1));
    green = single(I(:, :, 2));
    blue = single(I(:, :, 3));
    
    % Calculating the euclidean distance between the query image and the
    % current image.
    euclidean_distance = sqrt((mean(q_red(:)) - mean(red(:)))^2 + (std(q_red(:)) - std(red(:)))^2 + (var(q_red(:)) - var(red(:)))^2 + ...
        (skewness(q_red(:)) - skewness(red(:)))^2 + (kurtosis(q_red(:)) - kurtosis(red(:)))^2 + (mean(q_green(:)) - mean(green(:)))^2 + ...
        (std(q_green(:)) - std(green(:)))^2 + (var(q_green(:)) - var(green(:)))^2 + (skewness(q_green(:)) - skewness(green(:)))^2 + ...
        (kurtosis(q_green(:)) - kurtosis(green(:)))^2 + (mean(q_blue(:)) - mean(blue(:)))^2 + (std(q_blue(:)) - std(blue(:)))^2 + ...
        (var(q_blue(:)) - var(blue(:)))^2 + (skewness(q_blue(:)) - skewness(blue(:)))^2 + (kurtosis(q_blue(:)) - kurtosis(blue(:)))^2);

    % Creating the input of the current image
    new_row = {S(k).name, mean(red(:)), std(red(:)), var(red(:)), skewness(red(:)), kurtosis(red(:)), mean(green(:)), ...
        std(green(:)), var(green(:)), skewness(green(:)), kurtosis(green(:)), mean(blue(:)), std(blue(:)), var(blue(:)), ...
        skewness(blue(:)), kurtosis(blue(:)), euclidean_distance};
    
    % Appending the entry in the table
    info_table = [info_table;new_row];
end

% Replacing the NaN with values in the previous cell and replacing the 
% rows in the table in the ascending order of euclidean_distance
info_table = sortrows(fillmissing(info_table, 'previous'), 'euclidean_distance');
writetable(info_table, 'colour_plane_slicing.xls')

% Displaying the first 5 nearest image
subplot(1, 6, 1);
imagesc(query_image);
title('Query image');
file_names = info_table(:, 'file_name').file_name; % Extracting the filenames of the images
for i = 1:5
    F = fullfile(D,char(file_names(i)));
    I = imread(F);
    subplot(1, 6, i+1);
    imagesc(I);
    title(char(file_names(i)));
end
