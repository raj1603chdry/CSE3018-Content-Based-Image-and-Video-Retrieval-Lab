% Reading in the query image and extracting it's LBP features
query_image1 = imread('./textures/blotchy_0056.jpg');
query_image = rgb2gray(query_image1);
query_image_features = extractLBPFeatures(query_image);

% Initializing the path of the image base and getting the directory listing
D = './textures';
S = dir(fullfile(D, '*.jpg'));

% If the images are not already rotated, rotate them
if numel(S) == 10
    for k=1:numel(S)
        F = fullfile(D, S(k).name);
        I = imread(F);
        for degree=5:5:35
            I_rotated = imrotate(I, degree);
            filename = sprintf('%s/%d_%s', D, degree, S(k).name);
            imwrite(I_rotated, filename);
        end
    end
    % Reinitializing the directory listing
    S = dir(fullfile(D, '*.jpg'));
end

% Table to store the euclidean distance of each image from the query image
info_table = cell2table(cell(0, 2), 'VariableNames', {'file_name', 'euclidean_distance'});

% Calculating the euclidean distance between every image in the image base
% and the query image
for k=1:numel(S)
    F = fullfile(D, S(k).name);
    I = imread(F);
    I = rgb2gray(I);
    image_features = extractLBPFeatures(I);
    euclidean_distance = sqrt(sum((image_features - query_image_features).^2));
    new_row = {S(k).name, euclidean_distance};
    info_table = [info_table; new_row];
end

% Sorting the entries of the table based on ascending order of
% euclidean_distance
info_table = sortrows(info_table, 'euclidean_distance');
writetable(info_table, 'lbp_features.xls');

% Displaying the first 4 nearest image
subplot(3, 4, 2);
imshow(query_image1);
title('Query image');
file_names = info_table(:, 'file_name').file_name; % Extracting the filenames of the images
for i = 1:8
    F = fullfile(D,char(file_names(i)));
    I = imread(F);
    subplot(3, 4, i+4);
    imshow(I);
    title(char(file_names(i)));
end