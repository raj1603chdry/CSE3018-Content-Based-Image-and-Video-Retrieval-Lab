% Reading images
D = './images';
S = dir(fullfile(D,'*.jpg')); % pattern to match filenames.


% Creating the brackets for quantization
bins = 7:8:255;


% Loading query image
query_image1 = imread('images/blue7.jpg');
query_image = rgb2gray(query_image1);


% Extracting the quantized features for the query image
[counts, binLocations] = imhist(query_image);

intensity_quantized = quantiz(binLocations, bins);

intensity_query = zeros(1, 32);

for i = 1:numel(intensity_quantized)
    idx = intensity_quantized(i) + 1;
    intensity_query(idx) = intensity_query(idx) + counts(i);
end


% Creating the names of the columns of the xlsx file
names = {'file_name'};
for i=1:32
names{end+1} = sprintf('%s%d', 'feature', i);
end
names{end+1} = 'euclidean_distance';
% Table for storing the information for the images
info_table = cell2table(cell(0, 34), 'VariableNames', names);


% Looping through all the images in the directory
for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    
    % Converting the image from RGB to GRAYSCALE
    I = rgb2gray(I);
    imshow(I);
    
    % Extracting the features i.e the intensity values and corresponding
    % count of the frequency of the image
    [counts, binLocations] = imhist(I);
    
    % Creating the bin limits for quantizing the intensity values into 32
    % frequency brackets
    intensity_quantized = quantiz(binLocations, bins);
    
    % Creating a vector of zeros for storing the total count of frequency
    % for each intensity bin
    intensity_bin = zeros(1, 32);
    
    for i = 1:numel(intensity_quantized)
        idx = intensity_quantized(i) + 1;
        intensity_bin(idx) = intensity_bin(idx) + counts(i);
    end
    S(k).data = I; % optional, save data.
    
    % Calculating euclidean distance between current image and query image
    euclidean_distance = norm(intensity_query - intensity_bin);
    
    % Creating the input of the current image
    new_row = {S(k).name};
    for i=1:numel(intensity_bin)
       new_row{end+1} = intensity_bin(i);
    end
    new_row{end+1} = euclidean_distance;
    
    % Appending the entry in the table
    info_table = [info_table; new_row];
end


% Sorting the entries of the table based on ascending order of
% euclidean_distance
info_table = sortrows(info_table, 'euclidean_distance');
writetable(info_table, 'histogram.xls')


% Displaying the first 6 nearest image in RGB
subplot(3, 3, 2);
imshow(query_image1);
title('Query image');
file_names = info_table(:, 'file_name').file_name; % Extracting the filenames of the images
for i = 1:6
    F = fullfile(D,char(file_names(i)));
    I = imread(F);
    subplot(3, 3, i+3);
    imshow(I);
    title(char(file_names(i)));
end
