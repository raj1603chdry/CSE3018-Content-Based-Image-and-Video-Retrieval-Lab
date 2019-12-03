% Reading images
D = './images';
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.


% Defining the distance vector
distance_vector = [1, 3];


% Loading query image
query_image = imread('images/yellow7.jpg');
query_auto_correlogram = color_auto_correlogram(query_image, distance_vector);


% Creating the names of the columns of the xlsx file
names = {'file_name'};
for i=1:512
names{end+1} = sprintf('%s%d', 'feature', i);
end
names{end+1} = 'euclidean_distance';
names{end+1} = 'manhattan_distance';
% Table for storing the information for the images
info_table = cell2table(cell(0, 515), 'VariableNames', names);


% Looping through all the images in the directory
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);

    S(k).data = I; % optional, save data.
    
    auto_correlogram = color_auto_correlogram(I, distance_vector);
    
    % Calculating manhattan distance between current image and query image
    manhattan_distance = sum(abs(query_auto_correlogram - auto_correlogram));
    euclidean_distance = norm(query_auto_correlogram - auto_correlogram);
    
    % Creating the input of the current image
    new_row = {S(k).name};
    for i=1:numel(auto_correlogram)
       new_row{end+1} = auto_correlogram(i);
    end
    new_row{end+1} = manhattan_distance;
    new_row{end+1} = euclidean_distance;
    
    % Appending the entry in the table
    info_table = [info_table; new_row];
end


% Sorting the entries of the table based on ascending order of
% manhattan_distance
info_table = sortrows(info_table, 'manhattan_distance');
%writetable(info_table, 'color_correlogram_64_features.xls')


% Displaying the first 6 nearest image
subplot(3, 3, 2);
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
