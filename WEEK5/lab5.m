% Program to calculate the Color Coherence Vector of the query image and
% images in the image base and display the 6 nearest image to the query
% image based on the euclidean image

% Path of query image
query_image_path = './query/query.jpg';

% Creating the names of columns for the xls file
names = {'file_name'};
for i=1:16
names{end+1} = sprintf('%s%d', 'coherent', i);
names{end+1} = sprintf('%s%d', 'non_coherent', i);
end
names{end+1} = 'euclidean_distance';
info_table = cell2table(cell(0, size(names,2)), 'VariableNames', names);

% Getting the ccv feature vector for the query image
query_ccv_feature = getCCVfeature(query_image_path);

% Reading the images of textures from the image base
D = './images';
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.

% Looping through all the images in the directory
for k=1:numel(S)
    image_path = fullfile(D, S(k).name);
    image_ccv_feature = getCCVfeature(image_path);
    
    % Calculating the euclidean distance between the image and the query
    % image
    euclidean_distance = pdist([cell2mat(image_ccv_feature); cell2mat(query_ccv_feature)]);
    image_feature = [S(k).name, image_ccv_feature, euclidean_distance];
    % Appending the result in the table
    info_table = [info_table; image_feature];
   
end

% Sorting the entries of the table based on ascending order of
% euclidean_distance
info_table = sortrows(info_table, 'euclidean_distance');
writetable(info_table, 'ccv.xls');

% Displaying the first 6 nearest image
subplot(3, 3, 2);
query_image = imread(query_image_path);
imshow(query_image);
title('Query image');
file_names = info_table(:, 'file_name').file_name; % Extracting the filenames of the images
for i = 1:6
    F = fullfile(D,char(file_names(i)));
    I = imread(F);
    subplot(3, 3, i+3);
    imshow(I);
    title(char(file_names(i)));
end
