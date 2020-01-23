# CSE3018 Content Based Image and Video Retrieval Lab

## WEEK2 - Implementing a CBIR system using statistical features extracted from color as features

### Available folder:

* _./images/_ - Folder that contains the images belonging to two different categories. (Based on the extensions of the images, the regex for the filepath should be modified).
* _./query/_ - Folder that contains the query image used to test the system.
* -./output/_ - Folder that contains sample outputs.

### Available files:

* _lab2.m_ - The script that reads all the images in the image base and calculates the specified statistical features for the three color channels (i.e. red, green and blue) of these images. After the calculation of these features, the euclidean distance of each of these images is calculated from the query image and stored in a xls file.
* *colour_plane_slicing.xls* - The excel file that contains the statistical features for all the color channels of each image in the image base along with the euclidean distance of the image from the query image.

### Sample output:

![output with blue query image](./output/blue_query_image.png)
![output with yellow query image](./output/yellow_query_image.png)
