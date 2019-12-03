% Declaring the quantization levels
quantization_levels = [8, 16, 32, 64];

% Creating the names of columns for the xls file
names = {'file_name'};
for i=1:numel(quantization_levels)
names{end+1} = sprintf('%s%d', 'energy', quantization_levels(i));
names{end+1} = sprintf('%s%d', 'entropy', quantization_levels(i));
names{end+1} = sprintf('%s%d', 'contrast', quantization_levels(i));
names{end+1} = sprintf('%s%d', 'idm', quantization_levels(i));
end
names{end+1} = 'euclidean_distance';
info_table = cell2table(cell(0, size(names,2)), 'VariableNames', names);

% Reading the query image
query_image_path = './query_texture/query.tif';

% Getting the GLCM features of the query image
query_image_feature = {};
for i=1:numel(quantization_levels)
    % Getting the GLCM
   [energy, entropy, contrast, idm] = getGLCM(query_image_path, quantization_levels(i));
   % Appending the results to feature vector
   query_image_feature = [query_image_feature, energy, entropy, contrast, idm];
end

% Reading the images of textures from the image base
D = './textures';
S = dir(fullfile(D,'*.tif')); % pattern to match filenames.

% Looping through all the images in the directory
for k=1:numel(S)
    F = fullfile(D, S(k).name);

    image_feature = {};
    % Extracting the GLCM features for each quantization level
    for i=1:numel(quantization_levels)
        % Getting the GLCM
        [energy, entropy, contrast, idm] = getGLCM(F, quantization_levels(i));

        % Appending the results to the feature_vector
        image_feature = [image_feature, energy, entropy, contrast, idm];
    end
    
    % Calculating the euclidean distance between the current image and the
    % query image
    euclidean_distance = pdist([cell2mat(image_feature); cell2mat(query_image_feature)]); 
    
    % Adding the name of the image and the euclidean distance from the
    % query image in the information table
    image_feature = [S(k).name, image_feature, euclidean_distance];
    % Appending the result in table
    info_table = [info_table; image_feature];
end

% Sorting the entries of the table based on ascending order of
% euclidean_distance
info_table = sortrows(info_table, 'euclidean_distance');
writetable(info_table, 'glcm_features.xls');

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