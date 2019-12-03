function[energy, entropy, contrast, idm] = getGLCM(image_path, quantization_level)
% Function to return the energy, entropy, contrast and inverse difference
% moment after calculating the GLCM in vertical as well as horizontal
% direction for the given quantization level.

% Loading the image
img = imread(image_path);

% Converting the image to grayscale image
img = rgb2gray(img);

% Quantizing the image
steps = 256/quantization_level;
levels = steps:steps:256;
img = imquantize(img, levels);

% Finding the dimensions of the image
[s0, s1] = size(img);

% Creating the GLCM matrix
GLCM = zeros(quantization_level, quantization_level);

% Updating the GLCM for horizontal direction i.e. P0
for i=1:s0
    for j=1:s1
        if j ~= s1
            GLCM(img(i, j), img(i, j+1)) = GLCM(img(i, j), img(i, j+1)) + 1;
        end
    end
end

% Updating the GLCM for vertical direction i.e. P90
for j=1:s1
    for i=1:s0
        if i ~= s0
            GLCM(img(i, j), img(i+1, j)) = GLCM(img(i, j), img(i+1, j)) + 1;
        end
    end
end

% Normalizing the GLCM matrix
GLCM = GLCM ./ sum(GLCM(:));

% Finding the dimension of GLCM
[glcm0, glcm1] = size(GLCM);

% Calculating energy
temp = GLCM .^ 2;
energy = sum(temp(:));

% Calculating entropy
temp = GLCM .* log(GLCM);
temp(isnan(temp)) = 0;  % Converting NaN with 0 for finding the sum
entropy = -1 * sum(temp(:));

% Calculating contrast
contrast = 0;
for i=1:glcm0
    for j=1:glcm1
        contrast = contrast + ((i-j)^2 * GLCM(i, j));
    end
end

% Calculating Inverse Difference Moment
idm = 0;
for i=1:glcm0
    for j=1:glcm1
        idm = idm + (GLCM(i, j) / (1 + (i-j)^2));
    end
end

return