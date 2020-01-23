# CSE3018 Content Based Image and Video Retrieval Lab

## WEEK1 - Finding euclidean distance between images using width and height as features

### Available folders:

* _./images/_ - Folder that contains the images belonging to two different categories. (Based on the extensions of the images, the regex for the filepath should be modified).
* _./query/_ - Folder that contains the query image used to test the system.

### Available files:

* _lab1.m_ - The script that reads all the images in the image base and calculates the width and height of these images. After the calculation of the dimensions, the euclidean distance of each of these images is calculated from the query image and stored in a xls file.
* _image_information.xls_ - The excel file the contains the dimensions of each image in the image base along with the euclidean distance of the image from the query image.
