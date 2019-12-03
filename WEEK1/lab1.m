% Reading images
D = './images';
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.

% Loading query image
query_image = imread('query/query.jpg');
% Extracting the features of the query image
[q_height, q_width, channel] = size(query_image);

% Table for storing the information for the images
info_table = cell2table(cell(0, 4), 'VariableNames', {'file_name', 'height', 'width', 'euclidean_distance'});

% Looping through all the images in the directory
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    imshow(I)
    S(k).data = I; % optional, save data.
    
    % Extracting the features of the current image
    [height, width, channel] = size(I);
    
    % Calculating euclidean distance between the current image and query image
    euclidean_distance = sqrt((height-q_height)^2 + (width-q_width)^2);
    
    % Creating the input of the current image
    new_row = {S(k).name, height, width, euclidean_distance};
    
    % Appending the entry in the table
    info_table = [info_table;new_row];
end

% Storing the dimension and euclidean distance
writetable(info_table, 'image_information.xls')
