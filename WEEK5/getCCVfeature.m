function[x] = getCCVfeature(image_path)
% Function to return the Color Coherence Vector for the image at
% source given by image_path
% image_path = './query/query.jpg';
% Loading the image
image = imread(image_path);

% Reducing the size of image to speed up the processing speed
image = imresize(image, [50, 50]);

% Converting to grayscale image
img = rgb2gray(image);

% Applying gaussian filter on image to blur the image
img = imgaussfilt(img, 2);

% Quantizing the image for 16 levels
steps = 256/16;
levels = steps:steps:256;
img = imquantize(img, levels);

% Creating table for storing the feature vector
T = cell2table(cell(0, 2), 'VariableNames', {'Intensity', 'Frequency'});

% Finding the patches
[s0, s1] = size(img);
CCV = zeros(16, 3);
for i=1:16
    CCV(i, 1) = i;
end
VISITED = zeros(s0, s1);    % To keep track of visited pixels
for i=1:s0
    for j=1:s1
        if VISITED(i, j) == 1
            continue
        else
            [ni, nv] = getCCV(img, i, j, VISITED);
%             disp(i+" "+j+" value: "+img(i, j)+" "+ni);
            VISITED = nv;
        end
        newrow = {img(i, j), ni};
        T = [T;newrow];
    end
end

% Defining the value of tao
tao = 250;

% Creating the CCV
for i=1:size(T, 1)
    if (T{i, 2} >= tao)
        CCV(T{i, 1}, 2) = CCV(T{i, 1}, 2) + T{i, 2};
    else
        CCV(T{i, 1}, 3) = CCV(T{i, 1}, 3) + T{i, 2};
    end
end
ccv_feature = {};
for i=1:size(CCV, 1)
   ccv_feature = [ccv_feature, CCV(i, 2), CCV(i, 3)]; 
end

% Returning the result
x = ccv_feature;
return