# CSE3018 Content Based Image and Video Retrieval Lab

## WEEK10 - Implementing a CBIR system using LBP descriptors as features

### Available folder:

* _./textures/_ - Folder that contains the textures images.
* _./output/_ - Folder that contains sample outputs.

### Available files:

* _lab10.m_ - The script that reads all the textures and creates variations of it by rotating it for different degrees and then extracting the LBP features for all the textures. After calculating these features, the euclidean distance is found between all the textures and the query texture and stored in an excel file.
* *lbp_features.xls* - The excel file that contains the euclidean distance of the textures in the image base from the query texture.

### Sample output:

![output without rotation](./output/output_without_rotation.png)
![output with rotation](./output/output_with_rotation.png)
