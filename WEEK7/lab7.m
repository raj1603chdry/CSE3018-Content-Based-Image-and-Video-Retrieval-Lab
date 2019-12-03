% Loading the test image and displaying its content
test_image_1 = imread('./images/TPTest1.png');
test_image_2 = imread('./images/TPTest2.png');
test_image_3 = imread('./images/TPTest3.png');

% Displaying the test images
imshow(test_image_1);
imshow(test_image_2);
imshow(test_image_3);

% Extracting the shape features for the images
test_image_1_stats = getShapeStats(test_image_1);
test_image_2_stats = getShapeStats(test_image_2);
test_image_3_stats = getShapeStats(test_image_3);

